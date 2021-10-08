function positions = InitializePositions(numParticles, numVariables, xMin, xMax)
    r = rand(numParticles, numVariables);
    positions = xMin + r .* (xMax - xMin);
end