<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Web.aspx.cs" Inherits="ReportingFiatc.Web" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Reporting Services</title>
    <link rel="Stylesheet" href="css/Fiatc.css" type="text/css" />
    <style type="text/css">
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true"></asp:ScriptManager>
        <asp:UpdatePanel ID="Header" runat="server">
            <ContentTemplate>
                <div class="DivHeader">
                    <div class="DivHeaderContent">
                        <h1 class="h1">Portal Reporting Hermes V5 - FIATC</h1>
                        <br />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="Body" runat="server">
            <ContentTemplate>
                <div class="DivBody">
                    <div class="DivHeaderBody">
                        <asp:UpdatePanel ID="Login" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="PanelLogin" runat="Server">
                                    <br />
                                    <asp:Table ID="TableLogin" runat="server">
                                        <asp:TableRow>
                                            <asp:TableCell ColumnSpan="2">
                                                <asp:Label runat="server" ID="TableLabelLogin" CssClass="TableLabel" Text="LOGIN" Width="100%"></asp:Label>
                                                <hr class="hr">
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell CssClass="ColLabel">
                                                <asp:Label ID="Label1" runat="server" CssClass="labelBusqueda" Text="Usuario"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="ColTextBox">
                                                <asp:TextBox ReadOnly="false" runat="server" ID="TextBoxUser" CssClass="TextBoxSmall" Text="" />
                                            </asp:TableCell><asp:TableCell>
                                                <asp:RequiredFieldValidator
                                                    ID="RequiredFieldValidatorUser"
                                                    runat="server"
                                                    CssClass="CustomValidator"
                                                    ControlToValidate="TextBoxUser"
                                                    ValidationGroup="LoginGroupValidator"
                                                    ErrorMessage="Introduce un usuario">
                                                </asp:RequiredFieldValidator>
                                            </asp:TableCell></asp:TableRow><asp:TableRow>
                                            <asp:TableCell CssClass="ColLabel">
                                                <asp:Label ID="Label2" runat="server" CssClass="labelBusqueda" Text="Password"></asp:Label>
                                            </asp:TableCell><asp:TableCell CssClass="ColTextBox">
                                                <asp:TextBox ReadOnly="false" runat="server" ID="TextBoxPassword" TextMode="Password" CssClass="TextBoxSmall" Text="" />
                                            </asp:TableCell><asp:TableCell>
                                                <asp:RequiredFieldValidator
                                                    ID="RequiredFieldValidator1"
                                                    runat="server"
                                                    CssClass="CustomValidator"
                                                    ControlToValidate="TextBoxPassword"
                                                    ValidationGroup="LoginGroupValidator"
                                                    ErrorMessage="Introduce un password">
                                                </asp:RequiredFieldValidator>
                                            </asp:TableCell></asp:TableRow><asp:TableRow>
                                            <asp:TableCell></asp:TableCell><asp:TableCell>
                                                <asp:Button CssClass="Button" ID="ButtonAcceder" runat="server" ValidationGroup="LoginGroupValidator" Text="ACCEDER" OnClick="ButtonAcceder_Click" />
                                            </asp:TableCell><asp:TableCell>
                                                <asp:CustomValidator ID="CustomValidatorLogin" CssClass="CustomValidator" runat="server" ErrorMessage=""></asp:CustomValidator>
                                            </asp:TableCell></asp:TableRow></asp:Table></asp:Panel></ContentTemplate></asp:UpdatePanel><table>
                            <tr>
                                <td style="vertical-align: top">
                                    <asp:UpdatePanel ID="TipoReport" runat="server">
                                        <ContentTemplate>
                                            <br />
                                            <asp:Panel ID="PanelTipoReport" runat="server">
                                                <asp:Table ID="TableTipoReport" runat="server" CssClass="TableFilter">
                                                    <asp:TableRow>
                                                        <asp:TableCell ColumnSpan="2">
                                                            <asp:Label runat="server" ID="Label3" CssClass="TableLabel" Text="REPORTS" Width="100%"></asp:Label>
                                                            <hr class="hr">
                                                        </asp:TableCell></asp:TableRow><asp:TableRow>
                                                        <asp:TableCell CssClass="ColLabel">
                                                            <asp:Label ID="LabelTipoReport" runat="server" CssClass="labelBusqueda" Text="Report"></asp:Label>
                                                        </asp:TableCell><asp:TableCell CssClass="ColTextBox">
                                                            <asp:DropDownList ID="DropDownListReport" CssClass="DropDownListLarge" runat="server" AutoPostBack="True" Width="280px" DataSourceID="SqlDataSourceReports" DataTextField="Description" DataValueField="ID" OnSelectedIndexChanged="DropDownListReport_SelectedIndexChanged"></asp:DropDownList>
                                                        </asp:TableCell></asp:TableRow></asp:Table></asp:Panel></ContentTemplate></asp:UpdatePanel></td><td style="vertical-align: top">
                                    <asp:UpdatePanel ID="Filtros" runat="server">
                                        <ContentTemplate>
                                            <br />
                                            <asp:Panel ID="PanelFiltros" runat="server">
                                                <asp:Table ID="TableFiltros" runat="server">
                                                    <asp:TableRow>
                                                        <asp:TableCell ColumnSpan="2">
                                                            <asp:Label runat="server" ID="Label5" CssClass="TableLabel" Text="FILTROS" Width="100%"></asp:Label>
                                                            <hr class="hr">
                                                        </asp:TableCell></asp:TableRow><asp:TableRow>
                                                        <asp:TableCell>
                                                            <asp:Table runat="server" ID="TableFechas">
                                                                <asp:TableRow>
                                                                    <asp:TableCell>
                                                                        <asp:Table ID="TableFiltrosFechaInicio" runat="server">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell CssClass="ColLabel">
                                                                                    <asp:Label ID="LabelFechaInicio" runat="server" Text="Fecha"></asp:Label>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell CssClass="ColTextBox">
                                                                                    <asp:TextBox ReadOnly="false" runat="server" ID="TextBoxFechaInicio" CssClass="TextBoxXSmall" Text="" />
                                                                                    <ajx:CalendarExtender ID="CalendarFechaInicio" runat="server" Enabled="True" TargetControlID="TextBoxFechaInicio" Format="dd/MM/yyyy" />
                                                                                    <asp:Button ID="ButtonAñadir" runat="server" Text="AÑADIR" CssClass="Button" Width="110px" OnClick="ButtonAñadir_Click" />
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                                 <asp:TableRow>
                                                                    <asp:TableCell>
                                                                        <asp:Table ID="TableFiltroMeses" runat="server">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell CssClass="ColLabel">
                                                                                    <asp:Label ID="Label6" runat="server" Text="Mes"></asp:Label>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell CssClass="ColTextBox">
                                                                                     <asp:DropDownList ID="DropDownListMes" CssClass="DropDownListLarge" runat="server" AutoPostBack="True" Width="280px" DataTextField="Description" DataValueField="Enero" OnSelectedIndexChanged="DropDownListMes_SelectedIndexChanged">
                                                                                         <asp:ListItem Enabled="true" Text="Añadir Mes..." Value="-1"></asp:ListItem>
                                                                                            <asp:ListItem Text="Enero" Value="1"></asp:ListItem>
                                                                                            <asp:ListItem Text="Febrero" Value="2"></asp:ListItem>
                                                                                            <asp:ListItem Text="Marzo" Value="3"></asp:ListItem>
                                                                                            <asp:ListItem Text="Abril" Value="4"></asp:ListItem>
                                                                                            <asp:ListItem Text="Mayo" Value="5"></asp:ListItem>
                                                                                            <asp:ListItem Text="Junio" Value="6"></asp:ListItem>
                                                                                            <asp:ListItem Text="Julio" Value="7"></asp:ListItem>
                                                                                            <asp:ListItem Text="Agosto" Value="8"></asp:ListItem>
                                                                                            <asp:ListItem Text="Septiembre" Value="9"></asp:ListItem>
                                                                                            <asp:ListItem Text="Octubre" Value="10"></asp:ListItem>
                                                                                            <asp:ListItem Text="Noviembre" Value="11"></asp:ListItem>
                                                                                            <asp:ListItem Text="Diciembre" Value="12"></asp:ListItem>
                                                                                     </asp:DropDownList>
                                                                                    <asp:Button ID="ButtonAñadirMes" runat="server" Text="AÑADIR" CssClass="Button" Width="110px" OnClick="ButtonAñadirMes_Click" />
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell></asp:TableRow><asp:TableRow>
                                                        <asp:TableCell>
                                                            <asp:Table ID="Table1" runat="server">
                                                                <asp:TableRow>                                                                    
                                                                    <asp:TableCell>
                                                                        <asp:Table ID="TableFiltrosCampaigns" runat="server">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell CssClass="ColLabel">
                                                                                    <asp:Table ID="Table2" runat="server">
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell CssClass="ColLabel">
                                                                                                <asp:Label ID="LabelCampaings" runat="server" Text="Campañas"></asp:Label>
                                                                                            </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                    </asp:Table>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell CssClass="ColTextBox">
                                                                                    <asp:Table ID="Table3" runat="server">
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell>
                                                                                                <asp:ListBox ID="ListBoxCampaigns" runat="server" CssClass="DropDownListLarge" SelectionMode="Multiple" Width="350px" Rows="8" DataSourceID="SqlDataSourceCampaigns" DataTextField="Description" DataValueField="ID"></asp:ListBox>
                                                                                            </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell HorizontalAlign="Right">
                                                                                                <asp:Table ID="Table5" runat="server">
                                                                                                    <asp:TableRow>
                                                                                                        <asp:TableCell CssClass="ColLabel">
                                                                                                <a href="#" onclick="javascript:seleccionarTodos('ListBoxCampaigns');">Seleccionar todas</a>
                                                                                                        </asp:TableCell>
                                                                                                    </asp:TableRow>
                                                                                                </asp:Table>
                                                                                            </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                    </asp:Table>
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>



                                                                    <asp:TableCell>
                                                                        <asp:Table ID="TableListaFechas" runat="server">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell CssClass="ColLabel">
                                                                                    <asp:Table ID="Table4" runat="server">
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell CssClass="ColLabel">
                                                                                                <asp:Label ID="Label4" runat="server" Text="Fechas"></asp:Label>
                                                                                            </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                    </asp:Table>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell CssClass="ColTextBox">
                                                                                    <asp:Table ID="Table6" runat="server">
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell>
                                                                                                <asp:ListBox ID="ListBox1" runat="server" CssClass="DropDownListLarge" SelectionMode="Multiple" Width="150px" Rows="8" ></asp:ListBox>
                                                                                                   </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                        <asp:TableRow>
                                                                                            <asp:TableCell>
                                                                                                 <asp:Button ID="Button1" runat="server" Text="Eliminar Fecha" CssClass="Button" Width="110px" OnClick="Button1_Click"/>
                                                                                        
                                                                                            </asp:TableCell>
                                                                                        </asp:TableRow>
                                                                                    </asp:Table>
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell></asp:TableRow><asp:TableRow>
                                                        <asp:TableCell>
                                                            <asp:Table runat="server" ID="TableFiltrosHermesSL">
                                                                <asp:TableRow>
                                                                    <asp:TableCell>
                                                                        <asp:Table ID="TableSL" runat="server">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell CssClass="ColLabel">
                                                                                    <asp:Label ID="LabelSL" runat="server" Text="Nivel de Servicio"></asp:Label>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell CssClass="ColTextBox">
                                                                                    <asp:TextBox ReadOnly="false" runat="server" ID="TextBoxSL" CssClass="TextBoxXSmall" Width="30px" Text="20" />
                                                                                    <ajx:FilteredTextBoxExtender ID="FilteredTextBoxExtenderTextBoxSL" runat="server" Enabled="True" TargetControlID="TextBoxSL" FilterType="Numbers"></ajx:FilteredTextBoxExtender>
                                                                                    <asp:Label ID="LabelSeconds1" runat="server" Text="(Tiempo en segundos)" CssClass="Label"></asp:Label>
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>
                                                                    <asp:TableCell>
                                                                        <asp:Table ID="TableLostCalls" runat="server">
                                                                            <asp:TableRow>
                                                                                <asp:TableCell CssClass="ColLabel">
                                                                                    <asp:Label ID="LabelLostCalls" runat="server" Text="Llamadas perdidas"></asp:Label>
                                                                                </asp:TableCell>
                                                                                <asp:TableCell CssClass="ColTextBox">
                                                                                    <asp:TextBox ReadOnly="false" runat="server" ID="TextBoxLostCalls" CssClass="TextBoxXSmall" Width="30px" Text="0" />
                                                                                    <ajx:FilteredTextBoxExtender ID="FilteredTextBoxExtenderLostCalls" runat="server" Enabled="True" TargetControlID="TextBoxLostCalls" FilterType="Numbers"></ajx:FilteredTextBoxExtender>
                                                                                    <asp:Label ID="LabelSeconds2" runat="server" Text="(Tiempo en segundos)" CssClass="Label"></asp:Label>
                                                                                </asp:TableCell>
                                                                            </asp:TableRow>
                                                                        </asp:Table>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell></asp:TableRow><asp:TableRow>
                                                        <asp:TableCell>
                                                            <asp:Table ID="TableGenerar" runat="server">
                                                                <asp:TableRow>
                                                                    <asp:TableCell>
                                                                        <asp:Button ID="ButtonGenerar" runat="server" Text="GENERAR" CssClass="Button" Width="110px" OnClick="ButtonGenerar_Click" />
                                                                    </asp:TableCell>
                                                                    <asp:TableCell>
                                                                        <asp:CustomValidator ID="CustomValidatorGenerar" CssClass="CustomValidator" runat="server" ErrorMessage=""></asp:CustomValidator>
                                                                         <asp:UpdateProgress ID="UpdateProgressReport" DynamicLayout="true" runat="server" >
                                                                            <ProgressTemplate>
                                                                                <div id="overlay">
                                                                                    <div id="modalprogress">
                                                                                        <div id="theprogress">
                                                                                            <asp:Label ID="LabelInProgress" runat="server" CssClass="UpdateProgressReport" Text="Generando Report..."></asp:Label>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </ProgressTemplate>
                                                                        </asp:UpdateProgress>
                                                                    </asp:TableCell>
                                                                </asp:TableRow>
                                                            </asp:Table>
                                                        </asp:TableCell></asp:TableRow></asp:Table></asp:Panel></ContentTemplate></asp:UpdatePanel></td></tr></table><asp:SqlDataSource ID="SqlDataSourceReports" runat="server" ConnectionString="<%$ ConnectionStrings:HermesConnectionString %>" ProviderName="<%$ ConnectionStrings:HermesConnectionString.ProviderName %>"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceAgents" runat="server" ConnectionString="<%$ ConnectionStrings:HermesConnectionString %>" ProviderName="<%$ ConnectionStrings:HermesConnectionString.ProviderName %>"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceCampaigns" runat="server" ConnectionString="<%$ ConnectionStrings:HermesConnectionString %>" ProviderName="<%$ ConnectionStrings:HermesConnectionString.ProviderName %>"></asp:SqlDataSource>
                        <br />
                        <div id="ReportDIV" runat="server" style="display: none;">
                            <asp:UpdatePanel ID="Report" runat="server">
                                <ContentTemplate>
                                    <asp:Panel ID="PanelReport" runat="server" Height="500px">
                                        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="8pt" Width="100%" Height="100%" PageCountMode="Actual" ShowRefreshButton="False">
                                            <LocalReport ReportEmbeddedResource="Report1.rdlc" ReportPath="Report1.rdlc">
                                                <DataSources>
                                                    <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                                                </DataSources>
                                            </LocalReport>
                                        </rsweb:ReportViewer>
                                    </asp:Panel>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetData" TypeName="DataSetOficinasHistorialContactacionTableAdapters.Cajamar_Oficinas_Report_HistorialContactacionTableAdapter" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>

<script>
    function seleccionarTodos(dropdown) {
        dropdown = document.getElementById(dropdown);

        for (var i = 0; i < dropdown.length; i++) {
            dropdown.options[i].selected = true
        }
    }

    function borrarTextBox(textbox) {
        document.getElementById(textbox).value = '';
    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;
    }
</script>
</html>