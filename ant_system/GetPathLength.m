function pathLength = GetPathLength(path,cityLocation)
  numberOfCities = length(path);
  pathLength = 0;
  startingCity = cityLocation(path(1,1),:);
  endingCity = cityLocation(path(1,numberOfCities),:);
  for i = 1:numberOfCities-1
    destination = cityLocation(path(1,i+1),:);
    source = cityLocation(path(1,i),:);
    deltaPosition = destination - source;
    pathLength = pathLength + norm(deltaPosition);
  end

  returnDistance = norm(startingCity - endingCity);
  pathLength = pathLength + returnDistance;
end

