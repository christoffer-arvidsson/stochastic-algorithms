function positions = UpdatePositions(currentPositions, currentVelocities, deltaT)
    positions = currentPositions + currentVelocities .* deltaT;
end

