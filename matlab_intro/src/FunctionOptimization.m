populationSize = 30;
numberOfGenes = 40;
crossoverProbability = 0.8;
mutationProbability = 0.025;
tournamentSelectionParameter = 0.75;
variableRange = 3.0;


population = InitializePopulation(populationSize, numberOfGenes);

fitness = zeros(populationSize, 1);
for i = 1:populationSize
  chromosome = population(i,:);
  x = DecodeChromosome(chromosome, variableRange);
  fitness(i) = EvaluateIndividual(x);
end

fitness
