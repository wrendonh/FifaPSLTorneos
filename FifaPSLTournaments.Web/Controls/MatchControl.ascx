<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MatchControl.ascx.cs" Inherits="FifaPSLTournaments.Web.Controls.MatchControl" %>

<div class="row form-group">  
    <div class="col-md-1">
        <div style="display:none">
            <asp:TextBox ID="txtId" runat="server"></asp:TextBox>
        </div>
    </div>  
    <div class="col-md-3 text-left">
        <asp:Label ID="lblLocalTeam" runat="server"></asp:Label>
    </div>
    <div class="col-md-1 text-center">
        <asp:Label ID="lblScoreLocalTeam" runat="server" Visible="false" Width="50px" BorderStyle="Solid" BorderWidth="1px"></asp:Label>
        <asp:TextBox ID="txtScoreLocalTeam" runat="server" Width="50px" Style="text-align:center" MaxLength="2" Visible="true" onChange="numberOnly(this);"></asp:TextBox>        
        <asp:RangeValidator ID="rvScoreLocalTeam" runat="server" ControlToValidate="txtScoreLocalTeam" Type="Integer" ValidationGroup="Match"
            Display="Dynamic" MinimumValue="0" MaximumValue="20" ErrorMessage="Value out of range." Style="color: red;"></asp:RangeValidator>
    </div>
    <div class="col-md-2 text-center">
        <asp:Label ID="lblSeparator" runat="server" Text="-" Visible="false"></asp:Label>
        <asp:Button ID="btnSave" runat="server" meta:resourceKey="btnSave" CssClass="btn btn-info" OnClick="btnSave_Click" type="button" CausesValidation="true" ValidationGroup="Match" Visible="true"/>
    </div>
    <div class="col-md-1 text-center">
        <asp:Label ID="lblScoreVisitorTeam" runat="server" Visible="false" Width="50px" BorderStyle="Solid" BorderWidth="1px"></asp:Label>
        <asp:TextBox ID="txtScoreVisitorTeam" runat="server" Width="50px" Style="text-align:center" MaxLength="2" Visible="true" onChange="numberOnly(this);"></asp:TextBox>        
        <asp:RangeValidator ID="rvScoreVisitorTeam" runat="server" ControlToValidate="txtScoreVisitorTeam" Type="Integer" ValidationGroup="Match"
            Display="Dynamic" MinimumValue="0" MaximumValue="20" ErrorMessage="Value out of range." Style="color: red;"></asp:RangeValidator>
    </div>
    <div class="col-md-3 text-right">
        <asp:Label ID="lblVisitorTeam" runat="server"></asp:Label>
    </div>
    <div class="col-md-1"></div>
</div>


