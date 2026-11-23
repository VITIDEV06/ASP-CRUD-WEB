using System;
using ASP_CRUD_WEB.Datos;
using ASP_CRUD_WEB.Modelos;

namespace ASP_CRUD_WEB.Paginas
{
    public partial class Detalle : System.Web.UI.Page
    {
        private readonly EstudianteDAO dao = new EstudianteDAO();
        private readonly AuditoriaDAO auditoriaDao = new AuditoriaDAO();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Leemos el id de la URL: Detalle.aspx?id=3
                Estudiante est = null;
                if (int.TryParse(Request.QueryString["id"], out int id))
                {
                    est = dao.ObtenerPorId(id);   // READ de un solo registro
                }

                // Si no existe, ocultamos todo y mostramos un aviso
                if (est == null)
                {
                    pnlDetalle.Visible = false;
                    lblMensaje.Text = "No se encontró el estudiante. <a href='Listado.aspx' class='alert-link'>Volver a la lista</a>";
                    lblMensaje.CssClass = "alert alert-warning d-block";
                    return;
                }

                // Pasamos cada dato del objeto a su control en la página
                litNombreCompleto.Text = est.Nombre + " " + est.Apellido;
                litId.Text = est.Id.ToString();
                litNombre.Text = est.Nombre;
                litApellido.Text = est.Apellido;
                litCorreo.Text = est.Correo;
                litCarrera.Text = est.Carrera;
                litEdad.Text = est.Edad.ToString();

                // Fechas de auditoría con formato día/mes/año hora:minuto:segundo
                litCreado.Text = est.FechaCreacion.ToString("dd/MM/yyyy HH:mm:ss");
                litActualizado.Text = est.FechaActualizacion.ToString("dd/MM/yyyy HH:mm:ss");

                lnkEditar.NavigateUrl = "Formulario.aspx?id=" + est.Id;

                // Historial solo de este estudiante
                rptAuditoria.DataSource = auditoriaDao.Listar(est.Id);
                rptAuditoria.DataBind();
            }
        }
    }
}
