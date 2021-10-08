function temporaryPopulation = MutatePopulation(population, bestIndividual, mutationProbability, creepMutationProbability, creepMutationRate, wMax)
  temporaryPopulation = population;
  temporaryPopulation(1,:) = bestIndividual;
  parfor i = 2:size(population, 1)
    tempIndividual = Mutate(temporaryPopulation(i,:), ...
                            mutationProbability, ...
                            creepMutationProbability, creepMutationRate, wMax);
    temporaryPopulation(i,:) = tempIndividual;
  end
  
