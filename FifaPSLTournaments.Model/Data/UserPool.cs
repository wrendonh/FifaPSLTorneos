namespace FifaPSLTournaments.Model.Data
{
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("UserPool")]
    public partial class UserPool
    {
        public int Id { get; set; }

        public int IdUser { get; set; }

        public int IdMatch { get; set; }

        public int? LocalTeamScore { get; set; }

        public int? VisitorTeamScore { get; set; }

        public int Points { get; set; }

        public virtual Match Match { get; set; }

        public virtual User User { get; set; }
    }
}
