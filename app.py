from flask import Flask, render_template, request, redirect, flash, send_file, session, url_for
import sqlite3
import os
import hashlib
from datetime import datetime
from werkzeug.utils import secure_filename
from functools import wraps

# Configuración Flask
app = Flask(__name__)
app.secret_key = "clave_secreta_itc"
UPLOAD_FOLDER = "static/artefactos"
ALLOWED_EXTENSIONS = {"zip"}

def get_conn():
    return sqlite3.connect("artefactos.db")

def hash_sha256(texto):
    return hashlib.sha256(texto.encode("utf-8")).hexdigest()

def archivo_permitido(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS

os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Decorador para requerir login en las rutas protegidas
from functools import wraps
def login_requerido(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if "usuario" not in session:
            flash("Debe iniciar sesión para acceder al sistema.")
            return redirect(url_for("login"))
        return func(*args, **kwargs)
    return wrapper

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        usuario = request.form.get("usuario", "").strip().upper()
        contrasena = request.form.get("contrasena", "").strip()

        conn = get_conn()
        cursor = conn.cursor()
        cursor.execute("SELECT contrasena, nombres, apellidos, rol FROM USUARIO WHERE ID_usuario = ?", (usuario,))
        row = cursor.fetchone()
        conn.close()

        if not row:
            flash("Usuario no encontrado.")
            return redirect("/login")

        hash_almacenado, nombres, apellidos, rol = row
        hash_ingresado = hash_sha256(contrasena)

        if hash_ingresado != hash_almacenado:
            flash("Contraseña incorrecta.")
            return redirect("/login")

        # Guardar sesión
        session["usuario"] = {
            "id": usuario,
            "nombre": f"{nombres} {apellidos}",
            "rol": rol
        }

        return redirect("/")

    return render_template("login.html")

@app.route("/logout")
@login_requerido
def logout():
    session.pop("usuario", None)
    flash("Sesión finalizada correctamente.")
    return redirect("/login")

@app.route("/")
@login_requerido
def home():
    usuario = session["usuario"]
    modulos = [
        {"nombre": "Contabilidad", "prefijo": "CN"},
        {"nombre": "Tesorería", "prefijo": "TE"},
        {"nombre": "SARLAFT", "prefijo": "SF"},
        {"nombre": "General", "prefijo": "GE"},
    ]
    return render_template("home.html", usuario=usuario, modulos=modulos)

@app.route("/artefactos/<prefijo>")
@login_requerido
def listar_artefactos(prefijo):
    orden = request.args.get("orden", "fecha")
    conn = get_conn()
    cursor = conn.cursor()

    order_by = "A.ID_archivo ASC" if orden == "nombre" else "V.fecha_cambio DESC"

    cursor.execute(f"""
        SELECT A.ID_archivo, A.descripcion, V.version, V.usuario, V.fecha_cambio
        FROM ARCHIVO A
        JOIN VERSIONAMIENTO V ON A.ID_archivo = V.ID_archivo
        WHERE UPPER(A.ID_archivo) LIKE UPPER(?) || '%'
        AND V.version = (
            SELECT MAX(V2.version)
            FROM VERSIONAMIENTO V2
            WHERE V2.ID_archivo = A.ID_archivo
        )
        ORDER BY {order_by}
    """, (prefijo,))
    artefactos = cursor.fetchall()
    conn.close()

    return render_template("listado.html", artefactos=artefactos, prefijo=prefijo, orden=orden, usuario=session["usuario"])

@app.route("/detalle/<id_archivo>")
@login_requerido
def detalle_artefacto(id_archivo):
    conn = get_conn()
    cursor = conn.cursor()

    cursor.execute("SELECT descripcion, ruta FROM ARCHIVO WHERE ID_archivo = ?", (id_archivo,))
    archivo = cursor.fetchone()

    cursor.execute("""
        SELECT version, descripcion, usuario, fecha_cambio
        FROM VERSIONAMIENTO
        WHERE ID_archivo = ?
        ORDER BY version DESC
    """, (id_archivo,))
    versiones = cursor.fetchall()
    conn.close()

    prefijo = id_archivo[:2].upper()

    return render_template("detalle.html", id_archivo=id_archivo, archivo=archivo, versiones=versiones, prefijo=prefijo, usuario=session["usuario"])

@app.route("/descargar/<id_archivo>")
@login_requerido
def descargar_archivo(id_archivo):
    conn = get_conn()
    cursor = conn.cursor()
    cursor.execute("SELECT ruta FROM ARCHIVO WHERE ID_archivo = ?", (id_archivo,))
    result = cursor.fetchone()
    conn.close()
    if result and os.path.exists(result[0]):
        return send_file(result[0], as_attachment=True)
    return redirect(f"/detalle/{id_archivo}")

def registrar():
    if session["usuario"]["rol"] == "L":
        flash("No tiene permisos para registrar artefactos.")
        return redirect("/")

    if request.method == "POST":
        nombre = request.form.get("nombre", "").strip().upper()
        version = 1000
        descripcion = request.form.get("descripcion", "").strip()
        archivo = request.files.get("archivo")
        usuario_id = session["usuario"]["id"]

        if not nombre or not descripcion:
            flash("Los campos 'Nombre' y 'Descripción' son obligatorios.")
            return redirect("/registrar")

        if not (
            nombre.startswith("CN_Z") or nombre.startswith("GE_Z") or
            nombre.startswith("TE_Z") or nombre.startswith("SF_Z")
        ):
            flash("El nombre del artefacto debe comenzar por CN_Z, GE_Z, TE_Z o SF_Z.")
            return redirect("/registrar")

        if not archivo or archivo.filename == "":
            flash("Debe seleccionar un archivo .zip.")
            return redirect("/registrar")

        if not archivo_permitido(archivo.filename):
            flash("Formato inválido: solo se permiten archivos .zip.")
            return redirect("/registrar")

        filename = secure_filename(archivo.filename)
        ruta_guardada = os.path.join(UPLOAD_FOLDER, filename)
        archivo.save(ruta_guardada)

        conn = get_conn()
        cursor = conn.cursor()
        cursor.execute("SELECT 1 FROM ARCHIVO WHERE ID_archivo = ?", (nombre,))
        if cursor.fetchone():
            flash("Ya existe un artefacto con ese nombre.")
            conn.close()
            return redirect("/registrar")

        cursor.execute("INSERT INTO ARCHIVO (ID_archivo, ruta, descripcion) VALUES (?, ?, ?)", (nombre, ruta_guardada, descripcion))
        cursor.execute("""
            INSERT INTO VERSIONAMIENTO (ID_archivo, version, descripcion, usuario, fecha_cambio)
            VALUES (?, ?, ?, ?, ?)
        """, (nombre, version, descripcion, usuario_id, datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
        conn.commit()
        conn.close()

        flash("Artefacto registrado correctamente.")
        return redirect("/registrar")

    return render_template("registrar.html", usuario=session["usuario"])

@app.route("/editar/<id_archivo>", methods=["GET", "POST"])
@login_requerido
def editar_artefacto(id_archivo):
    # Validar permisos de edición
    if session["usuario"]["rol"] == "L":
        return redirect(f"/detalle/{id_archivo}")

    conn = get_conn()
    cursor = conn.cursor()

    # Obtener datos actuales
    cursor.execute("SELECT descripcion, ruta FROM ARCHIVO WHERE ID_archivo = ?", (id_archivo,))
    archivo = cursor.fetchone()
    if not archivo:
        conn.close()
        return redirect("/")

    descripcion_actual, ruta_actual = archivo

    if request.method == "POST":
        nueva_descripcion = request.form.get("descripcion", "").strip()
        nuevo_archivo = request.files.get("archivo")
        usuario_id = session["usuario"]["id"]

        # Validar descripción
        if not nueva_descripcion:
            conn.close()
            return redirect(f"/editar/{id_archivo}")

        # Obtener versión actual máxima
        cursor.execute("SELECT MAX(version) FROM VERSIONAMIENTO WHERE ID_archivo = ?", (id_archivo,))
        version_actual = cursor.fetchone()[0] or 1000
        nueva_version = version_actual + 1

        # Validar y guardar nuevo archivo ZIP
        ruta_guardada = ruta_actual
        if nuevo_archivo and nuevo_archivo.filename != "":
            if not nuevo_archivo.filename.lower().endswith(".zip"):
                flash("Formato inválido: solo se permiten archivos .zip.")
                conn.close()
                return redirect(f"/editar/{id_archivo}")

            filename = secure_filename(nuevo_archivo.filename)
            ruta_guardada = os.path.join(UPLOAD_FOLDER, filename)
            nuevo_archivo.save(ruta_guardada)

        # Actualizar descripción/ruta en ARCHIVO
        cursor.execute("""
            UPDATE ARCHIVO
            SET descripcion = ?, ruta = ?
            WHERE ID_archivo = ?
        """, (nueva_descripcion, ruta_guardada, id_archivo))

        # Registrar nueva versión
        cursor.execute("""
            INSERT INTO VERSIONAMIENTO (ID_archivo, version, descripcion, usuario, fecha_cambio)
            VALUES (?, ?, ?, ?, ?)
        """, (
            id_archivo,
            nueva_version,
            nueva_descripcion,
            usuario_id,
            datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        ))

        conn.commit()
        conn.close()

        flash(f"Artefacto actualizado correctamente. Nueva versión creada: {nueva_version}.")
        return redirect(f"/editar/{id_archivo}")

    conn.close()
    return render_template("editar.html",
                           id_archivo=id_archivo,
                           descripcion_actual=descripcion_actual,
                           usuario=session["usuario"])

# === Confirmar eliminación ====================================================
@app.route("/eliminar/<id_archivo>", methods=["GET"])
@login_requerido
def confirmar_eliminacion(id_archivo):
    conn = get_conn()
    cursor = conn.cursor()
    cursor.execute("SELECT descripcion FROM ARCHIVO WHERE ID_archivo = ?", (id_archivo,))
    artefacto = cursor.fetchone()
    conn.close()

    if not artefacto:
        return redirect("/")

    return render_template("eliminar.html", id_archivo=id_archivo, descripcion=artefacto[0])


# === Ejecutar eliminación =====================================================
@app.route("/eliminar/<id_archivo>", methods=["POST"])
@login_requerido
def eliminar_artefacto(id_archivo):
    conn = get_conn()
    cursor = conn.cursor()

    # Verificar existencia
    cursor.execute("SELECT ruta FROM ARCHIVO WHERE ID_archivo = ?", (id_archivo,))
    archivo = cursor.fetchone()

    if not archivo:
        conn.close()
        return redirect("/")

    ruta_archivo = archivo[0]

    # Eliminar versiones relacionadas
    cursor.execute("DELETE FROM VERSIONAMIENTO WHERE ID_archivo = ?", (id_archivo,))

    # Eliminar artefacto principal
    cursor.execute("DELETE FROM ARCHIVO WHERE ID_archivo = ?", (id_archivo,))
    conn.commit()
    conn.close()

    # Eliminar archivo físico (si existe)
    if ruta_archivo and os.path.exists(ruta_archivo):
        try:
            os.remove(ruta_archivo)
        except Exception as e:
            flash(f"Advertencia: no se pudo eliminar el archivo físico: {e}")

    return redirect("/")

# === Búsqueda de artefactos ====================================================
@app.route("/buscar", methods=["GET", "POST"])
@login_requerido
def buscar():
    resultados = []
    termino = ""
    if request.method == "POST":
        termino = request.form.get("termino", "").strip()
        if termino:
            conn = get_conn()
            cursor = conn.cursor()
            cursor.execute("""
                SELECT 
                    A.ID_archivo, 
                    A.descripcion, 
                    V.version, 
                    V.usuario, 
                    V.fecha_cambio
                FROM ARCHIVO A
                JOIN VERSIONAMIENTO V 
                    ON A.ID_archivo = V.ID_archivo
                WHERE 
                    (UPPER(A.ID_archivo) LIKE UPPER(?) OR 
                     UPPER(A.descripcion) LIKE UPPER(?))
                AND V.version = (
                    SELECT MAX(V2.version)
                    FROM VERSIONAMIENTO V2
                    WHERE V2.ID_archivo = A.ID_archivo
                )
                ORDER BY A.ID_archivo ASC
            """, (f"%{termino}%", f"%{termino}%"))
            resultados = cursor.fetchall()
            conn.close()
    return render_template("buscar.html", resultados=resultados, termino=termino)

if __name__ == "__main__":
    app.run(debug=True)