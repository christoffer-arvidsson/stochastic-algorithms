function [brakePressure, desiredGearChange] = FeedForward(input, wIH, wHO, c)
  w1 = wIH(:, 1:end-1);
  b1 = wIH(:, end);
  x = Activation(input * w1' + b1', c);

  w2 = wHO(:, 1:end-1);
  b2 = wHO(:, end);
  output = Activation(x * w2' + b2', c);
  brakePressure = output(1);
  desiredGearChange = output(2);
end

function output = Activation(localField, c)
  output = 1 ./ (1 + exp(-c .* localField));
end
