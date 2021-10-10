function r = ProtectedDivision(x, y)
  cMax = 100000;
  if y == 0
    r =  cMax;
  else
    r = x / y;
end
  
