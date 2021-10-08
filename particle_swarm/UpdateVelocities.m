function velocities = UpdateVelocities(currentVelocities, currentPositions, bestParticlePositions, ...
                                       bestSwarmPosition, deltaT, c1, c2, inertiaWeight, maxVelocity)
    numParticles = length(bestParticlePositions);
    q = rand(numParticles, 1);
    r = rand(numParticles, 1);

    localContribution = c1 .* q .* ((bestParticlePositions - currentPositions) ./ deltaT);
    globalContribution = c2 .* r .* ((bestSwarmPosition - currentPositions) ./ deltaT);

    velocities = inertiaWeight .* currentVelocities + localContribution + globalContribution;
    velocities = min(velocities, maxVelocity);
    velocities = max(velocities, -maxVelocity);
end

