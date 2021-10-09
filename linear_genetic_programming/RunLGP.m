numberOfGenerations = 10000;
populationSize = 100;
chromosomeBufferSize = 1000; % Max chromosome length!
initialChromosomeLength = 16;
numVariableRegisters = 10;
numConstantRegisters = 3;
numOperations = 4;
operatorSet = cell(numOperations,1);
operatorSet{1} = @plus;
operatorSet{2} = @minus;
operatorSet{3} = @mtimes; 
operatorSet{4} = @ProtectedDivision;

mutationProbability = 0.1;
tournamentProbability = 0.75;
tournamentSize = 5;
crossoverProbability = 0.8;

[population, chromosomeLengths] = InitializePopulation(populationSize,...
                                                       initialChromosomeLength,...
                                                       operatorSet,...
                                                       numVariableRegisters,...
                                                       numConstantRegisters,...
                                                       chromosomeBufferSize);

numRegisters = numVariableRegisters + numConstantRegisters;
registers = zeros(populationSize, numRegisters);
functionData = LoadFunctionData;
numSamples = size(functionData, 2);

for generation = 1:numberOfGenerations
  % Evaluation
  fitnessList = zeros(populationSize, 1);
  for iIndividual = 1:populationSize
    trueValues = functionData(:,2);
    estimates = zeros(numSamples, 1);
    for iData = 1:numSamples
      x = functionData(iData,1);
      registers(iIndividual, 1:numVariableRegisters) = 0;
      registers(iIndividual, 1) = x; 
      estimates(iData) = ExecuteChromosome(population(iIndividual,1:chromosomeLengths(iIndividual)),...
                                          registers(iIndividual,:), operatorSet);
    end
    error = RootMeanSquaredError(trueValues, estimates);
    fitnessList(iIndividual) = 1/error;
  end

  % Crossover
  temporaryPopulation = population;
  temporaryChromosomeLengths = chromosomeLengths;

  for i = 1:2:populationSize
    i1 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    i2 = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    r = rand;
    if (r < crossoverProbability) 
      individual1 = population(i1,1:chromosomeLengths(i1));
      individual2 = population(i2,1:chromosomeLengths(i2));
      [newIndividual1, newIndividual2] = Cross(individual1, individual2);
      temporaryPopulation(i,1:length(newIndividual1)) = newIndividual1;
      temporaryPopulation(i+1,1:length(newIndividual2)) = newIndividual2;
      temporaryChromosomeLengths(i) = length(newIndividual1);
      temporaryChromosomeLengths(i+1) = length(newIndividual2);
    else
      temporaryPopulation(i,:) = population(i1,:);
      temporaryPopulation(i+1,:) = population(i2,:);     
    end
  end
  
  % Mutate
  for iChromosome = 1:populationSize
    temporaryPopulation(i,1:chromosomeLengths(i)) = Mutate(temporaryPopulation(i,1:chromosomeLengths(i)), ...
                                                           mutationProbability, ...
                                                           numVariableRegisters, ...
                                                           numConstantRegisters, ...
                                                           numOperations);
  end

  for iIndividual = 1:populationSize
    population(iIndividual, 1:temporaryChromosomeLengths(iIndividual)) = ...
        temporaryPopulation(iIndividual, 1:temporaryChromosomeLengths(iIndividual));
  end
  chromosomeLengths = temporaryChromosomeLengths;
  fprintf("Generation %d\n", generation)
end

PlotFit(population(1,1:chromosomeLengths(1)));


