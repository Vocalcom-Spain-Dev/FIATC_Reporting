using System.Configuration;

namespace ReportingFiatc
{
    public class Utils
    {
        private static Configuration configuration = null;

        public static void setConfigurationFile(string path)
        {
            if (path == null)
            {
                var executingAssembly = System.Reflection.Assembly.GetExecutingAssembly();
                path = executingAssembly.Location;
            }
            configuration = ConfigurationManager.OpenExeConfiguration(path);
        }

        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["HermesConnectionString"].ConnectionString;
        }

        public static string getWebconfigParam(string param)
        {
            return ConfigurationManager.AppSettings[param];
        }
    }
}