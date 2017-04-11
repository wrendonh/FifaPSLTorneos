<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlayingDayControl.ascx.cs" Inherits="FifaPSLTournaments.Web.Controls.PlayingDayControl" %>
<%@ Reference Control="~/Controls/MatchControl.ascx" %>

<div class="container">
    <div class="row form-group">
        <strong>
            <asp:Label ID="lblPlayingDay" meta:resourceKey="lblPlayingDay" runat="server"></asp:Label></strong>
    </div>
    <div class="row">
        <div id="divMatches" runat="server" class="col">
        </div>
    </div>
</div>
