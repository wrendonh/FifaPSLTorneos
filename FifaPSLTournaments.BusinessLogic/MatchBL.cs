namespace FifaPSLTournaments.BusinessLogic
{
    using Model;
    using System.Collections.Generic;
    using Repository;
    using System;
    using System.Transactions;

    public class MatchBL
    {
        public List<MatchDto> GetAllMatches()
        {
            MatchRepository matchRepository = new MatchRepository();
            return matchRepository.GetAllMatches();
        }

        public bool UpdateMatch(MatchDto matchDto)
        {
            bool bOk = false;

            try
            {
                TransactionOptions options = new TransactionOptions
                {
                    IsolationLevel = IsolationLevel.ReadUncommitted
                };

                using (TransactionScope ts = new TransactionScope(TransactionScopeOption.Required, options))
                {
                    MatchRepository matchRepository = new MatchRepository();
                    matchRepository.UpdateMatch(matchDto);
                    
                    List<MatchDto> matches = GetAllMatches();
                    if (matches.Count > 0)
                    {
                        List<MatchDto> matchesByGroup = matches.FindAll(x => x.LocalTeamGroup.IdGroup == matchDto.GroupId);
                        TournamentPositionTableBL tournamentPositionTableBL = new TournamentPositionTableBL();
                        List<TournamentPositionTableDto> tournamentPositionTables = tournamentPositionTableBL.CalculatePositions(matchesByGroup, matchDto.GroupId);

                        foreach (var tournamentPositionTable in tournamentPositionTables)
                        {
                            tournamentPositionTableBL.UpdateTournamentPostionTable(tournamentPositionTable);
                        }
                    }

                    ts.Complete();
                    bOk = true;
                }
            }
            catch (Exception)
            {
                bOk = false;
            }

            return bOk;
        }
    }
}
