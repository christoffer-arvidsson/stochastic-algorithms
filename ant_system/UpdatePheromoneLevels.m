
function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
  pheromoneLevel = (1-rho) .* pheromoneLevel + deltaPheromoneLevel;
  pheromoneLevel = max(10^-15, pheromoneLevel);
end
