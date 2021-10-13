function RunTest()
  iDataset = 3;
  iSlope = 1;
  nInputs = 3;
  nOutputs = 2;
  nHidden = 12;
  wMax = 10;

  truckParameters = Parameters()
  truckParameters.testRun = true;
  truckParameters.maxT = 10000;

  BestChromosome; % chromosome
  [wIH, wHO] = DecodeChromosome(chromosome, nInputs, nHidden,...
                                nOutputs, wMax);

  metrics = RunTruckModel(wIH, wHO, truckParameters, iSlope, iDataset);
  PlotMetrics(metrics, iSlope, iDataset);
end

function PlotMetrics(metrics, iSlope, iDataset)
  tiledlayout('flow');
  x = metrics.position(1:metrics.datapoints);

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

  plot(x, metrics.velocity(1:metrics.datapoints))
  title('Velocity')
  xlabel('Position')
  ylabel('$m/s$', 'Interpreter', 'latex')
  xlim([0,metrics.parameters.slopeLength]);
  ylim([0,metrics.parameters.maxVelocity])
  nexttile

  plot(x, metrics.acceleration(1:metrics.datapoints))
  title('Acceleration')
  xlabel('Position')
  ylabel('$m/s^2$', 'Interpreter', 'latex')
  xlim([0,metrics.parameters.slopeLength]);
  nexttile

  plot(x, metrics.slopeAngle(1:metrics.datapoints))
  title('Slope angle')
  xlabel('Position')
  ylabel('degrees')
  xlim([0,metrics.parameters.slopeLength]);
  ylim([0,metrics.parameters.maxSlopeAngle])
  nexttile

  plot(x, metrics.brakePressure(1:metrics.datapoints))
  title('Pedal brake pressure')
  xlabel('Position')
  ylabel('fraction activated')
  xlim([0,metrics.parameters.slopeLength]);
  ylim([0,1])
  nexttile

  plot(x, metrics.gearLevel(1:metrics.datapoints))
  title('Gear level')
  xlabel('Position')
  ylabel('level')
  xlim([0,metrics.parameters.slopeLength]);
  ylim([metrics.parameters.minGearLevel,metrics.parameters.maxGearLevel])
  nexttile

  plot(x, metrics.brakeTemperature(1:metrics.datapoints))
  title('Brake temperature')
  xlabel('Position')
  ylabel('K', 'Interpreter', 'latex')
  xlim([0,metrics.parameters.slopeLength]);
  ylim([0,metrics.parameters.maxTemperature])
end
