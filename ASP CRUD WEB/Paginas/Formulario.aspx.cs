using System;
using ASP_CRUD_WEB.Datos;
using ASP_CRUD_WEB.Modelos;

namespace ASP_CRUD_WEB.Paginas
{
    public partial class Formulario : System.Web.UI.Page
    {
        private readonly EstudianteDAO dao = new EstudianteDAO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Si la URL trae "?id=5" estamos EDITANDO; si no trae id, estamos CREANDO
                if (int.TryParse(Request.QueryString["id"], out int id))
                {
                    Estudiante est = dao.ObtenerPorId(id);

                    if (est != null)
                    {
                        // Llenamos las cajas de texto con los datos actuales
                        hfId.Value = est.Id.ToString();
                        txtNombre.Text = est.Nombre;
                        txtApellido.Text = est.Apellido;
                        txtCorreo.Text = est.Correo;
                        txtCarrera.Text = est.Carrera;
                        txtEdad.Text = est.Edad.ToString();

                        litTitulo.Text = "Editar estudiante";
                    }
                }
            }
        }

        // Se ejecuta al presionar el botón "Guardar"
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Si algún validador falló (campo vacío, edad fuera de rango), no seguimos
            if (!Page.IsValid) return;

            // Armamos el objeto con lo que escribió el usuario
            var est = new Estudiante
            {
                Id = int.Parse(hfId.Value),
                Nombre = txtNombre.Text.Trim(),
                Apellido = txtApellido.Text.Trim(),
                Correo = txtCorreo.Text.Trim(),
                Carrera = txtCarrera.Text.Trim(),
                Edad = int.Parse(txtEdad.Text)
            };

            // Id = 0  -> es nuevo -> INSERT
            // Id > 0  -> ya existe -> UPDATE
            if (est.Id == 0)
                dao.Insertar(est);
            else
                dao.Actualizar(est);

            // Volvemos a la lista avisando que se guardó
            Response.Redirect("Listado.aspx?ok=1");
        }
    }
}
