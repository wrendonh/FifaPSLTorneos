namespace FifaPSLTournaments.Web.Tournament
{
    using BusinessLogic;
    using Controls;
    using Model;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web.UI.HtmlControls;

    public partial class TournamentTable : System.Web.UI.Page
    {
        protected GroupPositionPlayingDayControl GroupPositionPlayingDay;

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControls();
        }

        private void LoadControls()
        {
            ulTabs.Controls.Clear();
            divTabContent.Controls.Clear();

            List<TournamentPositionTableDto> tournamentPositionTables = GetTournamentPositionTables();
            List<MatchDto> matches = GetAllMatches();
            List<int> groupIds = tournamentPositionTables.Select(x => x.TournamentTeamGroup.IdGroup).Distinct().ToList();
            int count = 0;
            string activeClass = "active";

            foreach (var groupId in groupIds)
            {
                List<TournamentPositionTableDto> tournamentPositionTableByGroup = tournamentPositionTables.FindAll(x => x.TournamentTeamGroup.IdGroup == groupId);

                string divContentId = "Grupo" + groupId;

                HtmlGenericControl li = new HtmlGenericControl("li");

                if (count == 0)
                {
                    li.Attributes.Add("class", activeClass);
                }

                HtmlGenericControl anchor = new HtmlGenericControl("a");
                anchor.Attributes.Add("href", "#" + divContentId);
                anchor.Attributes.Add("data-toggle", "tab");
                anchor.InnerText = tournamentPositionTableByGroup[0].TournamentTeamGroup.Group.Name.Trim();
                li.Controls.Add(anchor);
                ulTabs.Controls.Add(li);

                List<MatchDto> matchesByGroup = matches.FindAll(x => x.LocalTeamGroup.IdGroup == groupId && x.VisitorTeamGroup.IdGroup == groupId);

                GroupPositionPlayingDay = (GroupPositionPlayingDayControl)LoadControl("~/Controls/GroupPositionPlayingDayControl.ascx");
                GroupPositionPlayingDay.Matches = matchesByGroup;
                GroupPositionPlayingDay.TournamentPositionTables = tournamentPositionTableByGroup;
                GroupPositionPlayingDay.GroupPositionPlayingDayUpdated += GroupPositionPlayingDay_GroupPositionPlayingDayUpdated;
                GroupPositionPlayingDay.LoadControls();

                HtmlGenericControl div = new HtmlGenericControl("div");
                div.ClientIDMode = System.Web.UI.ClientIDMode.Static;
                div.ID = divContentId;

                if (count == 0)
                {
                    div.Attributes.Add("class", "tab-pane" + " " + activeClass);
                }
                else
                {
                    div.Attributes.Add("class", "tab-pane");
                }

                div.Controls.Add(GroupPositionPlayingDay);
                divTabContent.Controls.Add(div);
                count++;
            }
        }

        private void GroupPositionPlayingDay_GroupPositionPlayingDayUpdated(object sender, EventArgs e)
        {
            LoadControls();
        }

        private List<MatchDto> GetAllMatches()
        {
            MatchBL matchBL = new MatchBL();
            return matchBL.GetAllMatches();
        }

        private List<TournamentPositionTableDto> GetTournamentPositionTables()
        {
            TournamentPositionTableBL tournamentPositionTableBL = new TournamentPositionTableBL();
            return tournamentPositionTableBL.GetAllTournamentPostionTables();
        }
    }
}