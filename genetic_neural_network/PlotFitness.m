function PlotFitness(trainingFitnesses, validationFitnesses)
  x = 1:size(trainingFitnesses,1);
  plot(x,trainingFitnesses);
  hold on
  plot(x,validationFitnesses);
  legend('Training fitness', "Validation Fitness")
  title('Fitness during training')
  xlabel('Generation')
  ylabel('Fitness')
end
