namespace FifaPSLTournaments.Model.Data
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("TeamPlayer")]
    public partial class TeamPlayer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public TeamPlayer()
        {
            TournamentTeamGroup = new HashSet<TournamentTeamGroup>();
        }

        public int Id { get; set; }

        public int IdTeam { get; set; }

        public int IdPlayer { get; set; }

        public virtual Player Player { get; set; }

        public virtual Team Team { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TournamentTeamGroup> TournamentTeamGroup { get; set; }
    }
}
