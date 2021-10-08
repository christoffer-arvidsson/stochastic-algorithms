function result = RunUnitTests();
    % assert(DecodeChromosome([0 0 0 0 0 0 0 0], 2, 3), [-3 -3])
    % assert(DecodeChromosome([1 1 1 1 1 1 1 1], 2, 3), [3 3])

    % assert(abs(EvaluateIndividual([3,3]) - 1/7245.7) < 1e-5)

    individual1 = [0 0 0 0 0 0 0 0 0]
    individual2 = [1 1 1 1 1 1 1 1 1]
    % newIndividual = Cross(individual1, individual2)

    ## mutated = Mutate(individual1, 0.0)


    result = true;
end
