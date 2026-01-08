function ok = can_place(G, r, c, val)
% CAN_PLACE validates a number move against Sudoku rules.

%'ok' move is allowed by the rules of Sudoku.
ok = true;
if val < 1 || val > 9
    ok = false; return;
end
% check in a row
for j = 1:9
    if G(r,j) == val
        ok = false; return;
    end
end
% check in a column
for i = 1:9
    if G(i,c) == val
        ok = false; return;
    end
end
% check in a 3x3 square
r0 = floor((r-1)/3)*3 + 1;
c0 = floor((c-1)/3)*3 + 1;
for i = r0:(r0+2)
    for j = c0:(c0+2)
        if G(i,j) == val
            ok = false;
            return;
        end
    end
end

end