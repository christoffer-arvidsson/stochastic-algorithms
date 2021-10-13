function visibility = GetVisibility(cityLocation)
  visibility = zeros(size(cityLocation, 1));
  numberOfCities = length(cityLocation);
  for i = 1:numberOfCities
    for j = 1:numberOfCities
      deltaPosition = cityLocation(j,:) - cityLocation(i,:);
      visibility(i,j) = norm(deltaPosition);
    end
  end
  visibility = 1./visibility;
end
