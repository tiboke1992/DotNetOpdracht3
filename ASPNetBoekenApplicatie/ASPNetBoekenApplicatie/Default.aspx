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
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </p>
</asp:Content>
