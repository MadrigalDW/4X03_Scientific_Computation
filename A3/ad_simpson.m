function [r, level, funs ] = ad_simpson( f, a, b, eps, level, level_max, funs )
     global xpoints
     level = level+1;
     h = b-a;
     c = (a+b)/2;
     
     ab = feval(f,a) + feval(f,b);
     cc = feval(f, c);

     one = h*( ab + 4*cc  )/6;

     d = (a+c)/2;
     e = (c+b)/2;
     
     xpoints = unique([xpoints, a, b, c, d, e]);
     two = h*( ab + 4*feval(f,d) + 2*cc + 4*feval(f,e)  )/12;

     
     funs = funs+5;

     if level >= level_max 
           r = two;
           disp('max level reached');
     else 
	   if abs(two-one) < 15*eps 
               r = two + (two-one)/15;
           else
              [left,  level, funs] = ad_simpson( f, a, c, eps/2, level, level_max, funs );
              [right, level, funs] = ad_simpson( f, c, b, eps/2, level, level_max, funs );           
              r = left + right;
           end
     end
