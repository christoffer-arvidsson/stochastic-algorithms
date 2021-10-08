function temporaryPopulation = CrossPopulation(population, fitnessList, tournamentProbability, ...
                                               tournamentSize, crossoverProbability)
  temporaryPopulation = population;

  for i = 1:2:size(population,1)
    i1 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    i2 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    r = rand;
    if (r < crossoverProbability) 
     individual1 = population(i1,:);
     individual2 = population(i2,:);
     newIndividualPair = Cross(individual1, individual2);
     temporaryPopulation(i,:) = newIndividualPair(1,:);
     temporaryPopulation(i+1,:) = newIndividualPair(2,:);
    else
     temporaryPopulation(i,:) = population(i1,:);
     temporaryPopulation(i+1,:) = population(i2,:);     
    end
  end
end
