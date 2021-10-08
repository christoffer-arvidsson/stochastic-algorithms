function newVelocity = UpdateVelocity(currentVelocity, acceleration, deltaT)
  newVelocity = max(0, (acceleration * deltaT) + currentVelocity);
end
