
numberOfGenerations = 50000;
populationSize = 100;
minInitialChromosomeLength = 5; % instructions
maxInitialChromosomeLength = 64; % instructions
initialMutationProbability = 0.04;
tournamentProbability = 0.75;
tournamentSize = 5;
crossoverProbability = 0.2;
chromosomeLengthBeforePenalty = 4*64;
numElites = 3;

numVariableRegisters = 4;
numConstantRegisters = 1;
numOperations = 4;
constants = [-1];
operatorSet = cell(numOperations,1);
operatorSet{1} = @Addition;
operatorSet{2} = @Subtraction;
operatorSet{3} = @Multiplication; 
operatorSet{4} = @ProtectedDivision;

mutationProbability = initialMutationProbability;

functionData = LoadFunctionData;
xValues = functionData(:,1);
yTrue = functionData(:,2);

population = InitializePopulation(populationSize,...
                                  operatorSet,...
                                  numVariableRegisters,...
                                  numConstantRegisters,...
                                  minInitialChromosomeLength,...
                                  maxInitialChromosomeLength);


for generation = 1:numberOfGenerations
  % Evaluation
  fitnessList = zeros(populationSize, 1);
  errorList = zeros(populationSize, 1);
  for iChromosome = 1:populationSize
    constantRegisters = constants;
    variableRegisters = zeros(numVariableRegisters, 1);
    [errorList(iChromosome), fitnessList(iChromosome), ~] = EvaluateChromosome(population(iChromosome).genes, ...
                                                                              variableRegisters, ...
                                                                              constantRegisters, ...
                                                                              operatorSet, ...
                                                                              xValues, yTrue,...
                                                                              chromosomeLengthBeforePenalty);

  end

  [~, bestIndividualIndex] = max(fitnessList);

  % Crossover
  temporaryPopulation = population(:);

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

  % Elitism
  for i = 1:numElites
    temporaryPopulation(i) = population(bestIndividualIndex);
  end

  population = temporaryPopulation;

  if mod(generation, 5) == 0
    fprintf("Generation %d\tfitness: %.2f\terror %.4f\n", ...
            generation, ...
            fitnessList(bestIndividualIndex), ...
            errorList(bestIndividualIndex))

    best = population(bestIndividualIndex).genes';
    matlab.io.saveVariablesToScript('BestChromosomeNew.m','best')

    clf
    PlotFit(best');
    drawnow
  end
end




