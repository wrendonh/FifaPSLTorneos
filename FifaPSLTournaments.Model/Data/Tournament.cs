namespace FifaPSLTournaments.Model.Data
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Tournament")]
    public partial class Tournament
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Tournament()
        {
            TournamentTeamGroup = new HashSet<TournamentTeamGroup>();
            UserPoolPosition = new HashSet<UserPoolPosition>();
        }

        public int Id { get; set; }

        [Required]
        [StringLength(500)]
        public string Name { get; set; }

        public string Rules { get; set; }

        public int NumberPlayers { get; set; }

        public int NumberGroups { get; set; }

        public int IdSystem { get; set; }

        public bool Active { get; set; }

        public virtual TournamentSystem TournamentSystem { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TournamentTeamGroup> TournamentTeamGroup { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UserPoolPosition> UserPoolPosition { get; set; }
    }
}
