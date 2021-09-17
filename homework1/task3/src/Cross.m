function newIndividuals = Cross(individual1, individual2)
  nGenes = size(individual1, 2);
  crossoverPoint = 1 + fix(rand*(nGenes));
  mask = 1:nGenes < crossoverPoint;

  newIndividuals = zeros(2,nGenes);
  newIndividuals(1, mask) = individual1(mask);
  newIndividuals(1, ~mask) = individual2(~mask);
  newIndividuals(2, mask) = individual2(mask);
  newIndividuals(2, ~mask) = individual1(~mask);
end
