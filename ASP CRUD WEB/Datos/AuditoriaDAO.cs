using System.Collections.Generic;
using System.Configuration;
using ASP_CRUD_WEB.Modelos;
using MySql.Data.MySqlClient;

namespace ASP_CRUD_WEB.Datos
{
    /// <summary>
    /// Lee el historial de la tabla "auditoria".
    /// Solo LEE: los registros los escribe MySQL solo con TRIGGERS
    /// cada vez que se crea, actualiza o elimina un estudiante.
    /// </summary>
    public class AuditoriaDAO
    {
        private readonly string cadena =
            ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        // Devuelve los últimos 10 movimientos.
        // estudianteId = 0  -> de TODOS los estudiantes
        // estudianteId = 5  -> solo los del estudiante 5
        public List<Auditoria> Listar(int estudianteId = 0)
        {
            var lista = new List<Auditoria>();

            using (var cn = new MySqlConnection(cadena))
            {
                cn.Open();
                var cmd = new MySqlCommand(
                    "SELECT * FROM auditoria " +
                    "WHERE @id = 0 OR estudiante_id = @id " +
                    "ORDER BY id DESC LIMIT 10", cn);   // DESC = los más nuevos primero
                cmd.Parameters.AddWithValue("@id", estudianteId);

                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        lista.Add(new Auditoria
                        {
                            Id = dr.GetInt32("id"),
                            Accion = dr.GetString("accion"),
                            EstudianteId = dr.GetInt32("estudiante_id"),
                            Descripcion = dr.GetString("descripcion"),
                            Fecha = dr.GetDateTime("fecha")
                        });
                    }
                }
            }
            return lista;
        }
    }
}
