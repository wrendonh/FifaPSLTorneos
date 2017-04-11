namespace FifaPSLTournaments.Model
{
    public partial class TournamentDto
    {       
        public int Id { get; set; }

        public string Name { get; set; }

        public string Rules { get; set; }

        public int NumberPlayers { get; set; }

        public int NumberGroups { get; set; }

        public int IdSystem { get; set; }

        public bool Active { get; set; }

        public TournamentSystemDto TournamentSystem { get; set; }
    }
}
