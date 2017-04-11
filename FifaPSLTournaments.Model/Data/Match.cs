namespace FifaPSLTournaments.Model.Data
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Match")]
    public partial class Match
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Match()
        {
            UserPool = new HashSet<UserPool>();
        }

        public int Id { get; set; }

        public int IdLocalTeam { get; set; }

        public int IdVisitorTeam { get; set; }

        public int? LocalTeamScore { get; set; }

        public int? VisitorTeamScore { get; set; }

        public int PlayingDay { get; set; }

        public bool Played { get; set; }

        public virtual TournamentTeamGroup TournamentTeamGroup { get; set; }

        public virtual TournamentTeamGroup TournamentTeamGroup1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserPool> UserPool { get; set; }
    }
}
