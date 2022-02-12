int : N;
array[1..N,1..N] of  int : input_grid;
array[1..N,1..N] of var int : output_grid;
array[int] of int : NUMS = [input_grid[j,k]| j in 1..N, k in 1..N where input_grid[j,k]!=0];
array[int] of int : TWO_R = [input_grid[j,k]| j in 1..N, k in 1..N where  input_grid[j,k]!=0 /\ input_grid[j,k]!=1 ];
array[int] of int: ZERO_TWO_R = [0] ++ TWO_R;
array[int] of int: ZERO_NUMS = [0] ++ NUMS;

constraint assert(N>=5, "Number of N too little");
constraint assert(N<=20, "Number of N too big");
constraint forall(i in NUMS)(assert(i<=9, "Number bigger than 9"));

constraint forall(i in 1..N, j in 1..N)(
                 if (input_grid[i,j] != 0) then output_grid[i,j] = input_grid[i,j] else true endif
           );
constraint forall(i in NUMS)(
                 sum(j in 1..N, k in 1..N where output_grid[j,k] == i)(output_grid[j,k]) == i*i
           );
constraint forall(i in NUMS, j in 1..N, k in 1..N where output_grid[j,k] == i)(
                 if j==1 then true else (output_grid[j-1,k] == 0 \/ output_grid[j-1,k] == i) endif
                 /\
                 if j==N then true else (output_grid[j+1,k] == 0 \/ output_grid[j+1,k] == i) endif 
                 /\
                 if k==1 then true else (output_grid[j,k-1] == 0 \/ output_grid[j,k-1] == i) endif
                 /\
                 if k==N then true else (output_grid[j,k+1] == 0 \/ output_grid[j,k+1] == i) endif 
        );           
%if i in index_set per far check su index out of bounds
%constraint acqua consecutiva \ constraint isole blocchi consecutivi
constraint forall(i in ZERO_TWO_R, j in 1..N, k in 1..N where output_grid[j,k] == i)(
                    output_grid[j-1,k] == i \/ output_grid[j+1,k] == i \/ output_grid[j,k-1] == i \/ output_grid[j,k+1] == i
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
%constraint forall(i in ZERO_TWO_R, j in 2..N-1 where output_grid[j,1] == i)(
%                 output_grid[j-1,1] == i \/ output_grid[j+1,1] == i \/ output_grid[j,2] == i
%           );
%constraint forall(i in ZERO_TWO_R, j in 2..N-1 where output_grid[j,N] == i)(
%                 output_grid[j-1,N] == i \/ output_grid[j+1,N] == i \/ output_grid[j,N-1] == i 
 %         );
%constraint forall(i in ZERO_TWO_R, k in 2..N-1 where output_grid[1,k] == i)(
%                 output_grid[1, k-1] == i \/ output_grid[1, k+1] == i \/ output_grid[2,k] == i
%           );
%constraint forall(i in ZERO_TWO_R, k in 2..N-1 where output_grid[N,k] == i)(
%                 output_grid[N, k-1] == i \/ output_grid[N, k+1] == i \/ output_grid[N-1,k] == i 
%           );
%constraint forall(i in ZERO_TWO_R) (if output_grid[1,1] == i then output_grid[1,2]==i \/ output_grid[2,1]==i else true endif);
%constraint forall(i in ZERO_TWO_R) (if output_grid[1,N] == 0 then output_grid[1,N-1]==0 \/ output_grid[2,N]==0 else true endif);
%constraint forall(i in ZERO_TWO_R) (if output_grid[N,1] == 0 then output_grid[N-1,1]==0 \/ output_grid[N,2]==0 else true endif);
%constraint forall(i in ZERO_TWO_R) (if output_grid[N,N] == 0 then output_grid[N-1,N]==0 \/ output_grid[N,N-1]==0 else true endif);


 % scorro righe colonne, se becco due 2 di fila allora guardo la riga sotto e constraint che ci devono essere o uno 0 o zero 0. Scorro solo fino alla penultima riga 
constraint forall(j in 1..N-1, k in 1..N-1)(
                 if(output_grid[j,k] == 0 /\ output_grid[j,k+1] == 0) then output_grid[j+1,k]+output_grid[j+1,k+1] != 0 else true endif
           );
constraint forall(j in 1..N, k in 1..N)(
                 exists(d in ZERO_NUMS)(output_grid[j,k]==d)
           );
solve satisfy;

output [ format(output_grid[i,j]) ++ if j == N then "\n" else " " endif| i,j in 1..N ] ++ ["\n"];

