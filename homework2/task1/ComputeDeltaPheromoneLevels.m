function  deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
  numberOfNodes = length(pathCollection);
  numberOfAnts = length(pathCollection);
  deltaPheromoneLevel = zeros(numberOfNodes);
  for iAnt = 1:numberOfAnts
    for iNode = 1:numberOfNodes-1
      deltaPheromoneLevel(iNode+1,iNode) = deltaPheromoneLevel(iNode+1,iNode) + pathLengthCollection(iAnt);
    end
  end
end
