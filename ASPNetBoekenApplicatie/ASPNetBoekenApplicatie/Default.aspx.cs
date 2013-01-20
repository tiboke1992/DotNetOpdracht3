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

        protected void btnCreateKlas_Click(object sender, EventArgs e)
        {
            String klasNaam = txtKlasNaam.Text.Trim();
            String aantalLeerlingen = txtAantalLeerlingen.Text.Trim();

            if (ControleVanVelden(klasNaam, aantalLeerlingen))
            {
                createKlas(klasNaam, aantalLeerlingen);
                gebaseerdOpKlas();
            }
            else {
                showKlasErrorMessage();
            }
        }

        private Boolean ControleVanVelden(String klasNaam, String aantalLeerlingen) {
            Boolean result = false;
            if (klasNaam != null && aantalLeerlingen != null && !klasNaam.Equals("") && !aantalLeerlingen.Equals("") && klasNaam.Length < 3) {
                //controle of klas al bestaat
                IEnumerable<Boekenlijst> blist = dc.Boekenlijsts.Where(x => x.klas == klasNaam);
                if (blist == null || blist.Count() == 0) {
                    int number;
                    Boolean isNumber = int.TryParse(aantalLeerlingen, out number);
                    if (isNumber && number > 0)
                    {
                        result = true;
                    }
                }
            }
            return result;
        }

        private void createKlas(String klasnaam, String aantalLeerlingen) {
            int aantal = int.Parse(aantalLeerlingen);
            Boekenlijst boekenlijst = new Boekenlijst { 
                aantalLeerlingen = aantal,
                klas = klasnaam,
                statusID = 1,
                laatstewijziging = DateTime.Now
            };
            dc.Boekenlijsts.InsertOnSubmit(boekenlijst);
            try
            {
                dc.SubmitChanges();
                lblError.Text = "";
                lblCorrect.Text = "Klas succesvol toegevoegd!";
            }
            catch (LinqDataSourceValidationException e) {
                lblError.Text = "Er was een probleem bij toevoegen van de klas!";
            }
        }

        private void showKlasErrorMessage() {
            lblError.Text = "Er is een fout opget bij de controle van de gegevens mogelijk door: <br />";
            lblError.Text += "<ul>";
            lblError.Text += "<li>Naam of aantal leerlingen is niet ingevuld</li>";
            lblError.Text += "<li>Klas bestaat al</li>";
            lblError.Text += "<li>Naam is langer dan 3 tekens</li>";
            lblError.Text += "<li>Aantal leerlingen is negatief of geen heel getal</li>";
            lblError.Text += "<li>Error met de databank</li>";
            lblError.Text += "</ul>";
            lblCorrect.Text = "";
        }

        private void gebaseerdOpKlas() {
            if (cbBasedOn.Checked == true) {
                List<BoekBoekenlijst> onzeLijst = new List<BoekBoekenlijst>();
                IEnumerable<BoekBoekenlijst> bblijst = dc.BoekBoekenlijsts.Where(x => x.klas == ddlGebaseerd.SelectedValue);
                if (bblijst.Count() != 0) {
                    foreach (BoekBoekenlijst bb in bblijst) {
                        bb.klas = txtKlasNaam.Text;
                        onzeLijst.Add(bb);
                    }
                }
                dc.BoekBoekenlijsts.InsertAllOnSubmit(onzeLijst);
                try
                {
                    dc.SubmitChanges();
                }
                catch (LinqDataSourceValidationException e)
                {
                    showKlasErrorMessage();
                }
            }
        }

    }
}
