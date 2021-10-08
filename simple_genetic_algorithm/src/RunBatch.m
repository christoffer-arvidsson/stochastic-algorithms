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

% Speed up by defining number of available threads, which by default is 6 for me.
## cluster = parcluster('local');
## cluster.NumWorkers = 12;
## saveProfile(cluster);

numParameters = 12;
mutationProbabilityRange = 0:numParameters-1;
mutationProbabilityRange = 0.01 .* mutationProbabilityRange;
maximumFitnessList = zeros(numParameters, numberOfRuns);
for iSearch = 1:numParameters
  mutationProbability = mutationProbabilityRange(iSearch);
  sprintf('Mutation rate = %0.5f', mutationProbability);
  for i = 1:numberOfRuns
    [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                                                    tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
    sprintf('PMut: %0.10f, Run: %d, Score: %0.10f', mutationProbability, i, maximumFitness)
    maximumFitnessList(iSearch, i) = maximumFitness;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

average = mean(maximumFitnessList, 2);
med = median(maximumFitnessList, 2);
std = sqrt(var(maximumFitnessList, 0, 2));
for iSearch = 1:numParameters
  sprintf('PMut: %0.10f, Median: %0.10f, Average: %0.10f, STD: %0.10f', mutationProbabilityRange(iSearch), med(iSearch), average(iSearch), std(iSearch))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(mutationProbabilityRange, med, '-o');
xlabel('p_{mut}');
ylabel('median fitness');
set(gcf, 'PaperUnits', 'inches');
x_width=7.25 ;y_width=4.125;
set(gca, 'YScale', 'log');
set(gcf, 'PaperPosition', [0 0 x_width y_width]);
title('Median fitness based on mutation probability');
shg
