function PlotMinima()
  figure(10)
  xValues = [3 3.58 -2.8 -3.78];
  yValues = [2 -1.85 3.13 -3.28];

  xRange = linspace(-10, 10, 100);
  yRange = linspace(-10, 10, 100);
  [X,Y] = meshgrid(xRange, yRange);
  Z = log(0.001 + (X.^2 + Y - 11).^2 + (X + Y.^2 - 7).^2);
  contour(X,Y,Z);
  xlim([-8, 8])
  xlabel('$x_1$', 'Interpreter', 'latex')
  ylim([-8, 8])
  ylabel('$x_2$', 'Interpreter', 'latex')
  title('Found minima')
  hold on
  scatter(xValues, yValues, 'filled', 'red')
  colorbar
  saveas(gcf, 'minima.png')
end
