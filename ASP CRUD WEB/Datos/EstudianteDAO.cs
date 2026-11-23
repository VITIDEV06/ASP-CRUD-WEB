using System.Collections.Generic;
using System.Configuration;
using ASP_CRUD_WEB.Modelos;
using MySql.Data.MySqlClient;   // Paquete NuGet "MySql.Data"

namespace ASP_CRUD_WEB.Datos
{
    /// <summary>
    /// DAO (Data Access Object): es la ÚNICA clase que habla con MySQL.
    /// Aquí están las 4 operaciones del CRUD:
    ///   C = Create (Insertar)   R = Read (Listar / ObtenerPorId)
    ///   U = Update (Actualizar) D = Delete (Eliminar)
    /// </summary>
    public class EstudianteDAO
    {
        // Leemos la cadena de conexión que está en Web.config (name="conexion")
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // ---------- READ: traer los estudiantes (con búsqueda opcional) ----------
        // Si "texto" viene vacío trae TODOS; si no, solo los que coinciden
        public List<Estudiante> Listar(string texto = "")
        {
            var lista = new List<Estudiante>();

            // "using" cierra la conexión automáticamente al terminar
            using (var cn = new MySqlConnection(cadena))
            {
                cn.Open();
                // LIKE '%ana%' encuentra "Ana", "Mariana", "ana.gomez@correo.com"...
                var cmd = new MySqlCommand(
                    "SELECT * FROM estudiantes " +
                    "WHERE nombre LIKE @texto OR apellido LIKE @texto " +
                    "   OR correo LIKE @texto OR carrera LIKE @texto " +
                    "ORDER BY id", cn);
                cmd.Parameters.AddWithValue("@texto", "%" + texto + "%");

                using (var dr = cmd.ExecuteReader())
                {
                    // Leemos fila por fila y la convertimos en un objeto Estudiante
                    while (dr.Read())
                    {
                        lista.Add(LeerFila(dr));
                    }
                }
            }
            return lista;
        }

        // ---------- READ: traer UN estudiante por su id ----------
        public Estudiante ObtenerPorId(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            {
                cn.Open();
                var cmd = new MySqlCommand("SELECT * FROM estudiantes WHERE id = @id", cn);
                cmd.Parameters.AddWithValue("@id", id);

                using (var dr = cmd.ExecuteReader())
                {
                    // Si encontró la fila la devolvemos; si no, devolvemos null
                    return dr.Read() ? LeerFila(dr) : null;
                }
            }
        }

        // ---------- CREATE: insertar un estudiante nuevo ----------
        public void Insertar(Estudiante est)
        {
            using (var cn = new MySqlConnection(cadena))
            {
                cn.Open();
                // Usamos @parámetros (nunca concatenar texto) para evitar la INYECCIÓN SQL
                var cmd = new MySqlCommand(
                    "INSERT INTO estudiantes (nombre, apellido, correo, carrera, edad) " +
                    "VALUES (@nombre, @apellido, @correo, @carrera, @edad)", cn);
                AgregarParametros(cmd, est);
                cmd.ExecuteNonQuery();
            }
        }

        // ---------- UPDATE: modificar un estudiante existente ----------
        public void Actualizar(Estudiante est)
        {
            using (var cn = new MySqlConnection(cadena))
            {
                cn.Open();
                var cmd = new MySqlCommand(
                    "UPDATE estudiantes SET nombre = @nombre, apellido = @apellido, " +
                    "correo = @correo, carrera = @carrera, edad = @edad WHERE id = @id", cn);
                AgregarParametros(cmd, est);
                cmd.Parameters.AddWithValue("@id", est.Id);
                cmd.ExecuteNonQuery();
            }
        }

        // ---------- DELETE: borrar un estudiante ----------
        public void Eliminar(int id)
        {
            using (var cn = new MySqlConnection(cadena))
            {
                cn.Open();
                var cmd = new MySqlCommand("DELETE FROM estudiantes WHERE id = @id", cn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }

        // ===== Métodos de ayuda (para no repetir código) =====

        // Convierte la fila actual del lector en un objeto Estudiante
        private Estudiante LeerFila(MySqlDataReader dr)
        {
            return new Estudiante
            {
                Id = dr.GetInt32("id"),
                Nombre = dr.GetString("nombre"),
                Apellido = dr.GetString("apellido"),
                Correo = dr.GetString("correo"),
                Carrera = dr.GetString("carrera"),
                Edad = dr.GetInt32("edad"),
                FechaCreacion = dr.GetDateTime("fecha_creacion"),
                FechaActualizacion = dr.GetDateTime("fecha_actualizacion")
            };
        }

        // Pasa los datos del estudiante a los @parámetros del comando SQL
        private void AgregarParametros(MySqlCommand cmd, Estudiante est)
        {
            cmd.Parameters.AddWithValue("@nombre", est.Nombre);
            cmd.Parameters.AddWithValue("@apellido", est.Apellido);
            cmd.Parameters.AddWithValue("@correo", est.Correo);
            cmd.Parameters.AddWithValue("@carrera", est.Carrera);
            cmd.Parameters.AddWithValue("@edad", est.Edad);
        }
    }
}
