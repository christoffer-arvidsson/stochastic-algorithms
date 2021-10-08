function newPosition = UpdatePosition(currentPosition, currentVelocity, slopeAngle, deltaT)
  distanceDownhill = currentVelocity * deltaT;
  distanceHorizontal = distanceDownhill * cosd(slopeAngle);
  newPosition = currentPosition + distanceHorizontal;
end
