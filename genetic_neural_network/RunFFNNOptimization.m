clear all;

%%%%%%%%%%%%%%
% Parameters %
%%%%%%%%%%%%%%

parameters = Parameters()
parameters.testRun = false;

% Genetic algorithm parameters
numGenerations = 1000;
mutationProbability = 0.1;
creepMutationProbability = 0.2;
creepMutationRate = 0.1;
populationSize = 100;
tournamentProbability = 0.75;
tournamentSize = 20;
crossoverProbability = 0.8;
nInputs = 3;
nOutputs = 2;
nHidden = 8;
wMax = 5;
saveBest = true;
patience = 50;

% Datasets
trainingSetSize = 10;
trainingSetIndex = 1;
validationSetSize = 5;
validationSetIndex = 2;
testSetSize = 5;
testSetIndex = 3;

population = InitializePopulation(populationSize, nInputs, nHidden, nOutputs, wMax);

maximumTrainFitness  = 0;
trainFitnessValues = zeros(numGenerations, 1);
maximumValidationFitness  = 0;
validationFitnessValues = zeros(numGenerations, 1);
generationsWithoutImprovement = 0;

iBestIndividual = 1;
for generation = 1:numGenerations
  trainFitnessList = zeros(1, populationSize);
  validationFitnessList = zeros(1, populationSize);

  % Evaluate population, run truck model
  parfor iIndividual = 1:populationSize
    % Read individual
    chromosome = population(iIndividual, :);
    [wIH, wHO] = DecodeChromosome(chromosome, nInputs, nHidden, nOutputs, wMax);
    
    trainFitnessList(iIndividual) = EvaluateNetwork(wIH, wHO, parameters, trainingSetIndex, trainingSetSize);
    validationFitnessList(iIndividual) = EvaluateNetwork(wIH, wHO, parameters, validationSetIndex, validationSetSize);
  end

  [bestTrainFitness, bestTrainIndex] = max(trainFitnessList, [], 'all', 'linear');
  trainFitnessValues(generation) = bestTrainFitness;
  if bestTrainFitness > maximumTrainFitness
    maximumTrainFitness = bestTrainFitness;
    iBestIndividual = bestTrainIndex;
  end

  [bestValidationFitness, bestValidationIndex] = max(validationFitnessList, [], 'all', 'linear');
  validationFitnessValues(generation) = bestValidationFitness;
  if bestValidationFitness > maximumValidationFitness
    maximumValidationFitness = bestValidationFitness;
    generationsWithoutImprovement = 0;
    if saveBest
      SaveChromosome(population(bestValidationIndex, :));
    end
  else
    generationsWithoutImprovement = generationsWithoutImprovement + 1;
  end

  % Crossover
  crossPopulation = CrossPopulation(population, trainFitnessList, ...
                                    tournamentProbability, ...
                                    tournamentSize, crossoverProbability);
  
  % Mutation
  mutatedPopulation = MutatePopulation(crossPopulation, population(iBestIndividual,:), ...
                                       mutationProbability, ...
                                       creepMutationProbability, creepMutationRate, wMax);
  
  % Replacement
  population = mutatedPopulation;

  fprintf('Gen: %d\tF_train: %.4f\tF_val: %.4f\tPatience: (%d/%d)\n', ...
          generation, maximumTrainFitness, maximumValidationFitness, ...
          generationsWithoutImprovement, patience);

  if generationsWithoutImprovement >= patience & patience ~= 0
    fprintf('Patience exceeded, early stopping the simulation.')
    break
  end
end

PlotFitness(trainFitnessValues(1:generation), validationFitnessValues(1:generation));


