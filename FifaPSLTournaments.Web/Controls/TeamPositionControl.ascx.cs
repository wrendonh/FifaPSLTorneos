namespace FifaPSLTournaments.Web.Controls
{
    using Model;
    using System;
    using System.Web.UI;
    using Helper;

    public partial class TeamPositionControl : UserControl
    {
        public TournamentPositionTableDto TournamentPositionTable { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        public void LoadControls()
        {
            lblPosition.Text = TournamentPositionTable.Position.ToString();
            lblTeamName.Text = Helper.Truncate(TournamentPositionTable.TournamentTeamGroup.TeamPlayer.Player.Name + " (" + TournamentPositionTable.TournamentTeamGroup.TeamPlayer.Team.Name + ")", 35);
            lblPlayedMatches.Text = TournamentPositionTable.PlayedMatches.ToString();
            lblWonMatches.Text = TournamentPositionTable.WonMatches.ToString();
            lblTiedMatches.Text = TournamentPositionTable.TiedMatches.ToString();
            lblLostMatches.Text = TournamentPositionTable.LostMatches.ToString();
            lblScoredGoals.Text = TournamentPositionTable.GoalsScored.ToString();
            lblReceivedGoals.Text = TournamentPositionTable.GoalsReceived.ToString();
            lblDifferenceGoals.Text = TournamentPositionTable.GoalsDifference.ToString();
            lblPoints.Text = TournamentPositionTable.Points.ToString();
        }
    }
}