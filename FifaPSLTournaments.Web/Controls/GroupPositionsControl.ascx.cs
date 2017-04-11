namespace FifaPSLTournaments.Web.Controls
{
    using FifaPSLTournaments.Model;
    using System;
    using System.Collections.Generic;
    using System.Web.UI;

    public partial class GroupPositionsControl : UserControl
    {
        protected TeamPositionControl TeamPosition;

        public List<TournamentPositionTableDto> TournamentPositionTables { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {            
        }

        public void LoadControls()
        {
            int count = 1;
            foreach (var tournamentPositionTable in TournamentPositionTables)
            {
                tournamentPositionTable.Position = count;
                TeamPosition = (TeamPositionControl)LoadControl("~/Controls/TeamPositionControl.ascx");
                TeamPosition.TournamentPositionTable = tournamentPositionTable;
                TeamPosition.LoadControls();

                divTeamPosition.Controls.Add(TeamPosition);
                count++;
            }
        }
    }
}