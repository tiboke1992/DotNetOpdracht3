<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ASPNetBoekenApplicatie._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p>
        Titel:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        Categorie:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="categorieen_Ids" DataTextField="naam" 
            DataValueField="categorieID">
        </asp:DropDownList>
        <asp:LinqDataSource ID="categorieen_Ids" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" Select="new (categorieID, naam)" TableName="Categories">
        </asp:LinqDataSource>
        <br />
        Uitgever:
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
            DataSourceID="uitgever_id" DataTextField="naam" DataValueField="uitgeverID">
        </asp:DropDownList>
        <asp:LinqDataSource ID="uitgever_id" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" Select="new (uitgeverID, naam)" TableName="Uitgevers">
        </asp:LinqDataSource>
        ISBN nummer:
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataSourceID="boeken_links_ids">
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
        </asp:GridView>
        <asp:LinqDataSource ID="boeken_links_ids" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" 
            Select="new (id, isbn, titel, aankoopprijs, Uitgever, Uitgever.uitgeverID, Uitgever.naam, Categorie, Categorie.categorieID, Categorie.naam)" 
            TableName="Boeks">
        </asp:LinqDataSource>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </p>
</asp:Content>
