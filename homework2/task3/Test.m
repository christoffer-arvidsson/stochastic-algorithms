function [wIH, wHO] = Test()
    % [wIH, wHO] = DecodeChromosome([1 1 4 2 2 4 3 3 4 4 4 4], 2, 2, 2, 100)

    wIH = [2 1 -3 1; 5 -2 1 4; 3 0 1 2]
    wHO = [1 0 -4 3; 4 -2 0 1]
    nIn = size(wIH,2)-1;
    nHidden = size(wIH,1); % must be equal to size(wHO,2)-1, for a valid set of matrices for an FFNN
    nOut = size(wHO,1);

    EncodeNetwork(wIH, wHO, 1)
end