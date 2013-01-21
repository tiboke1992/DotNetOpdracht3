<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="ASPNetBoekenApplicatie.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p>
        Q1 :
        <asp:GridView ID="dvg1" runat="server" AllowPaging="True" 
            EnableSortingAndPagingCallbacks="True" PageSize="5">
        </asp:GridView>
    </p>
    <p>
        q2<asp:GridView ID="dvg2" runat="server" AllowPaging="True" PageSize="5">
        </asp:GridView>
    </p>
    <p>
        q3:<asp:GridView ID="dvg3" runat="server" AllowPaging="True" PageSize="5">
        </asp:GridView>
    </p>
</asp:Content>
