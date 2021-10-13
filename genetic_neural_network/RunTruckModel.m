function metrics = RunTruckModel(wIH, wHO, parameters, slopeIndex, datasetIndex)

  % Simulation
  p = parameters;

  metrics = struct;
  if p.testRun == true;
    numberOfDatapoints = p.maxT / p.deltaT + 1;
    metrics.velocity = zeros(numberOfDatapoints, 1);
    metrics.acceleration = zeros(numberOfDatapoints, 1);
    metrics.slopeAngle = zeros(numberOfDatapoints, 1);
    metrics.brakePressure = zeros(numberOfDatapoints, 1);
    metrics.gearLevel = zeros(numberOfDatapoints, 1);
    metrics.brakeTemperature = zeros(numberOfDatapoints, 1);
    metrics.parameters = p;
  end

  truckPosition = p.startPosition;
  truckVelocity = p.startVelocity;
  truckAcceleration = p.startAcceleration;
  gearLevel = p.startGearLevel;
  brakeTemperature = p.startBrakeTemperature;
  brakePressure = 0;
  slopeAngle = GetSlopeAngle(truckPosition, slopeIndex, datasetIndex);

  timeSinceGearChange = p.timeBetweenGearChange;
  t = 0;
  iteration = 1;
  while truckPosition < p.slopeLength
    % Metrics
    if p.testRun == true
      metrics.position(iteration) = truckPosition;
      metrics.velocity(iteration) = truckVelocity;
      metrics.acceleration(iteration) = truckAcceleration;
      metrics.slopeAngle(iteration) = slopeAngle;
      metrics.brakePressure(iteration) = brakePressure;
      metrics.gearLevel(iteration) = gearLevel;
      metrics.brakeTemperature(iteration) = brakeTemperature;
    end

    % Compute state
    slopeAngle = GetSlopeAngle(truckPosition, slopeIndex, datasetIndex);
    truckAcceleration = CalculateAcceleration(brakePressure, gearLevel, ...
                                              p.gearConstant, p.mass, slopeAngle, ...
                                              p.gravityConstant, brakeTemperature, ...
                                              p.maxTemperature);
    truckVelocity = UpdateVelocity(truckVelocity, truckAcceleration, p.deltaT); 
    truckPosition = UpdatePosition(truckPosition, truckVelocity, slopeAngle, p.deltaT);

    brakeTemperature = UpdateBrakeTemperature(brakeTemperature, ...
                                              brakePressure, p.tau, p.Ch, ...
                                              p.ambientTemperature, ...
                                              p.deltaT);


    % Take action
    state = [(truckVelocity/p.maxVelocity) (slopeAngle/p.maxSlopeAngle) (brakeTemperature/p.maxTemperature)];
    [brakePressure, desiredGearChange] = FeedForward(state, wIH, wHO, p.activationConstant);
    if timeSinceGearChange >= p.timeBetweenGearChange
      newGearLevel = UpdateGearLevel(gearLevel, desiredGearChange, p.minGearLevel, p.maxGearLevel);
      if newGearLevel ~= gearLevel
        timeSinceGearChange = 0;
        gearLevel = newGearLevel;
      end
    end

    % Violation check
    if (truckVelocity > p.maxVelocity) | (truckVelocity < p.minVelocity) | (brakeTemperature > p.maxTemperature)
      break
    end

    % Update time
    t = t + p.deltaT;
    iteration = iteration + 1;
    timeSinceGearChange = timeSinceGearChange + p.deltaT;
  end

  % Collect metrics
  metrics.averageSpeed = truckPosition / t;
  metrics.distanceTravelled = min(truckPosition, p.slopeLength);
  metrics.time = t;
  metrics.datapoints = iteration-1;
end
