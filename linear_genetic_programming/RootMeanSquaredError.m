function error = RootMeanSquaredError(trueValues, estimatedValues)
  error = sqrt(mean((estimatedValues - estimatedValues).^2));
end
