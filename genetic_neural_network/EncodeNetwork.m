function chromosome = EncodeNetwork(wIH, wHO, wMax)
    nOut = size(wHO, 2);
    nHidden = size(wHO, 1);
    nIn = size(wIH, 1) - 1;

    chromosomeLength = numel(wIH) + numel(wHO);

    chromosome = zeros(chromosomeLength, 1);
    chromosome(1:numel(wIH))= reshape(wIH', [], 1);
    chromosome(numel(wIH)+1:end)= reshape(wHO', [], 1);

    chromosome = (chromosome + wMax) ./ (2*wMax);
end
