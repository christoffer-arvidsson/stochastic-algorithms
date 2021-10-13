function PlotFitness(trainingFitnesses, validationFitnesses)
  clf
  x = 1:length(trainingFitnesses);
  plot(x,trainingFitnesses);
  hold on
  plot(x,validationFitnesses);
  legend("Training fitness", "Validation Fitness")
  title("Fitness during training")
  xlabel("Generation")
  ylabel("Fitness")
end
