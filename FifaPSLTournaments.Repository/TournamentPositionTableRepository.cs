namespace FifaPSLTournaments.Repository
{
    using Data;
    using Model;
    using Model.Data;
    using System.Collections.Generic;
    using System.Linq;

    public class TournamentPositionTableRepository
    {
        public List<TournamentPositionTableDto> GetAllTournamentPostionTables()
        {
            List<TournamentPositionTableDto> response;
            using (FifaPslTournamentsModel objEntities = new FifaPslTournamentsModel())
            {
                IQueryable<TournamentPositionTableDto> query = (from tpt in objEntities.TournamentPositionTable
                                                                select new TournamentPositionTableDto()
                                                                {
                                                                    Id = tpt.Id,
                                                                    IdTournamentTeamGroup = tpt.IdTournamentTeamGroup,
                                                                    TournamentTeamGroup = (from ttg in objEntities.TournamentTeamGroup
                                                                                           where ttg.Id == tpt.IdTournamentTeamGroup
                                                                                           select new TournamentTeamGroupDto()
                                                                                           {
                                                                                               Id = ttg.Id,
                                                                                               IdGroup = ttg.IdGroup,
                                                                                               TeamPlayer = (from tp in objEntities.TeamPlayer
                                                                                                             where tp.Id == ttg.IdTeamPlayer
                                                                                                             select new TeamPlayerDto()
                                                                                                             {
                                                                                                                 Id = tp.Id,                                                                                                                 
                                                                                                                 Player = (from pl in objEntities.Player
                                                                                                                           where pl.Id == tp.IdPlayer
                                                                                                                           select new PlayerDto()
                                                                                                                           {
                                                                                                                               Name = pl.Name
                                                                                                                           }).FirstOrDefault(),
                                                                                                                 Team = (from tm in objEntities.Team
                                                                                                                         where tm.Id == tp.IdTeam
                                                                                                                         select new TeamDto()
                                                                                                                         {
                                                                                                                             Name = tm.Name
                                                                                                                         }).FirstOrDefault()
                                                                                                             }).FirstOrDefault(),
                                                                                               Group = (from g in objEntities.Group
                                                                                                        where g.Id == ttg.IdGroup
                                                                                                        select new GroupDto()
                                                                                                        {
                                                                                                            Name = g.Name,
                                                                                                            IdPhase = g.IdPhase
                                                                                                        }).FirstOrDefault()
                                                                                           }).FirstOrDefault(),
                                                                    PlayedMatches = tpt.PlayedMatches,
                                                                    WonMatches = tpt.WonMatches,
                                                                    TiedMatches = tpt.TiedMatches,
                                                                    LostMatches = tpt.LostMatches,
                                                                    GoalsScored = tpt.GoalsScored,
                                                                    GoalsReceived = tpt.GoalsReceived,
                                                                    GoalsDifference = tpt.GoalsDifference,
                                                                    Points = tpt.Points,
                                                                    Position = tpt.Position
                                                                });

                response = query.OrderBy(x=>x.TournamentTeamGroup.IdGroup).ThenBy(x=>x.Position).
                    ThenBy(x=>x.TournamentTeamGroup.TeamPlayer.Player.Name).ToList();
            }

            return response;
        }

        public bool UpdateTournamentPositionTable(TournamentPositionTableDto tournamentPositionTableDto)
        {
            bool response;
            TournamentPositionTable tournamentPositionTable = CreateTournamentPositionTable(tournamentPositionTableDto);

            using (FifaPslTournamentsModel objEntities = new FifaPslTournamentsModel())
            {
                objEntities.TournamentPositionTable.Add(tournamentPositionTable);
                objEntities.Entry(tournamentPositionTable).State = System.Data.Entity.EntityState.Modified;
                objEntities.SaveChanges();

                response = true;
            }

            return response;
        }

        private TournamentPositionTable CreateTournamentPositionTable(TournamentPositionTableDto tournamentPositionTableDto)
        {
            TournamentPositionTable tournamentPositionTable = new TournamentPositionTable();
            tournamentPositionTable.Id = tournamentPositionTableDto.Id;
            tournamentPositionTable.IdTournamentTeamGroup = tournamentPositionTableDto.IdTournamentTeamGroup;
            tournamentPositionTable.PlayedMatches = tournamentPositionTableDto.PlayedMatches;
            tournamentPositionTable.WonMatches = tournamentPositionTableDto.WonMatches;
            tournamentPositionTable.TiedMatches = tournamentPositionTableDto.TiedMatches;
            tournamentPositionTable.LostMatches = tournamentPositionTableDto.LostMatches;
            tournamentPositionTable.GoalsScored = tournamentPositionTableDto.GoalsScored;
            tournamentPositionTable.GoalsReceived = tournamentPositionTableDto.GoalsReceived;
            tournamentPositionTable.GoalsDifference = tournamentPositionTableDto.GoalsDifference;
            tournamentPositionTable.Points = tournamentPositionTableDto.Points;
            tournamentPositionTable.Position = tournamentPositionTableDto.Position;
            return tournamentPositionTable;
        }
    }
}
