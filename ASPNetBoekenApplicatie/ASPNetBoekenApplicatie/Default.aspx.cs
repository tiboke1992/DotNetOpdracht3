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

        protected void categorie_dropdown_databound(Object sender, EventArgs e)
        {
            categorie_dropdown.Items.Insert(0, new ListItem("Alle Categorieen", "alle"));
        }

        protected void uitgever_dropdown_databound(Object sender, EventArgs e)
        {
            uitgever_dropdown.Items.Insert(0, new ListItem("Alle uitgevers", "alle"));
        }

        protected void boeken_links_ids_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            if (uitgever_dropdown.SelectedValue == "alle" && categorie_dropdown.SelectedValue == "alle")
            {
                boeken_links_ids.Where = @"titel.Contains(@titelParameter) and isbn.Contains(@isbnParameter)";
                e.WhereParameters.Remove("categorieParameter");
                e.WhereParameters.Remove("uitgeverParameter");
            }
            else if (categorie_dropdown.SelectedValue == "alle")
            {
                boeken_links_ids.Where = @"titel.Contains(@titelParameter) and isbn.Contains(@isbnParameter) and Uitgever.uitgeverID.Equals(@uitgeverParameter)";
                e.WhereParameters.Remove("categorieParameter");
            }
            else if (uitgever_dropdown.SelectedValue == "alle")
            {
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
                int aantal = int.Parse(aantalLeerlingen);
                createKlas(klasNaam, aantalLeerlingen);
                gebaseerdOpKlas(klasNaam, aantal);

            }
            else
            {
                showKlasErrorMessage();
            }
        }

        private Boolean ControleVanVelden(String klasNaam, String aantalLeerlingen)
        {
            Boolean result = false;
            if (klasNaam != null && aantalLeerlingen != null && !klasNaam.Equals("") && !aantalLeerlingen.Equals("") && klasNaam.Length < 3)
            {
                //controle of klas al bestaat
                IEnumerable<Boekenlijst> blist = dc.Boekenlijsts.Where(x => x.klas == klasNaam);
                if (blist == null || blist.Count() == 0)
                {
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

        private void createKlas(String klasnaam, String aantalLeerlingen)
        {
            int aantal = int.Parse(aantalLeerlingen);
            Boekenlijst boekenlijst = new Boekenlijst
            {
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
            catch (LinqDataSourceValidationException e)
            {
                lblError.Text = "Er was een probleem bij toevoegen van de klas!";
            }
        }

        private void showKlasErrorMessage()
        {
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

        private void gebaseerdOpKlas(String klasnaam, int aantalleerlingen)
        {
            if (cbBasedOn.Checked == true)
            {
                List<BoekBoekenlijst> onzelijst = new List<BoekBoekenlijst>();
                IEnumerable<BoekBoekenlijst> hunLijst = dc.BoekBoekenlijsts.Where(x => x.klas == ddlGebaseerd.SelectedValue && x.wordtverhuurd == false);
                foreach (BoekBoekenlijst b in hunLijst)
                {
                    BoekBoekenlijst l = new BoekBoekenlijst();
                    l.klas = txtKlasNaam.Text;
                    l.id_boek = b.id_boek;
                    l.huurprijs = b.huurprijs;
                    l.schoolprijs = b.schoolprijs;
                    l.wordtverhuurd = b.wordtverhuurd;
                    l.categorieID = b.categorieID;
                    onzelijst.Add(l);
                }
                foreach (BoekBoekenlijst kk in onzelijst)
                {
                    dc.BoekBoekenlijsts.InsertOnSubmit(kk);
                }
                try
                {
                    dc.SubmitChanges();
                    lblError.Text = "";
                    lblCorrect.Text = "Klas succesvol toegevoegd!";
                }
                catch (LinqDataSourceValidationException e)
                {
                    lblError.Text = "Er was een probleem bij toevoegen van de klas!";
                }
            }
            ddlSelecteerKlas.DataBind();
            ddlGebaseerd.DataBind();
        }

        protected void btnAddBoek_Click(object sender, EventArgs e)
        {
            if (GridView1.SelectedValue != null)
            {
                int id = int.Parse(GridView1.SelectedValue.ToString());
                IEnumerable<Boek> boek = dc.Boeks.Where(x => x.id == id);
                IEnumerable<BoekBoekenlijst> ll = dc.BoekBoekenlijsts.Where(x => x.id_boek == id && x.klas == ddlSelecteerKlas.SelectedValue);
                IEnumerable<BoekBoekenlijst> lll = dc.BoekBoekenlijsts.Where(x => x.id_boek == id && x.wordtverhuurd == true);
                if (ll.Count() == 0 && lll.Count() == 0)
                {
                    Boek b = null;
                    foreach (Boek l in boek)
                    {
                        b = l;
                    }
                    BoekBoekenlijst vv = new BoekBoekenlijst
                    {
                        klas = ddlSelecteerKlas.SelectedValue,
                        id_boek = b.id,
                        huurprijs = 0,
                        schoolprijs = b.aankoopprijs,
                        wordtverhuurd = false,
                        categorieID = b.categorieID
                    };
                    dc.BoekBoekenlijsts.InsertOnSubmit(vv);
                    try
                    {
                        dc.SubmitChanges();
                        GridView2.DataBind();
                    }
                    catch (LinqDataSourceValidationException l)
                    {
                        lblError.Text = "Fout bij toevoegen boek";
                    }
                }
                else {
                    lblError.Text = "Boek wordt al uitgeleend!";
                    lblCorrect.Text = "";
                }
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            if (GridView2.SelectedValue != null)
            {
                int id = int.Parse(GridView2.SelectedValue.ToString());
                IEnumerable<BoekBoekenlijst> bblijst = dc.BoekBoekenlijsts.Where(x => x.klas == ddlSelecteerKlas.SelectedValue && x.id_boek == id);
                BoekBoekenlijst b = bblijst.First();
                dc.BoekBoekenlijsts.DeleteOnSubmit(b);
                try
                {
                    dc.SubmitChanges();
                    GridView2.DataBind();
                }
                catch (LinqDataSourceValidationException lol)
                {
                    lblError.Text = "Fout bij verwijderen boek";
                }
            }
        }

        protected void btnAddArtikel_Click(object sender, EventArgs e)
        {
            if (GridView3.SelectedValue != null && ddlSelecteerKlas.SelectedValue != null) { 
                //checken of die boekenlijst da item al heeft
                int id = int.Parse(GridView3.SelectedValue.ToString());
                IEnumerable<SchoolartikelBoekenlijst> lijst = dc.SchoolartikelBoekenlijsts.Where(x => x.klas == ddlSelecteerKlas.SelectedValue && x.id_schoolartikel == id);
                if (lijst.Count() == 0) {
                    SchoolartikelBoekenlijst l = new SchoolartikelBoekenlijst();
                    l.klas = ddlSelecteerKlas.SelectedValue;
                    l.id_schoolartikel = id;
                    Schoolartikel a = dc.Schoolartikels.Where(x => x.id == id).First();
                    l.prijs = a.prijs;
                    try
                    {
                        dc.SchoolartikelBoekenlijsts.InsertOnSubmit(l);
                        dc.SubmitChanges();
                        GridView4.DataBind();
                    }
                    catch (LinqDataSourceValidationException aze) {
                        lblError.Text = "Fout opgetreden bij toevoegen artikel aan lijst ";
                    }
                }
            }
        }

        protected void btnRemoveArtikel_Click(object sender, EventArgs e)
        {
            if (ddlSelecteerKlas != null && GridView4.SelectedValue != null) { 
                int id = int.Parse(GridView4.SelectedValue.ToString());
                SchoolartikelBoekenlijst s = dc.SchoolartikelBoekenlijsts.Where(x => x.klas == ddlSelecteerKlas.SelectedValue && x.id_schoolartikel == id).First();
                try
                {
                    dc.SchoolartikelBoekenlijsts.DeleteOnSubmit(s);
                    dc.SubmitChanges();
                    GridView4.DataBind();
                }
                catch (LinqDataSourceValidationException azerty)
                {
                    lblError.Text = "Fout opgetreden bij verwijderen artikel uit lijst ";
                }
            }
        }

        protected void RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow && GridView2.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddlCities = (DropDownList)e.Row.FindControl("ddlCities");
                var q1 = from boeks in dc.Boeks
                         select new { boeks.categorieID };
                var q2 = q1.Distinct();
                ddlCities.DataSource = q2;
                ddlCities.DataTextField = "categorieID";
                ddlCities.DataValueField = "categorieID";
                ddlCities.DataBind();
                ddlCities.Items.FindByValue((e.Row.FindControl("lblCity") as Label).Text).Selected = true;
               
            }
        }

        protected void UpdateBoekBoekenLijst(object sender, GridViewUpdateEventArgs e) {
            string categorie = (GridView2.Rows[e.RowIndex].FindControl("ddlCities") as DropDownList).SelectedItem.Value;
            string customerId = GridView2.DataKeys[e.RowIndex].Value.ToString();
            int id = int.Parse(customerId);
            var q = dc.BoekBoekenlijsts.Single(w => w.klas == ddlSelecteerKlas.SelectedValue && w.id_boek == id);
            q.categorieID = categorie;
            var f = dc.Boeks.Single(w => w.id == id);
            f.categorieID = categorie;            
            dc.SubmitChanges();
            GridView2.DataBind();
            //wordtverhuurd shit
            

        }

    }
}
