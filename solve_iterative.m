function [sol, ok] = solve_iterative(grid)
% SOLVE_ITERATIVE  backtracking Sudoku solver.

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
i = 1;

while i >= 1 && i <= n
    r = empties(i,1);
    c = empties(i,2);
    placed = false;

    for v = (tried(i)+1):9
        if can_place(G,r,c,v)
            G(r,c) = v;
            tried(i) = v;
            i = i + 1;
            placed = true;
            break;
        end
    end

    if ~placed
        tried(i) = 0;
        G(r,c) = 0;
        i = i - 1;
    end
end

if i == n + 1
    sol = G;
    ok = true;
else
    sol = [];
    ok = false;
end
end