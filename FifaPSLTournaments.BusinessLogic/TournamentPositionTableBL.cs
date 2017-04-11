namespace FifaPSLTournaments.BusinessLogic
{
    using Model;
    using System.Collections.Generic;
    using Repository;
    using System.Threading.Tasks;
    using System.Linq;

    public class TournamentPositionTableBL
    {
        public List<TournamentPositionTableDto> GetAllTournamentPostionTables()
        {
            TournamentPositionTableRepository tournamentPostionTableRepository = new TournamentPositionTableRepository();
            return tournamentPostionTableRepository.GetAllTournamentPostionTables();
        }

        public bool UpdateTournamentPostionTable(TournamentPositionTableDto tournamentPositionTableDto)
        {
            TournamentPositionTableRepository tournamentPostionTableRepository = new TournamentPositionTableRepository();
            return tournamentPostionTableRepository.UpdateTournamentPositionTable(tournamentPositionTableDto);
        }

        public List<TournamentPositionTableDto> CalculatePositions(List<MatchDto> matchesByGroup, int groupId)
        {
            List<TournamentPositionTableDto> tournamentPositionTablesToReturn = new List<TournamentPositionTableDto>();
            List<TournamentPositionTableDto> tournamentPositionTables = GetAllTournamentPostionTables();
            List<TournamentPositionTableDto> tournamentPositionTablesByGroup = tournamentPositionTables.FindAll(x => x.TournamentTeamGroup.IdGroup == groupId);

            foreach (var tournamentPositionTable in tournamentPositionTablesByGroup)
            {
                List<MatchDto> matchesPlayedByTeam = matchesByGroup.FindAll(x => (x.IdLocalTeam == tournamentPositionTable.IdTournamentTeamGroup || x.IdVisitorTeam == tournamentPositionTable.IdTournamentTeamGroup) && x.Played);

                TournamentPositionTableDto tournamentPositionTableDto = new TournamentPositionTableDto();
                tournamentPositionTableDto.Id = tournamentPositionTable.Id;
                tournamentPositionTableDto.IdTournamentTeamGroup = tournamentPositionTable.IdTournamentTeamGroup;
                tournamentPositionTableDto.PlayedMatches = matchesPlayedByTeam.Count();
                tournamentPositionTableDto.WonMatches = matchesPlayedByTeam.Where(x => (x.IdLocalTeam == tournamentPositionTable.IdTournamentTeamGroup && x.LocalTeamScore > x.VisitorTeamScore) ||
                (x.IdVisitorTeam == tournamentPositionTable.IdTournamentTeamGroup && x.LocalTeamScore < x.VisitorTeamScore)).Count();
                tournamentPositionTableDto.TiedMatches = matchesPlayedByTeam.Where(x => x.LocalTeamScore == x.VisitorTeamScore).Count();
                tournamentPositionTableDto.LostMatches = matchesPlayedByTeam.Where(x => (x.IdLocalTeam == tournamentPositionTable.IdTournamentTeamGroup && x.LocalTeamScore < x.VisitorTeamScore) ||
                (x.IdVisitorTeam == tournamentPositionTable.IdTournamentTeamGroup && x.LocalTeamScore > x.VisitorTeamScore)).Count();
                tournamentPositionTableDto.GoalsScored = matchesPlayedByTeam.Where(x=> x.IdLocalTeam == tournamentPositionTable.IdTournamentTeamGroup).Sum(x=>(int)x.LocalTeamScore) + 
                    matchesPlayedByTeam.Where(x => x.IdVisitorTeam == tournamentPositionTable.IdTournamentTeamGroup).Sum(x => (int)x.VisitorTeamScore);
                tournamentPositionTableDto.GoalsReceived = matchesPlayedByTeam.Where(x => x.IdLocalTeam == tournamentPositionTable.IdTournamentTeamGroup).Sum(x => (int)x.VisitorTeamScore) +
                    matchesPlayedByTeam.Where(x => x.IdVisitorTeam == tournamentPositionTable.IdTournamentTeamGroup).Sum(x => (int)x.LocalTeamScore);
                tournamentPositionTableDto.GoalsDifference = tournamentPositionTableDto.GoalsScored - tournamentPositionTableDto.GoalsReceived;
                tournamentPositionTableDto.Points = (tournamentPositionTableDto.WonMatches * 3) + tournamentPositionTableDto.TiedMatches;

                tournamentPositionTablesToReturn.Add(tournamentPositionTableDto);
            }

            tournamentPositionTablesToReturn = tournamentPositionTablesToReturn.OrderByDescending(x => x.Points).ThenByDescending(x => x.GoalsDifference).ThenByDescending(x => x.GoalsScored).ThenBy(x => x.GoalsReceived).ToList();

            int count = 1;
            foreach (var tournamentPosition in tournamentPositionTablesToReturn)
            {
                tournamentPosition.Position = count;
                count++;
            }            

            return tournamentPositionTablesToReturn;
        }

    }
}
