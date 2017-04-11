namespace FifaPSLTournaments.Repository
{
    using Data;
    using Model;
    using System.Collections.Generic;
    using System.Linq;
    using Model.Data;
    
    public class MatchRepository
    {
        public List<MatchDto> GetAllMatches()
        {
            List<MatchDto> response;
            using (FifaPslTournamentsModel objEntities = new FifaPslTournamentsModel())
            {
                IQueryable<MatchDto> query = (from mat in objEntities.Match
                                              select new MatchDto()
                                              {
                                                  Id = mat.Id, 
                                                  IdLocalTeam = mat.IdLocalTeam,                                                 
                                                  LocalTeamGroup = (from ttg in objEntities.TournamentTeamGroup
                                                                    where ttg.Id == mat.IdLocalTeam
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
                                                                    }).FirstOrDefault(),
                                                  IdVisitorTeam = mat.IdVisitorTeam,
                                                  VisitorTeamGroup = (from ttg in objEntities.TournamentTeamGroup
                                                                    where ttg.Id == mat.IdVisitorTeam
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
                                                                    }).FirstOrDefault(),
                                                  LocalTeamScore = mat.LocalTeamScore,
                                                  VisitorTeamScore = mat.VisitorTeamScore,
                                                  Played = mat.Played,
                                                  PlayingDay = mat.PlayingDay
                                              });

                response = query.OrderBy(x=>x.LocalTeamGroup.IdGroup).ThenBy(x=>x.PlayingDay).ToList();
            }

            return response;
        }
        
        public bool UpdateMatch(MatchDto matchDto)
        {
            bool response;
            Match match = CreateMatch(matchDto);

            using (FifaPslTournamentsModel objEntities = new FifaPslTournamentsModel())
            {
                objEntities.Match.Add(match);
                objEntities.Entry(match).State = System.Data.Entity.EntityState.Modified;
                objEntities.SaveChanges();
                
                response = true;
            }

            return response;
        }

        private Match CreateMatch(MatchDto matchDto)
        {
            Match match = new Match();
            match.Id = matchDto.Id;
            match.IdLocalTeam = matchDto.IdLocalTeam;
            match.IdVisitorTeam = matchDto.IdVisitorTeam;
            match.LocalTeamScore = matchDto.LocalTeamScore;
            match.VisitorTeamScore = matchDto.VisitorTeamScore;
            match.PlayingDay = matchDto.PlayingDay;
            match.Played = matchDto.Played;
            return match;
        }
    }
}
