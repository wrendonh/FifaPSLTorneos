<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupPositionPlayingDayControl.ascx.cs" Inherits="FifaPSLTournaments.Web.Controls.GroupPositionPlayingDayControl" %>
<%@ Register Src="~/Controls/GroupPositionsControl.ascx" TagName="wucGroupPosition" TagPrefix="cc1" %>
<%@ Reference Control="~/Controls/PlayingDayControl.ascx" %>

<div class="row form-group">
    <cc1:wucGroupPosition ID="ucGroupPosition" runat="server"></cc1:wucGroupPosition>
</div>
<div class="row form-group" id="divPlayingDays" runat="server">    
</div>