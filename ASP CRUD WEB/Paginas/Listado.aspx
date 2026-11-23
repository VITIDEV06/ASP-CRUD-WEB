<%@ Page Title="Estudiantes" Language="C#" MasterPageFile="~/Paginas/Sitio.Master" AutoEventWireup="true" CodeBehind="Listado.aspx.cs" Inherits="ASP_CRUD_WEB.Paginas.Listado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row g-4">

        <%-- ================= COLUMNA IZQUIERDA: estudiantes ================= --%>
        <div class="col-xl-9">

            <!-- Título y botón para CREAR un estudiante nuevo -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="m-0">Lista de estudiantes</h2>
                <a href="Formulario.aspx" class="btn btn-success">+ Nuevo estudiante</a>
            </div>

            <%-- BARRA DE BÚSQUEDA
                 DefaultButton hace que al presionar Enter se ejecute "Buscar" --%>
            <asp:Panel runat="server" DefaultButton="btnBuscar" CssClass="input-group mb-3">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control"
                    placeholder="Buscar por nombre, apellido, correo o carrera..." />
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar"
                    CssClass="btn btn-primary" OnClick="btnBuscar_Click" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                    CssClass="btn btn-outline-secondary" OnClick="btnLimpiar_Click" />
            </asp:Panel>

            <!-- Aquí se muestran mensajes (guardado, eliminado, errores) -->
            <asp:Label ID="lblMensaje" runat="server" />

            <!-- GridView = tabla que se llena sola con la lista de estudiantes (READ) -->
            <div class="table-responsive">
                <asp:GridView ID="gvEstudiantes" runat="server"
                    AutoGenerateColumns="false"
                    CssClass="table table-striped table-hover bg-white shadow-sm align-middle"
                    GridLines="None"
                    OnRowCommand="gvEstudiantes_RowCommand"
                    EmptyDataText="No se encontraron estudiantes.">

                    <HeaderStyle CssClass="table-dark" />

                    <Columns>
                        <%-- DataField = nombre de la propiedad en la clase Estudiante --%>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                        <asp:BoundField DataField="Correo" HeaderText="Correo" />
                        <asp:BoundField DataField="Carrera" HeaderText="Carrera" />
                        <asp:BoundField DataField="Edad" HeaderText="Edad" />

                        <%-- AUDITORÍA: DataFormatString da formato a la fecha --%>
                        <asp:BoundField DataField="FechaCreacion" HeaderText="Creado"
                            DataFormatString="{0:dd/MM/yyyy HH:mm}" ItemStyle-CssClass="small text-muted" />
                        <asp:BoundField DataField="FechaActualizacion" HeaderText="Actualizado"
                            DataFormatString="{0:dd/MM/yyyy HH:mm}" ItemStyle-CssClass="small text-muted" />

                        <%-- Botones de cada fila: VER (READ), EDITAR (UPDATE) y ELIMINAR (DELETE) --%>
                        <asp:TemplateField HeaderText="Acciones" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <a href='Detalle.aspx?id=<%# Eval("Id") %>' class="btn btn-info btn-sm">Ver</a>
                                <a href='Formulario.aspx?id=<%# Eval("Id") %>' class="btn btn-warning btn-sm">Editar</a>

                                <asp:LinkButton runat="server" Text="Eliminar"
                                    CssClass="btn btn-danger btn-sm"
                                    CommandName="Eliminar"
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirm('¿Seguro que deseas eliminar este estudiante?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <%-- ================= COLUMNA DERECHA: historial (auditoría) ================= --%>
        <div class="col-xl-3">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">Historial de cambios</div>
                <ul class="list-group list-group-flush">

                    <%-- Repeater = repite el mismo HTML por cada registro de auditoría.
                         El signo ":" después de "#" muestra el texto de forma segura. --%>
                    <asp:Repeater ID="rptAuditoria" runat="server">
                        <ItemTemplate>
                            <li class="list-group-item">
                                <span class='badge <%# Eval("Color") %>'><%# Eval("Accion") %></span>
                                <small class="text-muted float-end"><%# Eval("Fecha", "{0:dd/MM/yyyy HH:mm}") %></small>
                                <div class="small mt-1"><%#: Eval("Descripcion") %></div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>

                </ul>
            </div>
        </div>

    </div>

</asp:Content>
