
include "alldifferent.mzn";

array[1..9] of var 1..9 : result;

% it ensures all the elements in the array are unique digits
constraint alldifferent(result);

var int: first_side = result[1] + result[2] + result[3] + result[4];
var int: second_side = result[4] + result[5] + result[6] + result[7];
var int:  third_side = result[7] + result[8] + result[9] + result[1];
 
% it maximizes the sum of the values of each side of the triangle
solve maximize first_side + second_side + third_side;
 
output["The maximum sum is "++ format(first_side + second_side + third_side)++ "and it is achieved" ++ "\n" ++
 "through this configuration: ", format(result)]