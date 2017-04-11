namespace FifaPSLTournaments.Model
{

    public partial class MatchDto
    {
        public int Id { get; set; }

        public int IdLocalTeam { get; set; }

        public int IdVisitorTeam { get; set; }

        public int? LocalTeamScore { get; set; }

        public int? VisitorTeamScore { get; set; }

        public int PlayingDay { get; set; }

        public bool Played { get; set; }

        public TournamentTeamGroupDto LocalTeamGroup { get; set; }

        public TournamentTeamGroupDto VisitorTeamGroup { get; set; }

        public int GroupId { get; set; }
    }
}
