function parameters = Parameters()
  % Simulation parameters
  parameters = struct;
  parameters.maxVelocity = 25;
  parameters.minVelocity = 1;
  parameters.maxSlopeAngle = 10;
  parameters.maxTemperature = 700;

  parameters.startAcceleration = 0;
  parameters.startVelocity = 20;
  parameters.startPosition = 0;
  parameters.startGearLevel = 7;
  parameters.startBrakeTemperature = 500;

  parameters.slopeLength = 1000;
  parameters.deltaT = 0.25;
  parameters.maxT = 100; % Only for the test program later
  parameters.tau = 1;
  parameters.Ch = 40;
  parameters.gearConstant = 3000;
  parameters.mass = 20000;
  parameters.ambientTemperature = 283;
  parameters.gravityConstant = 9.81;
  parameters.timeBetweenGearChange = 2;
  parameters.minGearLevel = 1;
  parameters.maxGearLevel = 10;
  parameters.activationConstant = 2;
end
