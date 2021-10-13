function TestLGPChromosome()
  clf
  
  % Load best chromosome
  BestChromosome
  chromosome = best;

  % Parameters (not stored with the chromosome)
  numVariableRegisters = 4;
  numConstantRegisters = 1;
  numOperators = 5;
  operatorSet = cell(numOperators,1);
  operatorSet{1} = @Addition;
  operatorSet{2} = @Subtraction;
  operatorSet{3} = @Multiplication; 
  operatorSet{4} = @ProtectedDivision;
  constants = [-1];
  chromosomeLengthBeforePenalty = intmax;

  % Data
  functionData = LoadFunctionData;
  xValues = functionData(:,1);
  yTrue = functionData(:,2);

  % Evaluate
  constantRegisters = constants;
  variableRegisters = zeros(numVariableRegisters, 1);
  [error, fitness, yEstimate] = EvaluateChromosome(chromosome', ...
                                                   variableRegisters, ...
                                                   constantRegisters, ...
                                                   operatorSet, ...
                                                   xValues, yTrue,...
                                                   chromosomeLengthBeforePenalty);

  % Result
  fprintf("Estimates:\n")
  fprintf('[');
  fprintf('%g ', yEstimate);
  fprintf(']\n');
  fprintf("Error: %.12f\n", error)

  % Plot
  scatter(xValues, yTrue);
  hold on
  plot(xValues, yEstimate);
  title('Function fit');
  xlabel('$x$', 'Interpreter', 'latex');
  ylabel('$g(x)$', 'Interpreter', 'latex');
  legend('Data', 'Estimate')
end


