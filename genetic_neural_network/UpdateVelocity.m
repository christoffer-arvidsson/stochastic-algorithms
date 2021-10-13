function newVelocity = UpdateVelocity(currentVelocity, acceleration, deltaT)
  newVelocity = (acceleration * deltaT) + currentVelocity;
end
