using System;

namespace ASP_CRUD_WEB.Modelos
{
    /// <summary>
    /// MODELO: representa una fila de la tabla "estudiantes".
    /// Cada propiedad corresponde a una columna de la base de datos.
    /// </summary>
    public class Estudiante
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Correo { get; set; }
        public string Carrera { get; set; }
        public int Edad { get; set; }

        // Auditoría: estas dos fechas las llena MySQL solo
        public DateTime FechaCreacion { get; set; }       // cuándo se creó
        public DateTime FechaActualizacion { get; set; }  // última vez que se modificó
    }
}
