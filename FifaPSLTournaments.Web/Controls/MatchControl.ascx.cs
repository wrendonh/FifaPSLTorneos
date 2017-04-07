using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FifaPSLTournaments.Web.Controls
{
    public partial class MatchControl : System.Web.UI.UserControl
    {
        public string LocalTeam { get; set; }
        public string VisitorTeam { get; set; }
        public int ScoreLocalTeam { get; set; }
        public int ScoreVisitorTeam { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}