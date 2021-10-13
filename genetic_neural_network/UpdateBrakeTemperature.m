function newBrakeTemperature = UpdateBrakeTemperature(currentBrakeTemperature, BrakePressure, ...
                                                      tau, Ch, ...
                                                      ambientTemperature, ...
                                                      deltaT)
  currentDeltaBrakeTemperature = currentBrakeTemperature - ambientTemperature;
  deltaBrakeTemperatureChange = CalculateDeltaBrakeTemperatureChange(currentDeltaBrakeTemperature, ...
                                                                     BrakePressure, tau, Ch);
  
  deltaBrakeTemperature = currentDeltaBrakeTemperature + deltaBrakeTemperatureChange * deltaT;
  newBrakeTemperature = max(ambientTemperature, ambientTemperature + deltaBrakeTemperature);
end

function deltaBrakeTemperatureChange = CalculateDeltaBrakeTemperatureChange(currentDeltaBrakeTemperature, ...
                                                                            BrakePressure, tau, Ch)
  if BrakePressure < 0.01
    deltaBrakeTemperatureChange = -(currentDeltaBrakeTemperature / tau);
  else
    deltaBrakeTemperatureChange = Ch * BrakePressure;
  end
end

