function distance = HammingDistance(chromosome1, chromosome2)
  length1 = length(chromosome1);
  length2 = length(chromosome2);
  lengthDifference = abs(length1 - length2);
  minimumLength = min(length1, length2);
  distance = sum(chromosome1(1:minimumLength) ~= chromosome2(1:minimumLength));
  distance = distance + lengthDifference;
  distance = distance / max(length1, length2);
end
