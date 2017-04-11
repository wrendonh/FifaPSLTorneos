namespace FifaPSLTournaments.Model
{
    public partial class UserPoolDto
    {
        public int Id { get; set; }

        public int IdUser { get; set; }

        public int IdMatch { get; set; }

        public int? LocalTeamScore { get; set; }

        public int? VisitorTeamScore { get; set; }

        public int Points { get; set; }

        public MatchDto Match { get; set; }

        public UserDto User { get; set; }
    }
}
