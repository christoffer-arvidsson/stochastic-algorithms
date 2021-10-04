function p = PlotPSO(xMin, xMax, positions, bestSwarmPosition)
    xRange = linspace(-5, 5);
    yRange = linspace(-5, 5);
    [X,Y] = meshgrid(xRange, yRange);
    Z = log(0.001 + (X.^2 + Y - 11).^2 + (X + Y.^2 - 7).^2);
    contour(X,Y,Z);
    xlim([xMin, xMax])
    ylim([xMin, xMax])
    hold on
    scatter(positions(:,1), positions(:,2), 'filled')
    scatter(bestSwarmPosition(1), bestSwarmPosition(2), 'filled')
end

