int : N;
array[1..N,1..N] of  int : input_grid;
array[1..N,1..N] of var int : output_grid;

array[int] of int: range_zero_r_wo_one = [0] ++ [input_grid[j,k]| j in 1..N, k in 1..N where  input_grid[j,k]!=0 /\ input_grid[j,k]!=1 ];

array[int] of int : range_one_r = [input_grid[j,k]| j in 1..N, k in 1..N where input_grid[j,k]!=0];
array[int] of int: range_zero_r = [0] ++ range_one_r;

% simple checks on input data
constraint assert(N>=5, "Number of N too little");
constraint assert(N<=20, "Number of N too big");
constraint forall(i in range_one_r)(assert(i<=9, "Number bigger than 9"));

% initialization of the output_grid with zeros in the same positions of the input_grid
constraint forall(i in 1..N, j in 1..N)(
                 if (input_grid[i,j] != 0) then output_grid[i,j] = input_grid[i,j] else true endif
           );
           
% to ensure that the number of cells in each island is equal to the value of the clue
constraint forall(i in range_one_r)(
                 sum(j in 1..N, k in 1..N where output_grid[j,k] == i)(output_grid[j,k]) == i*i
           );
           
% to ensure that all islands are isolated from each other horizontally and vertically
constraint forall(i in range_one_r, j in 1..N, k in 1..N where output_grid[j,k] == i)(
                 if j==1 then true else (output_grid[j-1,k] == 0 \/ output_grid[j-1,k] == i) endif
                 /\
                 if j==N then true else (output_grid[j+1,k] == 0 \/ output_grid[j+1,k] == i) endif 
                 /\
                 if k==1 then true else (output_grid[j,k-1] == 0 \/ output_grid[j,k-1] == i) endif
                 /\
                 if k==N then true else (output_grid[j,k+1] == 0 \/ output_grid[j,k+1] == i) endif 
        ); 
                  
% to ensure that cells of each island and of the sea form a continuous shape
constraint forall(i in range_zero_r_wo_one, j in 1..N, k in 1..N where output_grid[j,k] == i)(
                    (output_grid[j-1,k] == i \/ output_grid[j+1,k] == i \/ output_grid[j,k-1] == i \/ output_grid[j,k+1] == i)
                    /\
                    if (output_grid[j-1,k] == i /\ output_grid[j+1,k] != i /\ output_grid[j,k-1] != i /\ output_grid[j,k+1] != i)
                    then (output_grid[j-2,k] == i \/ output_grid[j-1,k-1] == i \/ output_grid[j-1,k+1] == i) else true endif
                    /\
                    if (output_grid[j+1,k] == i /\ output_grid[j-1,k] != i /\ output_grid[j,k-1] != i /\ output_grid[j,k+1] != i) 
                    then (output_grid[j+2,k] == i \/ output_grid[j+1,k-1] == i \/ output_grid[j+1,k+1] == i) else true endif
                    /\
                    if (output_grid[j,k-1] == i /\ output_grid[j+1,k] != i /\ output_grid[j-1,k] != i /\ output_grid[j,k+1] != i)
                    then (output_grid[j,k-2] == i \/ output_grid[j-1,k-1] == i \/ output_grid[j+1,k-1] == i) else true endif 
                    /\
                    if (output_grid[j,k+1] == i /\ output_grid[j,k-1] != i /\ output_grid[j+1,k] != i /\ output_grid[j-1,k] != i) 
                    then (output_grid[j,k+2] == i \/ output_grid[j-1,k+1] == i \/ output_grid[j+1,k+1] == i) else true endif
           );


% to ensure that there are no water areas of 2x2 or larger
constraint forall(j in 1..N-1, k in 1..N-1)(
                 if(output_grid[j,k] == 0 /\ output_grid[j,k+1] == 0) then output_grid[j+1,k]+output_grid[j+1,k+1] != 0 else true endif
           );
          
% to ensure that each cell gets instantiated only with a digit from the input_grid
constraint forall(j in 1..N, k in 1..N)(
                 exists(d in range_zero_r)(output_grid[j,k]==d)
           );
solve satisfy;

output [ format(output_grid[i,j]) ++ if j == N then "\n" else " " endif| i,j in 1..N ] ++ ["\n"];
