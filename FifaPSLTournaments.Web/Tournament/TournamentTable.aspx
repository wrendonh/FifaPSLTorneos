<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TournamentTable.aspx.cs" Inherits="FifaPSLTournaments.Web.Tournament.TournamentTable" %>

<%@ Reference Control="~/Controls/GroupPositionPlayingDayControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <ul class="nav nav-pills" id="ulTabs" runat="server" clientidmode="Static">
        </ul>
        <div class="tab-content clearfix" id="divTabContent" runat="server" clientidmode="Static">
        </div>
    </div>
    <script src="../Scripts/General.js"></script>
</asp:Content>
