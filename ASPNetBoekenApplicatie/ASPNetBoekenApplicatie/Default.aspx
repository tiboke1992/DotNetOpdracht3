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
        <asp:Label ID="lblKlasNaam" runat="server" Text="Klas naam"></asp:Label>
&nbsp;<asp:TextBox ID="txtKlasNaam" runat="server"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblAantalLeerlingen" runat="server" Text="Aantal Leerlingen"></asp:Label>
        <asp:TextBox ID="txtAantalLeerlingen" runat="server" Width="37px"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:CheckBox ID="cbBasedOn" runat="server" Text=" " />
        &nbsp;<asp:Label ID="lblGebaseertOpKlasLijst" runat="server" 
            Text="Gebaseerd op klasLijst:"></asp:Label>
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
            DataTextField="klas" DataValueField="klas" 
            onselectedindexchanged="selecteerKlasIndexChanged">
        </asp:DropDownList>
        <asp:LinqDataSource ID="klasddl" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
            EntityTypeName="" Select="new (klas)" TableName="Boekenlijsts">
        </asp:LinqDataSource>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="id_boek"
            DataSourceID="gdvKlasBoekenLijst" Width="804px" AllowPaging="True" AllowSorting="True"
            CellPadding="4" ForeColor="#333333" GridLines="None" PageSize="4" 
            OnRowDataBound="RowDataBound" onrowupdating="UpdateBoekBoekenLijst">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                <asp:TemplateField HeaderText="Titel">
                    <ItemTemplate>
                        <%#Eval("Boek.titel") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="klas" HeaderText="klas" ReadOnly="True" SortExpression="klas"
                    Visible="False" />
                <asp:BoundField DataField="id_boek" HeaderText="id_boek" ReadOnly="True" SortExpression="id_boek"
                    Visible="False" />
                <asp:TemplateField HeaderText="Categorie">
                    <ItemTemplate>
                        <asp:Label ID="lblCity" runat="server" Text='<%# Eval("categorieID")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="lblCity" runat="server" Text='<%# Eval("categorieID")%>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="ddlCities" runat="server">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="categorieID" HeaderText="categorieID" 
                    SortExpression="categorieID" Visible="False" />
                <asp:CheckBoxField DataField="wordtverhuurd" HeaderText="Wordt verhuurd" 
                    SortExpression="wordtverhuurd" />
                <asp:BoundField DataField="huurprijs" HeaderText="huurprijs" SortExpression="huurprijs" />
                <asp:BoundField DataField="schoolprijs" HeaderText="schoolprijs" SortExpression="schoolprijs" />
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
            EntityTypeName="" TableName="BoekBoekenlijsts" Where="klas == @klas" EnableDelete="True"
            EnableUpdate="True">
            <WhereParameters>
                <asp:ControlParameter ControlID="ddlSelecteerKlas" Name="klas" PropertyName="SelectedValue"
                    Type="String" />
            </WhereParameters>
        </asp:LinqDataSource>
        <asp:Button ID="btnAddBoek" runat="server" OnClick="btnAddBoek_Click" Text="&gt;&gt;" />
        <asp:Button ID="btnRemove" runat="server" OnClick="btnRemove_Click" Text="&lt;&lt;" />
    </p>
    <p style="width: 938px">
        &nbsp;<asp:Label ID="lblStatuss" runat="server" Text="Status:"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" 
            DataSourceID="statussen" DataTextField="naam" DataValueField="statusID" 
            onselectedindexchanged="statusChanged">
        </asp:DropDownList>
        <asp:LinqDataSource ID="statussen" runat="server" 
            ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext" 
            EntityTypeName="" TableName="Status">
        </asp:LinqDataSource>
    </p>
    <p style="width: 938px">
        &nbsp;<asp:Label ID="lblOpmerking" runat="server" Text="Opmerking"></asp:Label>
        <asp:TextBox ID="txtcommentaar" runat="server" Height="55px" 
            TextMode="MultiLine"></asp:TextBox>
        <asp:Button ID="btnSlaOpmerkingOp" runat="server" 
            onclick="btnSlaOpmerkingOp_Click" Text="Save opmerking" />
    </p>
    <table class="ondersteTable">
        <tr>
            <td class="tableLings">
                <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True"
                    DataKeyNames="id" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SchoolArtikelensLinq"
                    ForeColor="#333333" GridLines="None" PageSize="5" Width="362px">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id"
                            InsertVisible="False" Visible="False" />
                        <asp:BoundField DataField="naam" HeaderText="naam" SortExpression="naam" />
                        <asp:BoundField DataField="prijs" HeaderText="prijs" SortExpression="prijs" />
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
                    EntityTypeName="" TableName="Schoolartikels" EnableDelete="True" EnableInsert="True"
                    EnableUpdate="True">
                </asp:LinqDataSource>
            </td>
            <td>
                <asp:Button ID="btnAddArtikel" runat="server" Text="&gt;&gt;" OnClick="btnAddArtikel_Click" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnRemoveArtikel" runat="server" Text="&lt;&lt;" OnClick="btnRemoveArtikel_Click" />
            </td>
            <td class="td.tableRechts">
                <asp:GridView ID="GridView4" runat="server" AllowPaging="True" DataKeyNames="klas,id_schoolartikel"
                    AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SchoolArtikelenBoekenLijstLinq"
                    ForeColor="#333333" GridLines="None" PageSize="5" Width="415px">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:TemplateField HeaderText="Artikel">
                            <ItemTemplate>
                                <%#Eval("Schoolartikel.naam") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="klas" HeaderText="klas" ReadOnly="True" SortExpression="klas"
                            Visible="False" />
                        <asp:BoundField DataField="id_schoolartikel" HeaderText="id_schoolartikel" ReadOnly="True"
                            SortExpression="id_schoolartikel" Visible="False" />
                        <asp:BoundField DataField="prijs" HeaderText="prijs" SortExpression="prijs" />
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
                    EntityTypeName="" TableName="SchoolartikelBoekenlijsts" Where="klas == @klas"
                    EnableDelete="True" EnableUpdate="True">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="ddlSelecteerKlas" Name="klas" PropertyName="SelectedValue"
                            Type="String" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </td>
        </tr>
    </table>
    <asp:LinqDataSource ID="wassup" runat="server" ContextTypeName="ASPNetBoekenApplicatie.BoekenLinqToSqlDataContext"
        EntityTypeName="" TableName="Categories">
    </asp:LinqDataSource>
</asp:Content>
