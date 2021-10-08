function pathLength = GetPathLength(path,cityLocation)
  numberOfCities = length(path);
  pathLength = 0;
  for i = 1:numberOfCities-1
    deltaPosition = cityLocation(path(1,i+1)) - cityLocation(path(1,i));
    pathLength = pathLength + norm(deltaPosition);
  end

  returnDistance = norm(cityLocation(path(1,numberOfCities)) - cityLocation(path(1,1)));
  pathLength = pathLength + returnDistance;
end
