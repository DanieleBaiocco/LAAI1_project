include "alldifferent.mzn";

array[1..9] of 0..9 : starting_conf;
array[1..9] of var 1..9 : result;

constraint assert(length(starting_conf) == 9, "Wrong number of elements in input array");

% it puts in the result array the digits from 1 to 9 that are in the starting_config array
constraint forall(i in 1..9)(
     if starting_conf[i] > 0 then result[i] = starting_conf[i] else true endif
     ); 

% it ensures that the sum of the elements in the first side of the triangle is 20     
constraint result[1] + result[2] + result[3] + result[4] = 20;

% it ensures that the sum of the elements in the second side of the triangle is 20   
constraint result[4] + result[5] + result[6] + result[7] = 20;

% it ensures that the sum of the elements in the third side of the triangle is 20   
constraint result[7] + result[8] + result[9] + result[1] = 20;

% it ensures that each item in the array is a different digit
constraint alldifferent(result);
 
solve satisfy;

output["First side: " ++ format(result[1]) ++ ", " ++ format(result[2]) ++ ", " ++ format(result[3]) ++ ", " ++ format(result[4]) ++ "\n" ++ 
       "Second side: " ++ format(result[4]) ++ ", " ++ format(result[5]) ++ ", " ++ format(result[6]) ++ ", " ++ format(result[7]) ++ "\n" ++ 
       "Third side: " ++ format(result[7]) ++ ", " ++ format(result[8]) ++ ", " ++ format(result[9]) ++ ", " ++ format(result[1]) ++ "\n" ]