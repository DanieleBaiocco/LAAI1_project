 % Use this editor as a MiniZinc scratch book
 include "alldifferent.mzn";

 set of int: ProblemRange = 1..9;
 array[ProblemRange] of var 1..9 : result;

 constraint alldifferent(result);

 var int: first_side = result[1] + result[2] + result[3] + result[4];
 var int: second_side = result[4] + result[5] + result[6] + result[7];
 var int:  third_side = result[7] + result[8] + result[9] + result[1];
 
 solve maximize first_side + second_side + third_side;
 
 output[format(first_side + second_side + third_side), format(result)]