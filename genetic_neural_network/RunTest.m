function RunTest(iDataset, iSlope)
  nInputs = 3;
  nOutputs = 2;
  nHidden = 8;
  wMax = 5;

  truckParameters = Parameters()
  truckParameters.testRun = true;
  truckParameters.maxT = 100;

  bestChromosome = BestChromosome();
  bestChromosome = bestChromosome.chromosome;
  [wIH, wHO] = DecodeChromosome(bestChromosome, nInputs, nHidden,...
                                nOutputs, wMax);

  metrics = RunTruckModel(wIH, wHO, truckParameters, iSlope, iDataset)
  PlotMetrics(metrics, iSlope, iDataset);
end

function PlotMetrics(metrics, iSlope, iDataset)
  tiledlayout('flow');
  numberOfDatapoints = metrics.time / metrics.parameters.deltaT;
  % x = (1:numberOfDatapoints) .* metrics.parameters.deltaT;
  x = metrics.position(1:numberOfDatapoints);

  nexttile
  
  l = linspace(0, 1000, metrics.parameters.slopeLength);
  startingHeight = 100;
  angles = GetSlopeAngle(l, iSlope, iDataset);
  dl = diff(l);
  dy = dl .* tand(angles(2:end));
  y = repelem(startingHeight, 1000);
  y(2:end) = y(2:end) - cumsum(dy);
  plot(l, y)
  title('Slope')
  xlabel('Position')
  ylabel('height')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.velocity(1:numberOfDatapoints))
  title('Velocity')
  xlabel('Position')
  ylabel('$m/s$', 'Interpreter', 'latex')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.acceleration(1:numberOfDatapoints))
  title('Acceleration')
  xlabel('Position')
  ylabel('$m/s^2$', 'Interpreter', 'latex')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.slopeAngle(1:numberOfDatapoints))
  title('Slope angle')
  xlabel('Position')
  ylabel('degrees')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.brakePressure(1:numberOfDatapoints))
  title('Pedal brake pressure')
  xlabel('Position')
  ylabel('fraction activated')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.gearLevel(1:numberOfDatapoints))
  title('Gear level')
  xlabel('Position')
  ylabel('level')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.brakeTemperature(1:numberOfDatapoints))
  title('Brake temperature')
  xlabel('Position')
  ylabel('K', 'Interpreter', 'latex')
  xlim([0,metrics.parameters.slopeLength]);
end
