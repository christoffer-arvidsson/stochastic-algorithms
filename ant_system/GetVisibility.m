function visibility = GetVisibility(cityLocation)
  visibility = zeros(size(cityLocation, 1));
  numberOfCities = length(cityLocation);
  for i = 1:numberOfCities
    for j = 1:numberOfCities
      if i == j
        visibility(i,j) = 0;
      else
        x1 = cityLocation(i,1);
        y1 = cityLocation(i,2);
        x2 = cityLocation(j,1);
        y2 = cityLocation(j,2);
        visibility(i,j) = sqrt((x2-x1)^2 + (y2 - y1)^2);
      end
    end
  end
end
