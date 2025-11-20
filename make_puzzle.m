function P = make_puzzle(fullGrid, blanks)
% MAKE_PUZZLE  Removes the requested number of clues from the full grid.

if nargin < 2
    blanks = 40;
end

blanks = max(0,min(81,round(blanks)));
P = fullGrid;

if blanks == 0
    return;
end

%It treats the 9x9 grid as a single list of 81 numbers.
%randperm(81, blanks) picks blanks unique numbers between 1 and 81 randomly.
indices = randperm(81, blanks);
P(indices) = 0;
end


