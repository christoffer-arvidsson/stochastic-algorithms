function alpha = GetSlopeAngle(x, iSlope, iDataSet)
  if (iDataSet == 1)                                
    if (iSlope == 1) 
      alpha = 5 - 2*sin(x/100) - cos(sqrt(7)*x/500 - 10);   
    elseif (iSlope == 2)
      alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);    
    elseif (iSlope == 3)
      alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);  
    elseif (iSlope == 4)
      alpha = 3.6 + 1.1*sin(x/250) + cos(sqrt(8)*x/113);  
    elseif (iSlope == 5)
      alpha = 6 + (x/1000) - sqrt(2) * sin(x/70) + cos(sqrt(2)*x/100); 
    elseif (iSlope == 6) 
      alpha = 5 + sqrt(2)*sin(x/730) - 2*cos(sqrt(2)*x/500);    
    elseif (iSlope == 7) 
      alpha = 5 + 2*sin(x/100) + cos(sqrt(2)*x/50);    
    elseif (iSlope == 8) 
      alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); 
    elseif (iSlope == 9) 
      alpha = 4 + 2.65*sin(x/100) + cos(sqrt(23)*x/800);    
    elseif (iSlope== 10)
      alpha = 6 - sqrt(2)*sin(x/430 - 100) + 2*cos(sqrt(2)*x/400);    
    end 
  elseif (iDataSet == 2)                            
    if (iSlope == 1) 
      alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);    
    elseif (iSlope == 2) 
      alpha = 3 + 2*sin(x/50) + cos(sqrt(5)*x/50);    
    elseif (iSlope == 3) 
      alpha = 5 - sqrt(2)*sin(x/730) + 2*cos(sqrt(2)*x/500);    
    elseif (iSlope == 4) 
      alpha = 5.1 + 1.8*sin(x/230) + cos(sqrt(17)*x/333);  
    elseif (iSlope == 5) 
      alpha = 5 - sin(x/20) - 2*cos(x/100 - 100);    
    end
  elseif (iDataSet == 3)                           
    if (iSlope == 1) 
      alpha = 4.6 + 2*sin(x/200) + 1.2*cos(x/100 - 100);
    elseif (iSlope == 2) 
      alpha = 6 - sin(x/200) - cos(sqrt(7)*x/300);   
    elseif (iSlope == 3) 
      alpha = 4 + sin(x/500) + cos(sqrt(19)*x/500);    
    elseif (iSlope == 4) 
      alpha = 3 + sin(x/100) + cos(sqrt(2)*x/100);  
    elseif (iSlope == 5) 
      alpha = 5 + sin(x/50) + cos(sqrt(5)*x/222);    
    end 
  end

end
