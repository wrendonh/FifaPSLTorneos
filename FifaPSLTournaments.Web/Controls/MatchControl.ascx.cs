namespace FifaPSLTournaments.Web.Controls
{
    using BusinessLogic;
    using Helper;
    using Model;
    using System;
    using System.Web.UI;

    public partial class MatchControl : UserControl
    {
        public event EventHandler MatchUpdated;

        public MatchDto Match { get; set; }

        public int PlayingDay { get; set; }

        public int GroupId { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        public void LoadControls()
        {
            txtId.Text = Match.Id.ToString();
            lblLocalTeam.ID = lblLocalTeam.ID + "_" + Match.IdLocalTeam.ToString();
            lblLocalTeam.Text = Helper.Truncate(Match.LocalTeamGroup.TeamPlayer.Player.Name + " (" + Match.LocalTeamGroup.TeamPlayer.Team.Name + ")", 35);
            lblScoreLocalTeam.Text = Match.LocalTeamScore == null ? string.Empty : Match.LocalTeamScore.ToString();
            txtScoreLocalTeam.Text = Match.LocalTeamScore == null ? string.Empty : Match.LocalTeamScore.ToString();
            lblVisitorTeam.ID = lblVisitorTeam.ID + "_" + Match.IdVisitorTeam.ToString();
            lblVisitorTeam.Text = Helper.Truncate(Match.VisitorTeamGroup.TeamPlayer.Player.Name + " (" + Match.VisitorTeamGroup.TeamPlayer.Team.Name + ")", 35);
            lblScoreVisitorTeam.Text = Match.VisitorTeamScore == null ? string.Empty : Match.VisitorTeamScore.ToString();
            txtScoreVisitorTeam.Text = Match.VisitorTeamScore == null ? string.Empty : Match.VisitorTeamScore.ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            char separator = '_';
            string[] idLocal = lblLocalTeam.ID.Split(separator);
            string[] idVisitor = lblVisitorTeam.ID.Split(separator);

            MatchBL matchBL = new MatchBL();
            MatchDto matchDto = new MatchDto();
            matchDto.Id = Convert.ToInt32(txtId.Text);            
            matchDto.IdLocalTeam = Convert.ToInt32(idLocal[idLocal.Length - 1]);
            matchDto.IdVisitorTeam = Convert.ToInt32(idVisitor[idLocal.Length - 1]);
            matchDto.LocalTeamScore = string.IsNullOrEmpty(txtScoreLocalTeam.Text) ? null : (int?)Convert.ToInt32(txtScoreLocalTeam.Text);
            matchDto.VisitorTeamScore = string.IsNullOrEmpty(txtScoreVisitorTeam.Text) ? null : (int?)Convert.ToInt32(txtScoreVisitorTeam.Text);
            matchDto.PlayingDay = PlayingDay;
            matchDto.Played = matchDto.LocalTeamScore != null && matchDto.VisitorTeamScore != null ? true : false;
            matchDto.GroupId = GroupId;

            if (matchBL.UpdateMatch(matchDto))
            {
                this.MatchUpdated(this, new EventArgs());
            }
        }
    }
}