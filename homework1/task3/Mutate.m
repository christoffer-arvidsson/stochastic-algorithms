## function mutatedIndividual = Mutate(individual, mutationProbability);
##   nGenes = size(individual, 2);
##   mutatedIndividual = individual;
##   for j = 1:nGenes
##     r = rand;
##     if (r < mutationProbability)
##       mutatedIndividual(j) = 1-individual(j);
##     end
##   end
## end

function mutatedIndividual = Mutate(individual, mutationProbability);
  nGenes = size(individual, 2);
  mutationMask = rand(nGenes, 1) < mutationProbability;
  mutatedIndividual = individual;
  mutatedIndividual(mutationMask) = 1 - mutatedIndividual(mutationMask);
end

Mutate([1,1,1,1,1,1,1,1], 0.5)
