function metrics = RunTruckModel(wIH, wHO, parameters, slopeIndex, datasetIndex)

  % Simulation
  p = parameters;

  metrics = struct;
  if p.testRun == true;
    numberOfDatapoints = p.maxT / p.deltaT;
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

  timeSinceGearChange = p.timeBetweenGearChange;
  t = 0;
  while truckPosition < p.slopeLength
    % Update time
    t = t + p.deltaT;
    timeSinceGearChange = timeSinceGearChange + p.deltaT;

    % Compute state
    slopeAngle = GetSlopeAngle(truckPosition, slopeIndex, datasetIndex);
    brakeTemperature = UpdateBrakeTemperature(brakeTemperature, ...
                                              brakePressure, p.tau, p.Ch, ...
                                              p.ambientTemperature);
    state = [(truckVelocity/p.maxVelocity) (slopeAngle/p.maxSlopeAngle) (brakeTemperature/p.maxTemperature)];

    % Take action
    [brakePressure, desiredGearChange] = FeedForward(state, wIH, wHO, p.activationConstant);
    if timeSinceGearChange >= p.timeBetweenGearChange
      newGearLevel = UpdateGearLevel(gearLevel, desiredGearChange, p.minGearLevel, p.maxGearLevel);
      if newGearLevel ~= gearLevel
        timeSinceGearChange = 0;
        gearLevel = newGearLevel;
      end
    end

    % Update state
    truckAcceleration = CalculateAcceleration(brakePressure, gearLevel, ...
                                              p.gearConstant, p.mass, slopeAngle, ...
                                              p.gravityConstant, brakeTemperature, ...
                                              p.maxTemperature);
    truckVelocity = UpdateVelocity(truckVelocity, truckAcceleration, p.deltaT); 
    truckPosition = UpdatePosition(truckPosition, truckVelocity, slopeAngle, p.deltaT);

    if p.testRun == true
      iteration = t / p.deltaT;
      metrics.position(iteration) = truckPosition;
      metrics.velocity(iteration) = truckVelocity;
      metrics.acceleration(iteration) = truckAcceleration;
      metrics.slopeAngle(iteration) = slopeAngle;
      metrics.brakePressure(iteration) = brakePressure;
      metrics.gearLevel(iteration) = gearLevel;
      metrics.brakeTemperature(iteration) = brakeTemperature;
    end


    % Violation check
    if (truckVelocity > p.maxVelocity) | (truckVelocity < p.minVelocity) | (brakeTemperature > p.maxTemperature)
      break
    end
  end

  % Collect metrics
  metrics.averageSpeed = truckPosition / t;
  metrics.distanceTravelled = truckPosition;
  metrics.time = t;
end

function newGearLevel = UpdateGearLevel(currentGearLevel,...
                                        desiredGearChange, minGearLevel,...
                                        maxGearLevel)
  if desiredGearChange > 0.7
    newGearLevel = min(currentGearLevel + 1, maxGearLevel);
  elseif desiredGearChange < 0.3
    newGearLevel = max(currentGearLevel - 1, minGearLevel);
  else
    newGearLevel = currentGearLevel;
  end
end
