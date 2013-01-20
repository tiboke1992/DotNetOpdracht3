using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASPNetBoekenApplicatie
{
    public partial class _Default : System.Web.UI.Page
    {
        BoekenLinqToSqlDataContext dc = new BoekenLinqToSqlDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void categorie_dropdown_databound(Object sender, EventArgs e) {
            categorie_dropdown.Items.Insert(0, new ListItem("Alle Categorieen", "all"));
        }

        protected void uitgever_dropdown_databound(Object sender, EventArgs e) { 
            uitgever_dropdown.Items.Insert(0, new ListItem("Alle uitgevers", "all"));
        }
    }
}
