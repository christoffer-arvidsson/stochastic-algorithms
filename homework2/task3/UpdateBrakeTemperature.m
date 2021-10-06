function newBrakeTemperature = UpdateBrakeTemperature(currentBrakeTemperature, BrakePressure, ...
                                                      tau, Ch, ambientTemperature)
  deltaBrakeTemperature = CalculateDeltaBrakeTemperature(currentBrakeTemperature, BrakePressure, ...
                                                         tau, Ch);
  newBrakeTemperature = max(ambientTemperature, ambientTemperature + deltaBrakeTemperature);
end

function deltaBrakeTemperature = CalculateDeltaBrakeTemperature(currentBrakeTemperature, BrakePressure, ...
                                                                tau, Ch)
  if BrakePressure < 0.01
    deltaBrakeTemperature = -1 * (currentBrakeTemperature / tau);
  else
    deltaBrakeTemperature = Ch * BrakePressure;
  end
end

