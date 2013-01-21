using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASPNetBoekenApplicatie
{
    public partial class About : System.Web.UI.Page
    {
        BoekenLinqToSqlDataContext dc = new BoekenLinqToSqlDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            var q1 = from cats in dc.Categories
                     join boek in dc.Boeks on cats.categorieID equals boek.categorieID
                     group cats by cats.naam into gg
                     orderby gg.Key
                     select new { Categorie = gg.Key, aantal = gg.Count() };
            dvg1.DataSource = q1;
            dvg1.DataBind();

            var q2 = from b in dc.Boekenlijsts
                     join bb in dc.BoekBoekenlijsts on b.klas equals bb.klas
                     group new { b, bb } by bb.klas into g
                     select new { Klas = g.Key, Totale_Prijs = g.Sum(p => p.bb.wordtverhuurd == 1 ? p.bb.huurprijs * p.b.aantalLeerlingen : p.bb.schoolprijs * p.b.aantalLeerlingen) };
            this.dvg2.DataSource = q2;
            dvg2.DataBind();

            var q3 = from b in dc.BoekBoekenlijsts
                     join bb in dc.Boekenlijsts on b.klas equals bb.klas
                     join bbb in dc.Boeks on b.id_boek equals bbb.id
                     group new { b, bb, bbb } by new { bbb.titel, bbb.categorieID } into g
                     orderby g.Key.categorieID, g.Key.titel
                     select new { Titel = g.Key.titel, Cat = g.Key.categorieID, Totale_AantalStuks = g.Sum(s => s.bb.aantalLeerlingen) };
            this.dvg3.DataSource = q3;
            dvg3.DataBind();
        }
    }
}
