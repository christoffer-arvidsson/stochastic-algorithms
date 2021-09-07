function decodedChromosome = DecodeChromosome(chromosome, variableRange)
  nGenes = size(chromosome, 2);
  nHalf = fix(nGenes/2);
  decodedChromosome(1) = SumChromosome(chromosome(1:nHalf), variableRange, nHalf);
  decodedChromosome(2) = SumChromosome(chromosome(nHalf, nGenes), variableRange, nHalf);
end

function sum = SumChromosome(chromosome, variableRange, nHalf)
  sum = 0.0;
  indices = 1:nHalf;
  sum = sum .+ chromosome .* 2.^(-indices)
  sum = -1 .* variableRange + variableRange(sum(1) / (1-2^(-nHalf)))
end
