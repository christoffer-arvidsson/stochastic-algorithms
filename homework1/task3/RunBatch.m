%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numParameters = 10;
mutationProbabilityRange = linspace(0.02, 1.0, numParameters);
maximumFitnessList = zeros(numParameters, numberOfRuns);
parfor iSearch = 1:numParameters
  mutationProbability = mutationProbabilityRange(iSearch);
  sprintf('Mutation rate = %0.5f', mutationProbability);
  for i = 1:numberOfRuns
    [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                                                    tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
    sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
    maximumFitnessList(iSearch, i) = maximumFitness;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for iSearch = 1:numParameters
  average = mean(maximumFitnessList(iSearch));
  median = median(maximumFitnessList(iSearch));
  std = sqrt(var(maximumFitnessList(iSearch)));
  sprintf('PMut = %0.10f: Median: %0.10f, Average: %0.10f, STD: %0.10f', mutationProbabilityRange(iSearch), median, average, std)
end
