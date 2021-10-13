function  deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
  numberOfNodes = size(pathCollection,2);
  numberOfAnts = size(pathCollection,1);

  deltaPheromoneLevel = zeros(numberOfNodes);

  for iAnt = 1:numberOfAnts
    pathLength = pathLengthCollection(iAnt);
    path = pathCollection(iAnt, :);
    startNode = path(1);
    endNode = path(end);

    for iNode = 1:numberOfNodes-1
      destination = path(iNode+1);
      source = path(iNode);
      deltaPheromoneLevel(destination,source) = deltaPheromoneLevel(destination, source) + 1/pathLength;
    end

    % Return home
    deltaPheromoneLevel(startNode,endNode) = deltaPheromoneLevel(startNode, endNode) + 1/pathLength;
  end
end

