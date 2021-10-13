function newGearLevel = UpdateGearLevel(currentGearLevel, desiredGearChange, minGearLevel,...
                                        maxGearLevel)
  if desiredGearChange > 0.7
    newGearLevel = min(currentGearLevel + 1, maxGearLevel);
  elseif desiredGearChange < 0.3
    newGearLevel = max(currentGearLevel - 1, minGearLevel);
  else
    newGearLevel = currentGearLevel;
  end
end
