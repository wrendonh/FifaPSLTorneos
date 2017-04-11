namespace FifaPSLTournaments.Model.Data
{
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("UserPoolPosition")]
    public partial class UserPoolPosition
    {
        public int Id { get; set; }

        public int IdUser { get; set; }

        public int IdTournament { get; set; }

        public int Points { get; set; }

        public int Position { get; set; }

        public virtual Tournament Tournament { get; set; }

        public virtual User User { get; set; }
    }
}
