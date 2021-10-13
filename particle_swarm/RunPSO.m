%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Particle swarm optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%%%%%%%%%
% Parameters %
%%%%%%%%%%%%%%

numIterations = 1000;
numVariables = 2;
numParticles = 50;
xMin = -5;
xMax = 5;
deltaT = 0.01;
alpha = 0.5;
maxVelocity = (xMax - xMin) / deltaT;
c1 = 2; % Cognitive component
c2 = 2; % Social component
startingInertia = 1.5; % Inertia weight
inertiaDecay = 0.99;
minimumInertia = 0.4;

%%%%%%%%%%%%%%%%%%
% Initialization %
%%%%%%%%%%%%%%%%%%

positions = InitializePositions(numParticles, numVariables, xMin, xMax);
velocities = InitializeVelocities(numParticles, numVariables, xMin, xMax, deltaT, alpha);

%%%%%%%%%%%%%%%%%%
% Run algorithm  %
%%%%%%%%%%%%%%%%%%

figure(1)

bestParticlePositions = zeros(numParticles, numVariables);
bestSwarmPosition = zeros(numVariables, 1);
w = startingInertia;
for iteration = 1:numIterations
    w = max(minimumInertia, w * inertiaDecay);
    for particleIndex = 1:numParticles
        currentObjectiveValue = EvaluateObjective(positions(particleIndex,:));
        bestObjectiveValue = EvaluateObjective(bestParticlePositions(particleIndex,:));

        bestGlobalValue = EvaluateObjective(bestSwarmPosition);
        if currentObjectiveValue < bestObjectiveValue
            bestParticlePositions(particleIndex,:) = positions(particleIndex,:);
        end
        if currentObjectiveValue < bestGlobalValue
            bestSwarmPosition = positions(particleIndex,:);
        end

    end
    velocities = UpdateVelocities(velocities, positions, bestParticlePositions, ...
                                  bestSwarmPosition, deltaT, c1, c2, w, maxVelocity);
    positions = UpdatePositions(positions, velocities, deltaT);

    if mod(iteration, 10) == 0
        fprintf("Iteration: %d\tSwarm position: (%.2f, %.2f)\tSwarm objective: %.2f\tInertia: %.2f\n", ...
                iteration, bestSwarmPosition(1), bestSwarmPosition(2), bestGlobalValue, w);
    end
    
    clf
    PlotPSO(xMin, xMax, positions, bestSwarmPosition)
    drawnow
end
