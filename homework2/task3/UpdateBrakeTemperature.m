function newBrakeTemperature = UpdateBrakeTemperature(currentBreakTemperature, breakPressure, ...
                                                   tau, Ch, ambientTemperature)
    deltaBrakeTemperature = CalculateDeltaBreakTemperature(currentBreakTemperature, breakPressure, ...
                                                           tau, Ch);
     fs
    newBreakTemperature = max(ambientTemperature, ambientTemperature + deltaBrakeTemperature);
end

function deltaBrakeTemperature = CalculateDeltaBreakTemperature(currentBreakTemperature, breakPressure, ...
                                                                tau, Ch)
    if breakPressure < 0.01
        deltaBrakeTemperature = -1 * (currentBreakTemperature / tau);
    else
      deltaBrakeTemperature = Ch * breakPressure;
    end
end