clear all;

%%%%%%%%%%%%%%
% Parameters %
%%%%%%%%%%%%%%

% Truck parameters
parameters = Parameters()
parameters.testRun = false;

% Network
nInputs = 3;
nOutputs = 2;
nHidden = 12;
wMax = 10;
nGenes = (nHidden*(nInputs+1)+nOutputs*(nHidden+1));

% Genetic algorithm parameters
numGenerations = 1000;
populationSize = 100;
tournamentProbability = 0.75;
tournamentSize = 5;
crossoverProbability = 0.2;
mutationProbability = 1 / nGenes;
creepMutationProbability = 0.6;
creepMutationRate = 0.2;
numElites = 1;

% Training
saveBest = true;
patience = 40;

% Datasets
trainingSetSize = 10;
trainingSetIndex = 1;
validationSetSize = 5;
validationSetIndex = 2;
testSetSize = 5;
testSetIndex = 3

population = InitializePopulation(populationSize, nInputs, nHidden, nOutputs, wMax);

maximumTrainFitness = 0;
trainFitnessValues = zeros(1,numGenerations);
maximumValidationFitness  = 0;
validationFitnessValues = zeros(1,numGenerations);
generationsWithoutImprovement = 0;

for generation = 1:numGenerations
  trainFitnessList = zeros(1, populationSize);
  validationFitnessList = zeros(1, populationSize);

  % Evaluate population, run truck model
  for iIndividual = 1:populationSize
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
  mutatedPopulation = MutatePopulation(crossPopulation, ...
                                       mutationProbability, ...
                                       creepMutationProbability, creepMutationRate, wMax);
  
  % Insert elites
  for i = 1:numElites
    mutatedPopulation(i,:) = population(bestTrainIndex,:);
  end
  population = mutatedPopulation;

  fprintf('Gen: %d\tF_train: %.4f\tF_val: %.4f\tPatience: (%d/%d)\n', ...
          generation, bestTrainFitness, bestValidationFitness, ...
          generationsWithoutImprovement, patience);

  if generationsWithoutImprovement >= patience & patience ~= 0
    fprintf('Patience exceeded, early stopping the simulation.')
    break
  end
end

figure(1)
PlotFitness(trainFitnessValues(1:generation), validationFitnessValues(1:generation));


