<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ASPNetBoekenApplicatie._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p style="width: 938px">
        Titel:
        <asp:TextBox ID="txtTitel" runat="server">
        </asp:TextBox>
        &nbsp;
        Categorie:
        <asp:DropDownList ID="categorie_dropdown" runat="server"
            DataSourceID="categorieen_Ids" DataTextField="naam" 
            DataValueField="categorieID" 
            AutoPostBack="True" OnDataBound="categorie_dropdown_databound">
        </asp:DropDownList>
        <asp:LinqDataSource ID="categorieen_Ids" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" Select="new (categorieID, naam)" TableName="Categories"> 
        </asp:LinqDataSource>
        <asp:LinqDataSource ID="uitgever_id" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" Select="new (uitgeverID, naam)" TableName="Uitgevers">
        </asp:LinqDataSource>
        <br />
        Uitgever:
        <asp:DropDownList ID="uitgever_dropdown" runat="server" AutoPostBack="True" 
            DataSourceID="uitgever_id" DataTextField="naam" DataValueField="uitgeverID"
            OnDataBound="uitgever_dropdown_databound">
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;
        ISBN nummer:
        <asp:TextBox ID="txtISBN" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" 
            DataSourceID="boeken_links_ids" CellPadding="4" ForeColor="#333333" 
            GridLines="None" PageSize="5" Width="806px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="isbn" HeaderText="isbn" ReadOnly="True" 
                    SortExpression="isbn" />
                <asp:BoundField DataField="titel" HeaderText="titel" ReadOnly="True" 
                    SortExpression="titel" />
                <asp:BoundField DataField="aankoopprijs" HeaderText="aankoopprijs" 
                    ReadOnly="True" SortExpression="aankoopprijs" />
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
        <asp:LinqDataSource ID="boeken_links_ids" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" 
            Select="new (id, isbn, titel, aankoopprijs, Uitgever, Uitgever.uitgeverID, Uitgever.naam, Categorie, Categorie.categorieID, Categorie.naam)" 
            TableName="Boeks" onselecting="boeken_links_ids_Selecting"
            Where="titel.contains(@titelParameter) and isbn.Contains(@isbnParameter) and Categorie.categorieID.Equals(@categorieParameter) and Uitgever.uitgeverID.Equals(@uitgeverParameter)">
            <WhereParameters>
            <asp:ControlParameter ControlID="txtTitel" Name="titelParameter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="txtISBN" Name="isbnParameter" PropertyName="Text" Type="String" ConvertEmptyStringToNull="false" />
            <asp:ControlParameter ControlID="categorie_dropdown" Name="categorieParameter" PropertyName="SelectedValue" Type="String" DefaultValue="alle" />
            <asp:ControlParameter ControlID="uitgever_dropdown" Name="uitgeverParameter" PropertyName="SelectedValue" Type="String" DefaultValue="alle" />
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
        <asp:DropDownList ID="ddlGebaseerd" runat="server" DataSourceID="klassen" 
            DataTextField="klas" DataValueField="klas">
        </asp:DropDownList>
        <asp:LinqDataSource ID="klassen" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" Select="new (klas)" TableName="Boekenlijsts">
        </asp:LinqDataSource>
&nbsp;
        <asp:Button ID="btnCreateKlas" runat="server" onclick="btnCreateKlas_Click" 
            Text="Maak klas aan" />
        <br />
        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
        <asp:Label ID="lblCorrect" runat="server" ForeColor="#33CC33"></asp:Label>
        <br />
        Klas:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="klasddl" DataTextField="klas" DataValueField="klas">
        </asp:DropDownList>
        <asp:LinqDataSource ID="klasddl" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" Select="new (klas)" TableName="Boekenlijsts">
        </asp:LinqDataSource>
        <br />
    </p>
</asp:Content>
