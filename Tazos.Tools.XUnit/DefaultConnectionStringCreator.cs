using System;

namespace Tazos.Tools.XUnit
{
    public class DefaultConnectionStringCreator
    {
        private readonly string connectionStringName;

        public DefaultConnectionStringCreator(string connectionStringName)
        {
            this.connectionStringName = connectionStringName;
        }

        public string Create()
        {
            var number = new Random().Next();
            var databaseName = $"TestDatabase_{number}";

            var cs = System.Configuration.ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
            cs = cs.Replace("{Database}", databaseName);

            return cs;
        }
    }
}
