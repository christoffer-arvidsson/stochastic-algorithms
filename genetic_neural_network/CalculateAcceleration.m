function acceleration = CalculateAcceleration(brakePressure, gearLevel, gearConstant, mass, alpha, gravityConstant, brakeTemperature, maxTemperature)
  gravityForce = CalculateGravityForce(mass, gravityConstant, alpha);
  foundationBrakeForce = CalculateFoundationBrakeForce(mass, gravityConstant, brakeTemperature, ...
                                                       maxTemperature, brakePressure);

  engineBreakForce = CalculateEngineBreakForce(gearLevel, gearConstant);

  acceleration = (gravityForce - foundationBrakeForce - engineBreakForce) / mass;
end

function gravityForce = CalculateGravityForce(mass, gravityConstant, alpha)
  gravityForce = (mass * gravityConstant) * sind(alpha);
end

function foundationBrakeForce = CalculateFoundationBrakeForce(mass, gravityConstant, brakeTemperature, ...
                                                              maxTemperature,  brakePressure)
  foundationBrakeForce = ((mass * gravityConstant)/20) * brakePressure;
  if brakeTemperature >= maxTemperature - 100
    exponent = -1 * (brakeTemperature - (maxTemperature - 100)) / 100;
    foundationBrakeForce = foundationBrakeForce * exp(exponent);
  end
end

function engineBreakForce = CalculateEngineBreakForce(gearLevel, gearConstant)
  gearTable = [7.0 5.0 4.0 3.0 2.5 2.0 1.6 1.4 1.2 1.0];
  engineBreakForce = gearTable(gearLevel) * gearConstant;
end

