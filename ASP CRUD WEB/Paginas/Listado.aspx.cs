using System;
using System.Web.UI.WebControls;
using ASP_CRUD_WEB.Datos;

namespace ASP_CRUD_WEB.Paginas
{
    public partial class Listado : System.Web.UI.Page
    {
        // Objetos que se encargan de hablar con la base de datos
        private readonly EstudianteDAO dao = new EstudianteDAO();
        private readonly AuditoriaDAO auditoriaDao = new AuditoriaDAO();

        protected void Page_Load(object sender, EventArgs e)
        {
            // IsPostBack es false solo la PRIMERA vez que se abre la página
            // (cuando se presiona un botón, la página se recarga con IsPostBack = true)
            if (!IsPostBack)
            {
                // Formulario.aspx nos manda "?ok=1" cuando guardó correctamente
                if (Request.QueryString["ok"] == "1")
                {
                    MostrarMensaje("Estudiante guardado correctamente.", "success");
                }
                CargarDatos();
            }
        }

        // Botón "Buscar": recarga la tabla usando el texto escrito
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            CargarDatos();
        }

        // Botón "Limpiar": borra el texto y vuelve a mostrar a todos
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = "";
            CargarDatos();
        }

        // READ: llena la tabla (filtrada por la búsqueda) y el historial de al lado
        private void CargarDatos()
        {
            try
            {
                gvEstudiantes.DataSource = dao.Listar(txtBuscar.Text.Trim());
                gvEstudiantes.DataBind();

                rptAuditoria.DataSource = auditoriaDao.Listar();   // últimos 10 cambios
                rptAuditoria.DataBind();
            }
            catch (Exception ex)
            {
                // Si MySQL no está encendido o la contraseña es incorrecta, lo mostramos
                MostrarMensaje("Error al conectar con la base de datos: " + ex.Message, "danger");
            }
        }

        // Se ejecuta cuando se presiona un botón dentro de la tabla
        protected void gvEstudiantes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                // CommandArgument trae el Id de la fila (lo pusimos en el .aspx)
                int id = Convert.ToInt32(e.CommandArgument);
                dao.Eliminar(id);   // DELETE

                MostrarMensaje("Estudiante eliminado.", "warning");
                CargarDatos();      // recargamos la tabla y el historial
            }
        }

        // Muestra un mensaje con estilo de alerta de Bootstrap (success, danger, warning...)
        private void MostrarMensaje(string texto, string tipo)
        {
            lblMensaje.Text = texto;
            lblMensaje.CssClass = "alert alert-" + tipo + " d-block";
        }
    }
}
