function [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2)
  points1 = sort(randsample(1:4:length(chromosome1)-1, 2));
  points2 = sort(randsample(1:4:length(chromosome2)-1, 2));

  part11 = chromosome1(1:points1(1));
  part12 = chromosome1(points1(1)+1:points1(2));
  part13 = chromosome1(points1(2)+1:end);
  part21 = chromosome2(1:points2(1));
  part22 = chromosome2(points2(1)+1:points2(2));
  part23 = chromosome2(points2(2)+1:end);

  newChromosome1 = [part11 part22 part13];
  newChromosome2 = [part21 part12 part23];
end
