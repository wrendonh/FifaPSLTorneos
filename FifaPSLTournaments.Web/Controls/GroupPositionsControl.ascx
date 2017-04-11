<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupPositionsControl.ascx.cs" Inherits="FifaPSLTournaments.Web.Controls.GroupPositionsControl" %>
<%@ Register Src="~/Controls/TitlePositionControl.ascx" TagName="wucTitleControl" TagPrefix="cc1" %>
<%@ Reference Control="~/Controls/TeamPositionControl.ascx" %>

<div class="row">
    <div class="col-md-12">
        <cc1:wucTitleControl ID="ucTitleControl" runat="server" />
    </div>
    <div id="divTeamPosition" runat="server" class="col-md-12">
    </div>
</div>
