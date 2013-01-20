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
            categorie_dropdown.Items.Insert(0, new ListItem("Alle Categorieen", "alle"));
        }

        protected void uitgever_dropdown_databound(Object sender, EventArgs e) { 
            uitgever_dropdown.Items.Insert(0, new ListItem("Alle uitgevers", "alle"));
        }

        protected void boeken_links_ids_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            if (uitgever_dropdown.SelectedValue == "alle" && categorie_dropdown.SelectedValue == "alle") {
                boeken_links_ids.Where = @"titel.Contains(@titelParameter) and isbn.Contains(@isbnParameter)";
                e.WhereParameters.Remove("categorieParameter");
                e.WhereParameters.Remove("uitgeverParameter");
            }
            else if (categorie_dropdown.SelectedValue == "alle") {
                boeken_links_ids.Where = @"titel.Contains(@titelParameter) and isbn.Contains(@isbnParameter) and Uitgever.uitgeverID.Equals(@uitgeverParameter)";
                e.WhereParameters.Remove("categorieParameter");
            }
            else if (uitgever_dropdown.SelectedValue == "alle") {
                boeken_links_ids.Where = @"titel.Contains(@titelParameter) and isbn.Contains(@isbnParameter) and Categorie.CategorieID.Equals(@categorieParameter)";
                e.WhereParameters.Remove("uitgeverParameter");
            }
        }
    }
}
