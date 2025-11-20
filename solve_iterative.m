function [sol, ok] = solve_iterative(grid)
% SOLVE_ITERATIVE  Backtracking Sudoku solver.

G = grid;
[rows, cols] = find(G == 0);
empties = [rows cols];
n = size(empties,1);

if n == 0
    sol = G;
    ok = true;
    return;
end

tried = zeros(n,1);
idx = 1;

while idx >= 1 && idx <= n
    r = empties(idx,1);
    c = empties(idx,2);
    placed = false;

    for v = (tried(idx)+1):9
        if can_place(G,r,c,v)
            G(r,c) = v;
            tried(idx) = v;
            idx = idx + 1;
            placed = true;
            break;
        end
    end

    if ~placed
        tried(idx) = 0;
        G(r,c) = 0;
        idx = idx - 1;
    end
end

if idx == n + 1
    sol = G;
    ok = true;
else
    sol = [];
    ok = false;
end
end


