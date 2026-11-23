<%@ Page Title="Detalle" Language="C#" MasterPageFile="~/Paginas/Sitio.Master" AutoEventWireup="true" CodeBehind="Detalle.aspx.cs" Inherits="ASP_CRUD_WEB.Paginas.Detalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Mensaje por si el estudiante no existe -->
    <asp:Label ID="lblMensaje" runat="server" />

    <%-- Panel = contenedor que podemos mostrar u ocultar desde el código --%>
    <asp:Panel ID="pnlDetalle" runat="server" CssClass="row justify-content-center g-4">

        <%-- ===== IZQUIERDA: datos del estudiante (READ de UN registro) ===== --%>
        <div class="col-lg-5">
            <div class="card shadow-sm">

                <div class="card-header bg-primary text-white">
                    <%-- Mode="Encode" evita que se ejecute HTML guardado en la base de datos --%>
                    <h4 class="m-0"><asp:Literal ID="litNombreCompleto" runat="server" Mode="Encode" /></h4>
                </div>

                <div class="card-body">
                    <!-- dl = lista de "título: valor" -->
                    <dl class="row mb-0">
                        <dt class="col-sm-5">ID</dt>
                        <dd class="col-sm-7"><asp:Literal ID="litId" runat="server" Mode="Encode" /></dd>

                        <dt class="col-sm-5">Nombre</dt>
                        <dd class="col-sm-7"><asp:Literal ID="litNombre" runat="server" Mode="Encode" /></dd>

                        <dt class="col-sm-5">Apellido</dt>
                        <dd class="col-sm-7"><asp:Literal ID="litApellido" runat="server" Mode="Encode" /></dd>

                        <dt class="col-sm-5">Correo</dt>
                        <dd class="col-sm-7"><asp:Literal ID="litCorreo" runat="server" Mode="Encode" /></dd>

                        <dt class="col-sm-5">Carrera</dt>
                        <dd class="col-sm-7"><asp:Literal ID="litCarrera" runat="server" Mode="Encode" /></dd>

                        <dt class="col-sm-5">Edad</dt>
                        <dd class="col-sm-7"><asp:Literal ID="litEdad" runat="server" Mode="Encode" /> años</dd>

                        <%-- Auditoría: fechas que llena MySQL solo --%>
                        <dt class="col-sm-5 text-muted">Creado</dt>
                        <dd class="col-sm-7 text-muted"><asp:Literal ID="litCreado" runat="server" /></dd>

                        <dt class="col-sm-5 text-muted">Última actualización</dt>
                        <dd class="col-sm-7 text-muted"><asp:Literal ID="litActualizado" runat="server" /></dd>
                    </dl>
                </div>

                <div class="card-footer">
                    <%-- El enlace a "Editar" se arma en el código con el id del estudiante --%>
                    <asp:HyperLink ID="lnkEditar" runat="server" Text="Editar" CssClass="btn btn-warning" />
                    <a href="Listado.aspx" class="btn btn-secondary">Volver</a>
                </div>
            </div>
        </div>

        <%-- ===== DERECHA: historial de cambios de ESTE estudiante ===== --%>
        <div class="col-lg-4">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">Historial de este estudiante</div>
                <ul class="list-group list-group-flush">
                    <asp:Repeater ID="rptAuditoria" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <span class='badge <%# Eval("Color") %>'><%# Eval("Accion") %></span>
                                <small class="text-muted float-end"><%# Eval("Fecha", "{0:dd/MM/yyyy HH:mm:ss}") %></small>
                                <div class="small mt-1"><%#: Eval("Descripcion") %></div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>

    </asp:Panel>

</asp:Content>
