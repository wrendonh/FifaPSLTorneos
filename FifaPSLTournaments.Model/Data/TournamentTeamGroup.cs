namespace FifaPSLTournaments.Model.Data
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("TournamentTeamGroup")]
    public partial class TournamentTeamGroup
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TournamentTeamGroup()
        {
            Match = new HashSet<Match>();
            Match1 = new HashSet<Match>();
            TournamentPositionTable = new HashSet<TournamentPositionTable>();
        }

        public int Id { get; set; }

        public int IdTournament { get; set; }

        public int IdTeamPlayer { get; set; }

        public int IdGroup { get; set; }

        public virtual Group Group { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Match> Match { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Match> Match1 { get; set; }

        public virtual TeamPlayer TeamPlayer { get; set; }

        public virtual Tournament Tournament { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TournamentPositionTable> TournamentPositionTable { get; set; }
    }
}
