include "alldifferent.mzn";

% number of digits 
int: num_digits;
int: multiplier;

int: lower_bound = 10^(num_digits - 1);
int: upper_bound = 10^(num_digits) - 1;

% the result to return with domain in range lower_bound - upper_bound
var lower_bound..upper_bound : result;

list of int: powers = [ 10^i | i in 0..num_digits-1];

% list of each single digit inside the result variable
list of var int: digits = [ (result div n) mod 10 | n in powers ];

constraint assert(num_digits >= 2 , "The number of digits is too small");
constraint assert(multiplier >=2 , "The multiplier is too small");

% it ensures each digit is even
constraint forall (digit in digits) (digit mod 2 == 0);

% it ensures each digit is different from the others
constraint alldifferent(digits);

% it ensure the number to return is a multiple of the multiplier
constraint result mod multiplier == 0;

% it gives the smallest number that satisfies all the constraints
solve minimize result;

output ["The smallest number is ", format(result)];