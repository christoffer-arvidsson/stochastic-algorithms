function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax)
  chromosomeLength = length(chromosome);
  chromosome = chromosome ./ (wMax * 2) + wMax;

  wIH = reshape(chromosome(1:(nIn+1)*nHidden), nIn+1, nHidden)';
  wHO = reshape(chromosome((nIn+1)*nHidden+1:end), nHidden+1, nOut)';
end
