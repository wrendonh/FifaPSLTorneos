namespace FifaPSLTournaments.Model.Data
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Group")]
    public partial class Group
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Group()
        {
            TournamentTeamGroup = new HashSet<TournamentTeamGroup>();
        }

        public int Id { get; set; }

        public int IdPhase { get; set; }

        [Required]
        [StringLength(10)]
        public string Name { get; set; }

        public virtual Phase Phase { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TournamentTeamGroup> TournamentTeamGroup { get; set; }
    }
}
