namespace FifaPSLTournaments.Model
{
    public partial class UserPoolPosition
    {
        public int Id { get; set; }

        public int IdUser { get; set; }

        public int IdTournament { get; set; }

        public int Points { get; set; }

        public int Position { get; set; }

        public TournamentDto Tournament { get; set; }

        public UserDto User { get; set; }
    }
}
