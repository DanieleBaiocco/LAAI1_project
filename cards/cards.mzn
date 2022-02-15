
% inputs
int: n_cards;
int: n_red;
int: n_black = n_cards - n_red;
int: left_split;
int: right_split = n_cards - left_split;

% variables
var 0..n_red: n_red_left_split;
var 0..n_black: n_black_left_split;
var 0..n_red: n_red_right_split;
var 0..n_black: n_black_right_split;

constraint assert(n_cards > n_red, "Number of red cards is greater than number of total cards");
constraint assert(n_cards > left_split, "Number of cards in first split is greater than number of total cards");
constraint assert(n_cards > 0, "There are no cards in the deck or the number is negative");
constraint assert(left_split >= 0, "The split is negative" );
constraint assert(n_red >= 0, "The number of red cards is negative" );

% it ensures the number of black cards in the second split is equal to the total number of black cards minus the number of black cards in the first split
constraint n_black_right_split = n_black - n_black_left_split;

% it ensures the number of red cards in the second split is equal to the total number of red cards minus the number of red cards in the first split
constraint n_red_right_split = n_red - n_red_left_split;

% it says that the number of cards in the first split is equal to sum of the number of black cards and red cards in the first split
constraint left_split = n_red_left_split + n_black_left_split;

% it says that the number of cards in the second split is equal to sum of the number of black cards and red cards in the second split
constraint right_split = n_red_right_split + n_black_right_split;
solve satisfy;

output ["The card deck contains " ++ format(n_red_left_split) ++ " red cards and "++ format(n_black_left_split) ++" black cards in the first splitted deck. "  ++ "\n" ++
        "It contains " ++ format(n_red_right_split) ++ " red cards and "++ format(n_black_right_split) ++" black cards in the second one. "]