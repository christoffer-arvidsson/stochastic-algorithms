function error = RootMeanSquaredError(yTrue, yEstimate)
  error = sqrt(mean((yEstimate - yTrue).^2));
end
