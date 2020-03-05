using log4net;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ReportingFiatc
{
    public partial class Web : System.Web.UI.Page
    {
        public const string SupervisionRights = "SupervisionRights";
        public const string CustomerID = "CustomerID";
        public const string ReportTypeInbound = "Inbound";
        public const string ReportTypeOutbound = "Outbound";
        public const string ReportTypeManual = "Manual";
        public const string ReportTypeAgent = "Agent";

        private string queryReports = "SELECT '' AS ID, '-- Selecciona un Report --' AS Description UNION SELECT R.[ID],R.[Description] FROM [Vocalcom_Reports] R LEFT JOIN [HN_Admin].[dbo].[ListSuperviseGroups] G ON R.[SupervisionGroup] = G.[SuperviseGroupId] LEFT JOIN [HN_Admin].[dbo].[SuperviseGroupSupervisor] S ON S.SuperviseGroupOid = G.Oid WHERE G.customerId = " + Utils.getWebconfigParam(CustomerID); //+ " AND S.SupervisorId = '@param1'";
        private string queryAgents = "SELECT DISTINCT Ident as ID, CAST(Ident AS NVARCHAR(4)) + ' - ' + FirstName + ' ' + LastName AS description FROM [HN_Admin].[dbo].[ListAgents] WHERE customerId = " + Utils.getWebconfigParam(CustomerID);
        private string queryCampaigns = "SELECT DISTINCT [DID] AS ID, [Description] FROM HN_Admin.dbo.ListCampaignInbound WHERE customerId = " + Utils.getWebconfigParam(CustomerID);

        private static readonly ILog logger = LogManager.GetLogger(typeof(Web));

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Login.Visible = true;
                TipoReport.Visible = false;
                PanelFiltros.Visible = false;
                PanelReport.Visible = true;

                //Fecha apertura = Día de hoy. Fecha de cierre = Día mañana a las 00:00. Intervalo del día de hoy completo
                //TextBoxFechaInicio.Text = DateTime.Now.ToString(CalendarFechaInicio.Format);
            }
        }

        protected void ButtonAcceder_Click(object sender, EventArgs e)
        {
            logger.Debug("[Login] - User[" + TextBoxUser.Text + "] Password[" + TextBoxPassword.Text + "]");

            int iUser;
            if (Int32.TryParse(TextBoxUser.Text, out iUser) && TextBoxUser.Text.Length == 4)
            {
                int iSupervisionRight = GetSupervisionRight(iUser, TextBoxPassword.Text);
                if (iSupervisionRight == 1)
                {
                    Login.Visible = false;
                    TipoReport.Visible = true;
                    PanelFiltros.Visible = false;


                    logger.Debug("[Login] - Login correcto");
                    SqlDataSourceReports.SelectCommand = queryReports.Replace("@param1", iUser.ToString());
                }
                else if (iSupervisionRight == 0)
                {
                    CustomValidatorLogin.IsValid = false;
                    CustomValidatorLogin.Text = "Usuario y/o password no son correctos";
                    logger.Debug("[Login] - Usuario y/o password no son correctos");
                }
                else if (iSupervisionRight == -1)
                {
                    CustomValidatorLogin.IsValid = false;
                    CustomValidatorLogin.Text = "No se ha podido conectar con la base de datos";
                    logger.Debug("[Login] - No se ha podido conectar con la base de datos");
                }
                else
                {
                    CustomValidatorLogin.IsValid = false;
                    CustomValidatorLogin.Text = "Error desconocido";
                    logger.Debug("[Login] - Error desconocido");
                }
            }
            else
            {
                CustomValidatorLogin.IsValid = false;
            }
        }

        protected void ButtonGenerar_Click(object sender, EventArgs e)
        {
            ReportDIV.Style.Remove("display");
            bool bUnknowReport = false;
            //Fechas
            string sDateFrom = TextBoxFechaInicio.Text;

            //Sin filtro de Campañas
            int iNoCampaings = 0;

            //Lista de campañas
            string sCampaigns = "";

            //Lista de Fechas
            string sListFechas = "";
            string[] splitListFechas;

            for (int i = 0; i < ListBox1.Items.Count; i++)
            {
                //03/02/2020
                splitListFechas = ListBox1.Items[i].Value.Split('/');

                if (splitListFechas.Length > 0)
                    sListFechas += splitListFechas[2] + splitListFechas[1] + splitListFechas[0] + ",";
            }
            if (sListFechas.Length > 0) sListFechas = sListFechas.Substring(0, sListFechas.Length - 1);

            for (int i = 0; i < ListBoxCampaigns.Items.Count; i++)
            {
                if (ListBoxCampaigns.Items[i].Selected) sCampaigns += ListBoxCampaigns.Items[i].Value + ",";
            }
            if (sCampaigns.Length > 0) sCampaigns = sCampaigns.Substring(0, sCampaigns.Length - 1);

            //Sin filtro de Agentes
            int iNoAgents = 0;

            String sSLSeconds = (TextBoxSL.Text != "") ? TextBoxSL.Text : "0";
            String sLostCallsSeconds = (TextBoxLostCalls.Text != "") ? TextBoxLostCalls.Text : "0";

            switch (DropDownListReport.SelectedValue)
            {
                case "DistribucionLlamadasEntrantes":

                    if (sCampaigns.Length > 0)
                    {
                        //Establecemos el report y el DataSource
                        ReportViewer1.LocalReport.ReportEmbeddedResource = "ReportDistribucionLlamadasEntrantes.rdlc";
                        ReportViewer1.LocalReport.ReportPath = "ReportDistribucionLlamadasEntrantes.rdlc";
                        ObjectDataSource1.TypeName = "ReportingFiatc.DataSetDistribucionLlamadasEntrantesTableAdapters.Report_DistribucionLlamadasEntrantesTableAdapter";
                        //Parametros del DataSource
                        ObjectDataSource1.SelectParameters.Clear();
                        ObjectDataSource1.SelectParameters.Add("CustomerID", System.Data.DbType.Int32, Utils.getWebconfigParam(CustomerID));
                        ObjectDataSource1.SelectParameters.Add("DateList", System.Data.DbType.String, sListFechas);
                        ObjectDataSource1.SelectParameters.Add("ListCampaigns", System.Data.DbType.String, sCampaigns);
                        ObjectDataSource1.SelectParameters.Add("ServiceLevel", System.Data.DbType.Int32, sSLSeconds);
                        ObjectDataSource1.SelectParameters.Add("LostCalls", System.Data.DbType.Int32, sLostCallsSeconds);
                        //Llamamos al Procedure

                        ObjectDataSource1.Select();

                        ReportViewer1.LocalReport.DisplayName = RandomString();
                        ReportViewer1.LocalReport.Refresh();
                    }
                    else 
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No has seleccionado ninguna campaña')", true);
                    }
                   
                    break;

                case "VisionGeneralCampanas":

                    if (sCampaigns.Length > 0)
                    {
                        //Establecemos el report y el DataSource
                        ReportViewer1.LocalReport.ReportEmbeddedResource = "VisionGeneralCampanas.rdlc";
                        ReportViewer1.LocalReport.ReportPath = "VisionGeneralCampanas.rdlc";
                        ObjectDataSource1.TypeName = "ReportingFiatc.DataSetVisionGeneralCampanasTableAdapters.Report_InboundCampaingsTableAdapter";
                        //Parametros del DataSource
                        ObjectDataSource1.SelectParameters.Clear();
                        ObjectDataSource1.SelectParameters.Add("CustomerID", System.Data.DbType.Int32, Utils.getWebconfigParam(CustomerID));
                        ObjectDataSource1.SelectParameters.Add("DateList", System.Data.DbType.String, sListFechas);
                        ObjectDataSource1.SelectParameters.Add("ListCampaigns", System.Data.DbType.String, sCampaigns);
                        ObjectDataSource1.SelectParameters.Add("ServiceLevel", System.Data.DbType.Int32, sSLSeconds);
                        ObjectDataSource1.SelectParameters.Add("LostCalls", System.Data.DbType.Int32, sLostCallsSeconds);
                        //Llamamos al Procedure
                        ObjectDataSource1.Select();
                        ReportViewer1.LocalReport.DisplayName = RandomString();
                        ReportViewer1.LocalReport.Refresh();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No has seleccionado ninguna campaña')", true);
                    }

                    break;

                default:
                    bUnknowReport = true;
                    break;
            }

                if (bUnknowReport == true)
                {
                    ReportDIV.Style.Add("display", "none");
                    CustomValidatorGenerar.IsValid = false;
                    CustomValidatorGenerar.Text = "No se ha podido encontrar el report.";
                    logger.Debug("[ButtonGenerar_Click] - No se ha podido encontrar el report.");
                }
                else
                {
                    try
                    {
                        CustomValidatorGenerar.IsValid = false;
                        CustomValidatorGenerar.Text = "Generando el report... ";
                        ObjectDataSource1.Select();
                    }
                    catch (Exception exception)
                    {

                        if (exception.InnerException.Message.StartsWith("Timeout expired"))
                        {
                            CustomValidatorGenerar.Text = "Tiempo de espera superado. Por favor selecciona un rango de fechas inferior.";
                        }
                        else
                        {
                            CustomValidatorGenerar.Text = "Error generando el report.";
                        }
                        ReportDIV.Style.Add("display", "inline");
                        CustomValidatorGenerar.IsValid = false;
                        logger.Error("[ButtonGenerar_Click] " + exception.ToString());
                    }
                    //Parametros para mostrar en el report
                    List<Microsoft.Reporting.WebForms.ReportParameter> Parameters = new List<Microsoft.Reporting.WebForms.ReportParameter>();
                    Parameters.Add(new Microsoft.Reporting.WebForms.ReportParameter("DateParam", sListFechas));
                    //ReportViewer1.LocalReport.SetParameters(Parameters);

                    ReportViewer1.LocalReport.Refresh();
                    ReportViewer1.LocalReport.DisplayName = RandomString();
                    CustomValidatorGenerar.IsValid = true;
                }  
        }

        protected string RandomString()
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var stringChars = new char[8];
            var random = new Random();

            for (int i = 0; i < stringChars.Length; i++)
            {
                stringChars[i] = chars[random.Next(chars.Length)];
            }

            return new String(stringChars);
        }

        protected int GetSupervisionRight(int user, string password)
        {
            string connectionString = Utils.GetConnectionString();
            SqlConnection sqlConnection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = Utils.getWebconfigParam(SupervisionRights);
            cmd.Parameters.Add("@customerId", SqlDbType.Int).Value = Utils.getWebconfigParam(CustomerID);
            cmd.Parameters.Add("@ident", SqlDbType.Int).Value = user;
            cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = password;
            cmd.Connection = sqlConnection;

            try
            {
                sqlConnection.Open();
                var result = cmd.ExecuteScalar();
                return (int)result;
            }
            catch (Exception e)
            {
                logger.Error("[GetSupervisionRight] - Error");
                logger.Error(e);
                return -1;
            }
            finally
            {
                sqlConnection.Close();
                sqlConnection.Dispose();
            }
        }

        protected void DropDownListReport_SelectedIndexChanged(object sender, EventArgs e)
        {
            ReportDIV.Style.Add("display", "none");
            if (DropDownListReport.SelectedValue == "")
            {
                PanelFiltros.Visible = false;
            }
            else
            {
                if (DropDownListReport.SelectedValue == "VisionGeneralCampanas")
                {
                    PanelFiltros.Visible = true;
                    TableFiltrosHermesSL.Visible = true;
                    TableFiltrosCampaigns.Visible = true;
                    TableListaFechas.Visible = true;
                    SqlDataSourceCampaigns.SelectCommand = queryCampaigns;
                }
                else if (DropDownListReport.SelectedValue == "DistribucionLlamadasEntrantes")
                {
                    PanelFiltros.Visible = true;
                    TableFiltrosHermesSL.Visible = true;
                    TableFiltrosCampaigns.Visible = true;
                    TableListaFechas.Visible = true;
                    SqlDataSourceCampaigns.SelectCommand = queryCampaigns;
                }
                else
                {
                    PanelFiltros.Visible = false;
                }
            }
        }

        protected void ButtonAñadir_Click(object sender, EventArgs e)
        {
            //Fechas
            string sDateFrom = TextBoxFechaInicio.Text;
            ListItem item = new ListItem(sDateFrom);

            if (!this.ListBox1.Items.Contains(item))
            {
                if (item.Text != "")
                {
                    ListBox1.Items.Add(sDateFrom);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No has seleccionado ninguna fecha')", true);
                }
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string selectedItems = ListBox1.SelectedItem.Value;
                for (int i = 0; i < ListBox1.Items.Count; i++)
                {
                    if (ListBox1.Items[i].Text == selectedItems) ListBox1.Items.Remove(selectedItems);
                }
            }
            catch (Exception)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No has seleccionado ninguna fecha')", true);
                throw;
            }            
        }

        protected void ButtonAñadirMes_Click(object sender, EventArgs e)
        {
 
                var year = DateTime.Now.Year;

                // Loop from the first day of the month until we hit the next month, moving forward a day at a time
                for (var date = new DateTime(year, Int16.Parse(DropDownListMes.SelectedValue), 1); date.Month == Int16.Parse(DropDownListMes.SelectedValue); date = date.AddDays(1))
                {
                    string sDate = date.ToString("dd/MM/yyyy");

                    ListBox1.Items.Add(sDate);

                }
        }

        protected void DropDownListMes_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}