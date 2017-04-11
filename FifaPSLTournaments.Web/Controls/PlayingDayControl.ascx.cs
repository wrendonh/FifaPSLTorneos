namespace FifaPSLTournaments.Web.Controls
{
    using Model;
    using System;
    using System.Collections.Generic;
    using System.Web.UI;

    public partial class PlayingDayControl : UserControl
    {
        public event EventHandler PlayingDayUpdated;

        protected MatchControl Match;
        
        public int PlayingDay { get; set; }

        public List<MatchDto> Matches { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        public void LoadControls()
        {
            string playingDay = PlayingDay.ToString();
            lblPlayingDay.Text = string.Format(GetLocalResourceObject("lblPlayingDay.Text").ToString(), playingDay);
            foreach (var match in Matches.FindAll(x=>x.PlayingDay == PlayingDay))
            {
                Match = (MatchControl)LoadControl("~/Controls/MatchControl.ascx");
                Match.Match = match;
                Match.PlayingDay = PlayingDay;
                Match.GroupId = match.LocalTeamGroup.IdGroup;
                Match.MatchUpdated += Match_MatchUpdated;
                Match.LoadControls();                
                divMatches.Controls.Add(Match);
            }
        }

        private void Match_MatchUpdated(object sender, EventArgs e)
        {
            this.PlayingDayUpdated(this, new EventArgs());
        }
    }
}