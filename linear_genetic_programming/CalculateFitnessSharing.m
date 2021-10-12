function factors = CalculateFitnessSharing(population, minDistance, sharingStrength)

  populationSize = length(population);
  factors = zeros(populationSize, 1);
  for iChromosome = 1:populationSize
    factors(iChromosome) = 1;
    for jChromosome = 1:populationSize
      distance = HammingDistance(population(iChromosome).genes, population(jChromosome).genes);

      if distance < minDistance
        factors(iChromosome) = factors(iChromosome) + (1 - distance/sharingStrength);
      end
    end
  end
  factors = 1 ./ factors;
end
  

