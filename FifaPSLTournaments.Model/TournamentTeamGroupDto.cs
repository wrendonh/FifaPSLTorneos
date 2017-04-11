namespace FifaPSLTournaments.Model
{
    public partial class TournamentTeamGroupDto
    {      
        public int Id { get; set; }

        public int IdTournament { get; set; }

        public int IdTeamPlayer { get; set; }

        public int IdGroup { get; set; }

        public GroupDto Group { get; set; }
        
        public TeamPlayerDto TeamPlayer { get; set; }

        public TournamentDto Tournament { get; set; }
    }
}
