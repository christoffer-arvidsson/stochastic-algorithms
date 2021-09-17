function population = InitializePopulation(populationSize,numberOfGenes);
  population = zeros(populationSize, numberOfGenes);
  rolls = rand(populationSize, numberOfGenes);
  population(rolls < 0.5) = 0;
  population(rolls >= 0.5) = 1;
end
