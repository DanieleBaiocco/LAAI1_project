% Use this editor as a MiniZinc scratch book
include "alldifferent.mzn";

set of int: ProblemRange = 1..9;
array[ProblemRange] of 0..9 : starting_conf;
array[ProblemRange] of var 1..9 : result;

constraint forall(i in ProblemRange)(
     if starting_conf[i] > 0 then result[i] = starting_conf[i] else true endif
     ); 
 constraint result[1] + result[2] + result[3] + result[4] = 20;
 constraint result[4] + result[5] + result[6] + result[7] = 20;
 constraint result[7] + result[8] + result[9] + result[1] = 20;
 constraint alldifferent(result);
 
 solve satisfy;