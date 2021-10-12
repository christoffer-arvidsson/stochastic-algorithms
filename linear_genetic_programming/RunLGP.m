
numberOfGenerations = 50000;
populationSize = 100;
minInitialChromosomeLength = 5;
maxInitialChromosomeLength = 64;
initialMutationProbability = 0.04;
tournamentProbability = 0.99;
tournamentSize = 5;
crossoverProbability = 0.2;
chromosomeLengthBeforePenalty = 4*64;
diversityMultiplier = 0;
mutationProbabilityChange = 1.1;
numElites = 3;
sharingMinimumDistance = 0.1;
sharingStrength = 1;

numVariableRegisters = 4;
numConstantRegisters = 1;
numOperations = 4;
constants = [-1, 1, 3];
operatorSet = cell(numOperations,1);
operatorSet{1} = @Addition;
operatorSet{2} = @Subtraction;
operatorSet{3} = @Multiplication; 
operatorSet{4} = @ProtectedDivision;

mutationProbability = initialMutationProbability;

functionData = LoadFunctionData;
xValues = functionData(:,1);
yTrue = functionData(:,2);
%yTrue = 9.*xValues + xValues.^2 - 3.*xValues.^3 + 2.*xValues.^4 + xValues.^6;

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
  parfor iChromosome = 1:populationSize
    constantRegisters = constants;
    variableRegisters = zeros(numVariableRegisters, 1);
    [errorList(iChromosome), fitnessList(iChromosome), ~] = EvaluateChromosome(population(iChromosome).genes, ...
                                                                              variableRegisters, ...
                                                                              constantRegisters, ...
                                                                              operatorSet, ...
                                                                              xValues, yTrue,...
                                                                              chromosomeLengthBeforePenalty);

  end

  % Compute the hamming distance between chromosome and rest of
  % population. Chromosome in dense regions have lower fitness than
  % equivalent chromosomes in sparse regions, helping keep diversity
  % in the population.
  % sharingFactors = CalculateFitnessSharing(population, sharingMinimumDistance, sharingStrength);
  % fitnessList = fitnessList ./ sharingFactors;

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

  % Update mutation probability
  % if meanDiversity < minimumDiversity
  %   mutationProbability = min(mutationProbability * mutationProbabilityChange, 1);
  % else
  %   mutationProbability = max(mutationProbability / mutationProbabilityChange, 0);
  % end

  crossoverProbability = errorList(bestIndividualIndex);
  % mutationProbability = 1 / length(population(bestIndividualIndex).genes);

  % Mutate
  for iChromosome = 1:populationSize
    temporaryPopulation(iChromosome).genes = Mutate(temporaryPopulation(iChromosome).genes, ...
                                                    mutationProbability, ...
                                                    numVariableRegisters, ...
                                                    numConstantRegisters, ...
                                                    numOperations);
  end

  for i = 1:numElites
    temporaryPopulation(i) = population(bestIndividualIndex);
  end

  population = temporaryPopulation;

  if mod(generation, 5) == 0
    fprintf("Generation %d\tfitness: %.2f\terror %.4f\tlength %d\t\tpmut %.4f\n", ...
            generation, ...
            fitnessList(bestIndividualIndex), ...
            errorList(bestIndividualIndex), ...
            length(population(4).genes) / 4, ...
            mutationProbability)

    best = population(bestIndividualIndex).genes';
    matlab.io.saveVariablesToScript('BestChromosome.m','best')

    clf
    PlotFit(best');
    drawnow
  end
end




