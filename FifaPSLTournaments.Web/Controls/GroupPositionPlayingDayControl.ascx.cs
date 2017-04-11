namespace FifaPSLTournaments.Web.Controls
{
    using Model;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using System.Web.UI;

    public partial class GroupPositionPlayingDayControl : UserControl
    {
        public event EventHandler GroupPositionPlayingDayUpdated;

        protected PlayingDayControl PlayingDay;

        public List<TournamentPositionTableDto> TournamentPositionTables { get; set; }

        public List<MatchDto> Matches { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {   
        }

        public void LoadControls()
        {
            ucGroupPosition.TournamentPositionTables = TournamentPositionTables;            
            ucGroupPosition.LoadControls();

            List<int> playingDays = Matches.Select(x => x.PlayingDay).Distinct().ToList();

            foreach (var playingDay in playingDays)
            {
                PlayingDay = (PlayingDayControl)LoadControl("~/Controls/PlayingDayControl.ascx");
                PlayingDay.Matches = Matches;
                PlayingDay.PlayingDay = playingDay;
                PlayingDay.PlayingDayUpdated += PlayingDay_PlayingDayUpdated;
                PlayingDay.LoadControls();
                divPlayingDays.Controls.Add(PlayingDay);
            }
        }

        private void PlayingDay_PlayingDayUpdated(object sender, EventArgs e)
        {
            this.GroupPositionPlayingDayUpdated(this, new EventArgs());
        }
    }
}