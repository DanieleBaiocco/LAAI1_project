
int : born_year;
int: len_born_year;
int: fraction;

array[int] of int: powers = [ 10^i | i in 0..len_born_year-1];
var int : target_year;

constraint assert(fraction > 0, "The input value fraction cannot be 0 or less than 0");

% this array contains each single digit that composes the target year to find
array[int] of var int: digits = [ (target_year div n) mod 10 | n in powers ];

% it ensures that the sum of each digit in the target year is equal to the difference between the born year and the target year divided by an input value "fraction"
constraint sum(digits) == (target_year - born_year) div fraction;

% it ensures that the target year is greater than the born year
constraint target_year > born_year;

% it ensures that the division with the input value "fraction" has rest 0 
constraint (target_year - born_year) mod fraction == 0;

solve satisfy;

output["The target year is "++format(target_year)];