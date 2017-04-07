<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MatchControl.ascx.cs" Inherits="FifaPSLTournaments.Web.Controls.MatchControl" %>
<div>
    <div class="row">
        <div class="col-md-3 text-left">
            <asp:Label ID="lblLocalTeam" runat="server"></asp:Label>
        </div>
        <div class="col-md-2 text-left">
            <asp:TextBox ID="txtLocalTeam" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLocalTeam" runat="server" Display="Dynamic" ControlToValidate="txtLocalTeam"
                ErrorMessage="Complete el campo." Style="color:red;"/>
            <asp:RangeValidator ID="rvLocalTeam" runat="server" ControlToValidate="txtLocalTeam" Type="Integer"
                Display="Dynamic" MinimumValue="0" MaximumValue="20" ErrorMessage="Valor fuera de rango." Style="color:red;"></asp:RangeValidator>
        </div>
        <div class="col-md-2 text-left">
            <asp:Label ID="lblSeparator" runat="server" Text="-"></asp:Label>
        </div>
        <div class="col-md-2 text-left">
            <asp:TextBox ID="txtVisitorTeam" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvVisitorTeam" runat="server" Display="Dynamic" ControlToValidate="txtVisitorTeam"
                ErrorMessage="Complete el campo." Style="color:red;"/>
            <asp:RangeValidator ID="rvVisitorTeam" runat="server" ControlToValidate="txtVisitorTeam" Type="Integer"
                Display="Dynamic" MinimumValue="0" MaximumValue="20" ErrorMessage="Valor fuera de rango." Style="color:red;"></asp:RangeValidator>
        </div>
        <div class="col-md-3 text-right">
            <asp:Label ID="lblVisitorTeam" runat="server"></asp:Label>
        </div>
    </div>
</div>
<script src="../Scripts/bootstrap.min.js"></script>
<script src="../Scripts/jquery-1.9.1.min.js"></script>

