function temporaryPopulation = MutatePopulation(population, mutationProbability, ...
                                                creepMutationProbability, creepMutationRate, wMax)
  temporaryPopulation = population;
  for i = 1:size(population, 1)
    temporaryPopulation(i, :) = Mutate(population(i,:), mutationProbability, ...
                                       creepMutationProbability, creepMutationRate, wMax);
  end
end
  
