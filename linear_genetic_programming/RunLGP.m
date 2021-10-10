
numberOfGenerations = 50000;
populationSize = 1000;
initialChromosomeLength = 256;
mutationProbability = 0.05;
tournamentProbability = 0.75;
tournamentSize = 5;
crossoverProbability = 0.8;
chromosomeLengthBeforePenalty = 4 * 64;
chromosomeLengthPenaltyFactor = 0.95;

numVariableRegisters = 4;
numConstantRegisters = 1;
numOperations = 4;
constants = [-0.8];
operatorSet = cell(numOperations,1);
operatorSet{1} = @plus;
operatorSet{2} = @minus;
operatorSet{3} = @mtimes; 
operatorSet{4} = @ProtectedDivision;

population = InitializePopulation(populationSize,...
                                  initialChromosomeLength,...
                                  operatorSet,...
                                  numVariableRegisters,...
                                  numConstantRegisters);

functionData = LoadFunctionData;
xValues = functionData(:,1);
yTrue = functionData(:,2);
numSamples = size(functionData, 2);
constantRegisters = constants;

for generation = 1:numberOfGenerations
  % Evaluation
  fitnessList = zeros(populationSize, 1);
  parfor iChromosome = 1:populationSize
    variableRegisters = zeros(numVariableRegisters, 1);
    [fitnessList(iChromosome), ~] = EvaluateChromosome(population(iChromosome).genes, ...
                                                       variableRegisters, ...
                                                       constantRegisters, ...
                                                       operatorSet, ...
                                                       xValues, yTrue,...
                                                       chromosomeLengthBeforePenalty, ...
                                                       chromosomeLengthPenaltyFactor);
  end

  [~, bestIndividualIndex] = max(fitnessList);

  % Crossover
  temporaryPopulation = population;
  
  for iChromosome = 1:2:populationSize
    i1 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    i2 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    individual1 = population(i1).genes;
    individual2 = population(i2).genes;
    r = rand;
    if (r < crossoverProbability) 
      [newIndividual1, newIndividual2] = Cross(individual1, individual2);
      temporaryPopulation(iChromosome).genes = newIndividual1;
      temporaryPopulation(iChromosome+1).genes = newIndividual2;
    else
      temporaryPopulation(iChromosome).genes = individual1;
      temporaryPopulation(iChromosome+1).genes = individual2;     
    end
  end
  
  % Mutate
  for iChromosome = 1:populationSize
    temporaryPopulation(iChromosome).genes = Mutate(temporaryPopulation(iChromosome).genes, ...
                                                    mutationProbability, ...
                                                    numVariableRegisters, ...
                                                    numConstantRegisters, ...
                                                    numOperations);
  end
  
  temporaryPopulation(1).genes = population(bestIndividualIndex).genes;
  population = temporaryPopulation;

  fprintf("Generation %d\tfitness: %.2f\terror %.4f\tlength %d\n", generation, ...
          max(fitnessList), 1/max(fitnessList), length(population(2).genes))

  mutationProbability = 1/length(population(1).genes);

  if mod(generation, 5) == 0
    clf
    PlotFit(population(1).genes);
    drawnow
  end
end





