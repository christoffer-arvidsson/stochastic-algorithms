function PlotFit(chromosome)
  data = LoadFunctionData;
  xValues = data(:,1);
  yTrue = data(:,2);
  yEstimate = PerformFit(xValues, chromosome)

  plot(xValues, yTrue);
  hold on
  plot(xValues, yEstimate);
  title('Function fit');
  xlabel('$x$', 'Interpreter', 'latex');
  ylabel('$g(x)$', 'Interpreter', 'latex');
