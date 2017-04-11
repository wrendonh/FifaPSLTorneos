namespace FifaPSLTournaments.Model.Data
{
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("TournamentPositionTable")]
    public partial class TournamentPositionTable
    {
        public int Id { get; set; }

        public int IdTournamentTeamGroup { get; set; }

        public int PlayedMatches { get; set; }

        public int WonMatches { get; set; }

        public int TiedMatches { get; set; }

        public int LostMatches { get; set; }

        public int GoalsScored { get; set; }

        public int GoalsReceived { get; set; }

        public int GoalsDifference { get; set; }

        public int Points { get; set; }

        public int? Position { get; set; }

        public virtual TournamentTeamGroup TournamentTeamGroup { get; set; }
    }
}
