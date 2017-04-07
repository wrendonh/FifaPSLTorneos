<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PlayingDayControl.ascx.cs" Inherits="FifaPSLTournaments.Web.Controls.PlayingDayControl" %>
<%@ Register Src="~/Controls/MatchControl.ascx" TagName="wucMatchControl" TagPrefix="cc1" %>

<div class="container">
    <div class="row">
        <div class="col">
            <asp:Label ID="lblPlayingDay" meta:resourceKey="lblPlayingDay" runat="server"></asp:Label>
        </div>
        <div id="divMatches" runat="server" class="col">

        </div>
    </div>
</div>