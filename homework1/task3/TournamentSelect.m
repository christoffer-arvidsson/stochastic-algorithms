function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
  populationSize = size(fitnessList, 2);
  tournamentIndividuals = randsample(populationSize, tournamentSize);
  eligableMask = ones(size(tournamentIndividuals)) == 1;
  indices = 1:populationSize;

  for iRound = 1:tournamentSize
    eligableIndividuals = tournamentIndividuals(eligableMask);
    tournamentFitness = fitnessList(eligableIndividuals);
    [~, iBestFitness] = max(tournamentFitness);

    roll = rand;
    if roll < tournamentProbability || iRound == tournamentSize
      # Done if we roll below, or if only one individual remains
      selectedIndividualIndex = eligableIndividuals(iBestFitness);
      break
    else
      # Remove from tournament. Since iBestFitness is masked, we need to
      # translate it into an unmasked index which the mask array needs to be updated.
      realIndices = indices(eligableMask);
      i = realIndices(iBestFitness);
      eligableMask(i) = false;
    end
  end
end
