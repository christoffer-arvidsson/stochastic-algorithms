
muValues = [1 10 100 1000 10000];
x1s = [0.433777 0.331354 0.313738 0.311790 0.311593];
x2s = [1.210166 0.995540 0.955252 0.950732 0.950274];
eta = 0.00001;
xStart =  [1 2];
gradientTolerance = 1E-6;

plot(muValues, x1s, '-o', muValues, x2s, '-o');
xlabel('\mu')
ylabel('Value')
legend({'x_1', 'x_2'}, 'Location', 'southwest')
axis([0, inf, 0, 1.3])
set(gca, 'XScale', 'log')
set(gcf, 'PaperUnits', 'inches');
x_width=7.25 ;y_width=4.125
set(gcf, 'PaperPosition', [0 0 x_width y_width]); %
title('Convergence with parameters \eta=0.00001, T=10^{-6}')
saveas(gcf,'../img/1_1.png')
