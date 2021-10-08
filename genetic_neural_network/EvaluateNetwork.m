function fitness = EvaluateNetwork(wIH, wHO, parameters, datasetIndex, datasetSize)
  fitnesses = zeros(datasetSize);
  for slopeIndex = 1:datasetSize
    metrics = RunTruckModel(wIH, wHO, parameters, slopeIndex, datasetIndex);
    fitnesses(slopeIndex) = FitnessMeasure(metrics.averageSpeed, metrics.distanceTravelled);
  end

  fitness = mean(fitnesses, 'all');
end

function fitness = FitnessMeasure(averageSpeed, distanceTravelled)
  fitness = averageSpeed * distanceTravelled;
end
