function population = InitializePopulation(populationSize, nInputs, ...
                                           nHidden, nOutputs, wMax)
  chromosomeLength = nHidden * (nInputs+1) + nOutputs * (nHidden+1);

  population = zeros(populationSize, chromosomeLength);
  for i = 1:populationSize
    [wIH, wHO] = InitializeWeights(nInputs, nHidden, nOutputs, wMax);
    population(i, :) = EncodeNetwork(wIH, wHO, wMax);
  end
end

function [wIH, wHO] = InitializeWeights(nInputs, nHidden, nOutputs, wMax)
  wIH = normrnd(0,1/sqrt(nHidden),nHidden, nInputs+1);
  wHO = normrnd(0,1/sqrt(nOutputs),nOutputs, nHidden+1);
end
