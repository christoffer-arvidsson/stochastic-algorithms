function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
  numberOfNodes = length(visibility);
  path = zeros(numberOfNodes, 1);
  visitedMask = zeros(numberOfNodes, 1) == 1;

  startNode = randi(numberOfNodes);
  path(1) = startNode;
  visitedMask(startNode) = true;

  currentNode = startNode;
  for i = 2:numberOfNodes
    selectedNode = getNextNode(currentNode, pheromoneLevel, visibility, visitedMask, alpha, beta);
    visitedMask(selectedNode) = true;
    path(i) = selectedNode;
  end

  path = transpose(path);
end

function selectedNode = getNextNode(currentNode, pheremoneLevel, visibility, visitedMask, alpha, beta)
  pheremoneUnvisited = pheremoneLevel(currentNode, ~visitedMask).^alpha;
  visibilityUnvisited = visibility(currentNode, ~visitedMask).^beta;
  normalizingFactor = sum(pheremoneUnvisited .* visibilityUnvisited);

  selectionProbabilities = pheremoneUnvisited.^alpha .* visibility(currentNode, ~visitedMask).^beta;
  selectionProbabilities = selectionProbabilities ./ normalizingFactor;

  indices = 1:length(visibility);
  unvisitedIndices = indices(~visitedMask);
  if length(unvisitedIndices) == 1
    selectedNode = unvisitedIndices(1);
  else
    selectedNode = randsample(unvisitedIndices, 1, true, selectionProbabilities);
  end

end
