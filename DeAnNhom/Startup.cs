using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DeAnNhom.Startup))]

namespace DeAnNhom
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}