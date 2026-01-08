function P = make_puzzle(fullGrid, blanks)
% MAKE_PUZZLE  removes the requested number of clues from the full grid.

if nargin < 2
    blanks = 40;
end

blanks = max(0,min(81,round(blanks)));
P = fullGrid;
if blanks == 0
    return;
end

% pick blanks unique numbers between 1 and 81 randomly.
indices = randperm(81, blanks);
P(indices) = 0;
end