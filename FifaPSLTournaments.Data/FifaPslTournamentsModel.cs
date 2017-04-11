namespace FifaPSLTournaments.Data
{
    using System.Data.Entity;
    using Model.Data;

    public partial class FifaPslTournamentsModel : DbContext
    {
        public FifaPslTournamentsModel()
            : base("name=FifaPslTournamentsModel")
        {
        }

        public virtual DbSet<Group> Group { get; set; }
        public virtual DbSet<Match> Match { get; set; }
        public virtual DbSet<Phase> Phase { get; set; }
        public virtual DbSet<Player> Player { get; set; }
        public virtual DbSet<Role> Role { get; set; }
        public virtual DbSet<TournamentSystem> System { get; set; }
        public virtual DbSet<Team> Team { get; set; }
        public virtual DbSet<TeamPlayer> TeamPlayer { get; set; }
        public virtual DbSet<Tournament> Tournament { get; set; }
        public virtual DbSet<TournamentPositionTable> TournamentPositionTable { get; set; }
        public virtual DbSet<TournamentTeamGroup> TournamentTeamGroup { get; set; }
        public virtual DbSet<User> User { get; set; }
        public virtual DbSet<UserPool> UserPool { get; set; }
        public virtual DbSet<UserPoolPosition> UserPoolPosition { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Group>()
                .Property(e => e.Name)
                .IsFixedLength();

            modelBuilder.Entity<Group>()
                .HasMany(e => e.TournamentTeamGroup)
                .WithRequired(e => e.Group)
                .HasForeignKey(e => e.IdGroup)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Match>()
                .HasMany(e => e.UserPool)
                .WithRequired(e => e.Match)
                .HasForeignKey(e => e.IdMatch)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Phase>()
                .HasMany(e => e.Group)
                .WithRequired(e => e.Phase)
                .HasForeignKey(e => e.IdPhase)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Player>()
                .HasMany(e => e.TeamPlayer)
                .WithRequired(e => e.Player)
                .HasForeignKey(e => e.IdPlayer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Role>()
                .HasMany(e => e.User)
                .WithRequired(e => e.Role)
                .HasForeignKey(e => e.IdRol)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<TournamentSystem>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<TournamentSystem>()
                .HasMany(e => e.Tournament)
                .WithRequired(e => e.TournamentSystem)
                .HasForeignKey(e => e.IdSystem)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Team>()
                .HasMany(e => e.TeamPlayer)
                .WithRequired(e => e.Team)
                .HasForeignKey(e => e.IdTeam)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<TeamPlayer>()
                .HasMany(e => e.TournamentTeamGroup)
                .WithRequired(e => e.TeamPlayer)
                .HasForeignKey(e => e.IdTeamPlayer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Tournament>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<Tournament>()
                .HasMany(e => e.TournamentTeamGroup)
                .WithRequired(e => e.Tournament)
                .HasForeignKey(e => e.IdTournament)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Tournament>()
                .HasMany(e => e.UserPoolPosition)
                .WithRequired(e => e.Tournament)
                .HasForeignKey(e => e.IdTournament)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<TournamentTeamGroup>()
                .HasMany(e => e.Match)
                .WithRequired(e => e.TournamentTeamGroup)
                .HasForeignKey(e => e.IdLocalTeam)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<TournamentTeamGroup>()
                .HasMany(e => e.Match1)
                .WithRequired(e => e.TournamentTeamGroup1)
                .HasForeignKey(e => e.IdVisitorTeam)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<TournamentTeamGroup>()
                .HasMany(e => e.TournamentPositionTable)
                .WithRequired(e => e.TournamentTeamGroup)
                .HasForeignKey(e => e.IdTournamentTeamGroup)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.UserPool)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.IdUser)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.UserPoolPosition)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.IdUser)
                .WillCascadeOnDelete(false);
        }
    }
}
