function velocities = InitializeVelocities(numParticles, numVariables, xMin, xMax, deltaT, alpha)
    r = rand(numParticles, numVariables);
    dX = (xMax - xMin);
    velocities = (alpha / deltaT) .* ((-(1/2) * dX) + r .* dX);
end
