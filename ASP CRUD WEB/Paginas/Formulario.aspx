<%@ Page Title="Estudiante" Language="C#" MasterPageFile="~/Paginas/Sitio.Master" AutoEventWireup="true" CodeBehind="Formulario.aspx.cs" Inherits="ASP_CRUD_WEB.Paginas.Formulario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%-- Este MISMO formulario sirve para CREAR y para EDITAR --%>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">

                    <h3 class="card-title mb-3">
                        <asp:Literal ID="litTitulo" runat="server" Text="Nuevo estudiante" />
                    </h3>

                    <!-- Campo oculto: guarda el id del estudiante (0 = es nuevo) -->
                    <asp:HiddenField ID="hfId" runat="server" Value="0" />

                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" MaxLength="50" />
                        <%-- RequiredFieldValidator: no deja guardar si el campo está vacío --%>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
                            ErrorMessage="El nombre es obligatorio" CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Apellido</label>
                        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" MaxLength="50" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido"
                            ErrorMessage="El apellido es obligatorio" CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Correo</label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" TextMode="Email" MaxLength="100" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCorreo"
                            ErrorMessage="El correo es obligatorio" CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Carrera</label>
                        <asp:TextBox ID="txtCarrera" runat="server" CssClass="form-control" MaxLength="100" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCarrera"
                            ErrorMessage="La carrera es obligatoria" CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Edad</label>
                        <asp:TextBox ID="txtEdad" runat="server" CssClass="form-control" TextMode="Number" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEdad"
                            ErrorMessage="La edad es obligatoria" CssClass="text-danger small" Display="Dynamic" />
                        <%-- RangeValidator: la edad debe ser un número entre 15 y 99 --%>
                        <asp:RangeValidator runat="server" ControlToValidate="txtEdad" Type="Integer"
                            MinimumValue="15" MaximumValue="99"
                            ErrorMessage="La edad debe estar entre 15 y 99" CssClass="text-danger small" Display="Dynamic" />
                    </div>

                    <!-- Botones -->
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar"
                        CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                    <a href="Listado.aspx" class="btn btn-secondary">Cancelar</a>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
