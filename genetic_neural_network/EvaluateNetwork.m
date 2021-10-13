function fitness = EvaluateNetwork(wIH, wHO, parameters, datasetIndex, datasetSize)
  fitnessUpperBound = parameters.maxVelocity * parameters.slopeLength;
  fitnesses = zeros(datasetSize,1);
  for slopeIndex = 1:datasetSize
    metrics = RunTruckModel(wIH, wHO, parameters, slopeIndex, datasetIndex);
    fitnesses(slopeIndex) = FitnessMeasure(metrics.averageSpeed, metrics.distanceTravelled, ...
                                           parameters);
  end
  fitness = mean(fitnesses, 'all');
end

function fitness = FitnessMeasure(averageSpeed, distanceTravelled, parameters)
  fractionDistance = distanceTravelled / parameters.slopeLength;
  fractionSpeed = averageSpeed / parameters.maxVelocity;

  if distanceTravelled < parameters.slopeLength
    fitness = 0.8 * fractionDistance;
  else
    fitness = 0.8 + 0.2 * fractionSpeed;
  end
end
