using System;

namespace ASP_CRUD_WEB.Modelos
{
    /// <summary>
    /// MODELO: una fila de la tabla "auditoria" (historial de cambios).
    /// Estas filas NO se crean desde C#: las crea MySQL con TRIGGERS (ver crud_web.sql).
    /// </summary>
    public class Auditoria
    {
        public int Id { get; set; }
        public string Accion { get; set; }        // CREAR, ACTUALIZAR o ELIMINAR
        public int EstudianteId { get; set; }
        public string Descripcion { get; set; }
        public DateTime Fecha { get; set; }

        // Color de Bootstrap según la acción: verde, amarillo o rojo
        public string Color
        {
            get
            {
                if (Accion == "CREAR") return "bg-success";
                if (Accion == "ACTUALIZAR") return "bg-warning text-dark";
                return "bg-danger";
            }
        }
    }
}
