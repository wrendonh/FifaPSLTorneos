namespace FifaPSLTournaments.Model
{   
    public partial class TeamPlayerDto
    {        
        public int Id { get; set; }

        public int IdTeam { get; set; }

        public int IdPlayer { get; set; }

        public PlayerDto Player { get; set; }

        public TeamDto Team { get; set; }
    }
}
