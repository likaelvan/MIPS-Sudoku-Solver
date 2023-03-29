# A MIPS assembly program that solves a Sudoku board. 
The input is a board with empty cells and the output is the solution for the board. The project will implement two variants: 
a 4x4 and 9x9 Sudoku solver. For both Sudoku variants, input will consist of lines of  integers corresponding to a row in the Sudoku board. 
Cells that are empty will be represented by 0. 

## 4x4 Sudoku Solver
For the 4x4 solver, there will always be four input lines consisting of four integers 
for each line. For example, a valid input will look like the following:
```
2100
0320
0004
1000
```
The solution for this board must look like the following:
```
2143
4321
3214
1432
```

## 9x9 Sudoku Solver
For the 9x9 solver, there will always be nine input lines consisting of nine integers for each line. 
For example, a valid input will look like the following:
```
000260701
680070090
190004500
820100040
004602900
050003028
009300074
040050036
703018000
```
The solution for this board must look like the following:
```
435269781
682571493
197834562
826195347
374682915
951743628
519326874
248957136
763418259
```

