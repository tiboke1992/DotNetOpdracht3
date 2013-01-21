﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ASPNetBoekenApplicatie._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p style="width: 938px">
        Titel:
        <asp:TextBox ID="txtTitel" runat="server">
        </asp:TextBox>
        &nbsp; Categorie:
        <asp:DropDownList ID="categorie_dropdown" runat="server" DataSourceID="categorieen_Ids"
            DataTextField="naam" DataValueField="categorieID" AutoPostBack="True" OnDataBound="categorie_dropdown_databound">
        </asp:DropDownList>
        <asp:LinqDataSource ID="categorieen_Ids" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (categorieID, naam)" TableName="Categories">
        </asp:LinqDataSource>
        <asp:LinqDataSource ID="uitgever_id" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (uitgeverID, naam)" TableName="Uitgevers">
        </asp:LinqDataSource>
        <br />
        Uitgever:
        <asp:DropDownList ID="uitgever_dropdown" runat="server" AutoPostBack="True" DataSourceID="uitgever_id"
            DataTextField="naam" DataValueField="uitgeverID" OnDataBound="uitgever_dropdown_databound">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp; ISBN nummer:
        <asp:TextBox ID="txtISBN" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataSourceID="boeken_links_ids" CellPadding="4" ForeColor="#333333"
            DataKeyNames="id" GridLines="None" PageSize="5" Width="806px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="isbn" HeaderText="isbn" ReadOnly="True" SortExpression="isbn" />
                <asp:BoundField DataField="titel" HeaderText="titel" ReadOnly="True" SortExpression="titel" />
                <asp:BoundField DataField="aankoopprijs" HeaderText="aankoopprijs" ReadOnly="True"
                    SortExpression="aankoopprijs" />
                <asp:TemplateField HeaderText="categorie">
                    <ItemTemplate>
                        <%# Eval("Categorie.naam") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="uitgever">
                    <ItemTemplate>
                        <%# Eval("Uitgever.naam") %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:LinqDataSource ID="boeken_links_ids" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (id, isbn, titel, aankoopprijs, Uitgever, Uitgever.uitgeverID, Uitgever.naam, Categorie, Categorie.categorieID, Categorie.naam)"
            TableName="Boeks" OnSelecting="boeken_links_ids_Selecting" Where="titel.contains(@titelParameter) and isbn.Contains(@isbnParameter) and Categorie.categorieID.Equals(@categorieParameter) and Uitgever.uitgeverID.Equals(@uitgeverParameter)">
            <WhereParameters>
                <asp:ControlParameter ControlID="txtTitel" Name="titelParameter" PropertyName="Text"
                    Type="String" ConvertEmptyStringToNull="false" />
                <asp:ControlParameter ControlID="txtISBN" Name="isbnParameter" PropertyName="Text"
                    Type="String" ConvertEmptyStringToNull="false" />
                <asp:ControlParameter ControlID="categorie_dropdown" Name="categorieParameter" PropertyName="SelectedValue"
                    Type="String" DefaultValue="alle" />
                <asp:ControlParameter ControlID="uitgever_dropdown" Name="uitgeverParameter" PropertyName="SelectedValue"
                    Type="String" DefaultValue="alle" />
            </WhereParameters>
        </asp:LinqDataSource>
        <br />
        Klas Naam:
        <asp:TextBox ID="txtKlasNaam" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp; Aantal leerlingen:
        <asp:TextBox ID="txtAantalLeerlingen" runat="server" Width="37px"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:CheckBox ID="cbBasedOn" runat="server" Text=" " />
        Gebaseerd op klaslijst:
        <asp:DropDownList ID="ddlGebaseerd" runat="server" DataSourceID="klassen" DataTextField="klas"
            DataValueField="klas">
        </asp:DropDownList>
        <asp:LinqDataSource ID="klassen" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (klas)" TableName="Boekenlijsts">
        </asp:LinqDataSource>
        &nbsp;
        <asp:Button ID="btnCreateKlas" runat="server" OnClick="btnCreateKlas_Click" Text="Maak klas aan" />
        <br />
        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        <asp:Label ID="lblCorrect" runat="server" ForeColor="#33CC33"></asp:Label>
        <br />
        Klas:
        <asp:DropDownList ID="ddlSelecteerKlas" runat="server" AutoPostBack="True" DataSourceID="klasddl"
            DataTextField="klas" DataValueField="klas">
        </asp:DropDownList>
        <asp:LinqDataSource ID="klasddl" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (klas)" TableName="Boekenlijsts">
        </asp:LinqDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id_boek"
            DataSourceID="gdvKlasBoekenLijst" Width="804px" AllowPaging="True" AllowSorting="True"
            CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="4">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="titel" HeaderText="Titel" ReadOnly="True" SortExpression="titel" />
                <asp:BoundField DataField="id_boek" HeaderText="id_boek" ReadOnly="True" 
                    SortExpression="id_boek" Visible="False" />
                <asp:BoundField DataField="categorieID" HeaderText="Categorie" SortExpression="categorieID" />
                <asp:BoundField DataField="wordtverhuurd" HeaderText="Verhuurd" SortExpression="wordtverhuurd" />
                <asp:BoundField DataField="huurprijs" HeaderText="HuurPrijs" SortExpression="HuurPrijs" />
                <asp:BoundField DataField="schoolprijs" HeaderText="SchoolPrijs" SortExpression="schoolprijs" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:LinqDataSource ID="gdvKlasBoekenLijst" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (klas, id_boek, huurprijs, schoolprijs, wordtverhuurd, categorieID, Boek, Boek.titel)"
            TableName="BoekBoekenlijsts" Where="klas == @klas" EnableDelete="True" EnableInsert="True"
            EnableUpdate="True">
            <WhereParameters>
                <asp:ControlParameter ControlID="ddlSelecteerKlas" Name="klas" PropertyName="SelectedValue"
                    Type="String" />
            </WhereParameters>
        </asp:LinqDataSource>
        <asp:Button ID="btnAddBoek" runat="server" OnClick="btnAddBoek_Click" Text="&gt;&gt;" />
        <asp:Button ID="btnRemove" runat="server" OnClick="btnRemove_Click" Text="&lt;&lt;" />
    </p>
   <table class="ondersteTable">
   <tr>
   <td class="tableLings">
   <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="id"
            AutoGenerateColumns="False" CellPadding="4" DataSourceID="SchoolArtikelensLinq"
            ForeColor="#333333" GridLines="None" PageSize="5" Width="362px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="naam" HeaderText="naam" ReadOnly="True" SortExpression="naam" />
                <asp:BoundField DataField="prijs" HeaderText="prijs" ReadOnly="True" SortExpression="prijs" />
                <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id"
                    Visible="False" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:LinqDataSource ID="SchoolArtikelensLinq" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (naam, prijs, id)" TableName="Schoolartikels">
        </asp:LinqDataSource>
   </td>
   <td>
   <asp:Button ID="btnAddArtikel" runat="server" Text="&gt;&gt;" 
           onclick="btnAddArtikel_Click" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnRemoveArtikel" runat="server" Text="&lt;&lt;" 
           onclick="btnRemoveArtikel_Click" />
   </td>
   <td class="td.tableRechts">
   <asp:GridView ID="GridView4" runat="server" AllowPaging="True" DataKeyNames="id_schoolartikel"
            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SchoolArtikelenBoekenLijstLinq"
            ForeColor="#333333" GridLines="None" PageSize="5" Width="415px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:TemplateField HeaderText="artikel" SortExpression="artikel">
                    <ItemTemplate>
                        <%# Eval("Schoolartikel.naam") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="prijs" HeaderText="prijs" ReadOnly="True" SortExpression="prijs" />
                <asp:BoundField DataField="klas" HeaderText="klas" ReadOnly="True" SortExpression="klas"
                    Visible="False" />
                <asp:BoundField DataField="id_schoolartikel" HeaderText="id_schoolartikel" ReadOnly="True"
                    SortExpression="id_schoolartikel" Visible="False" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:LinqDataSource ID="SchoolArtikelenBoekenLijstLinq" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (klas, id_schoolartikel, prijs, Boekenlijst, Schoolartikel)"
            TableName="SchoolartikelBoekenlijsts" Where="klas == @klas">
            <WhereParameters>
                <asp:ControlParameter ControlID="ddlSelecteerKlas" Name="klas" PropertyName="SelectedValue"
                    Type="String" />
            </WhereParameters>
        </asp:LinqDataSource>
   </td>
   </tr>
   </table>
</asp:Content>
