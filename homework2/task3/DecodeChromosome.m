function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax)
    chromosomeLength = length(chromosome);

    wIH = reshape(chromosome(1:(nIn+1)*nHidden), nHidden+1, nIn)'
    wHO = reshape(chromosome((nIn+1)*nHidden+1:end), nHidden+1, nOut)'
end
