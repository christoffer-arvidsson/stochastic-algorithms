function PlotSlopes(datasetIndex, datasetLength)
  tiledlayout('flow');
  x = linspace(0,1000, 1000);
  startingHeight = 100;
  for iSlope = 1:datasetLength
    angles = GetSlopeAngle(x, iSlope, datasetIndex);
    dx = diff(x);
    dy = dx .* tand(angles(2:end));
    y = repelem(startingHeight, 1000);
    y(2:end) = y(2:end) - cumsum(dy);

    nexttile
    plot(x,angles)
    ylim([0,10])
    title(sprintf('Slope %d', iSlope));
  end
end
