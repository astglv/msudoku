function solve_button_callback(~, ~)
% SOLVE_BUTTON_CALLBACK Zobrazí kompletné riešenie
fig = gcf;
h = getappdata(fig, 'cellHandles');
sol = getappdata(fig, 'fullGrid');

if isempty(sol)
    [G, ~] = read_grid_from_handles(h);
    [sol, ok] = solve_iterative(G);
    if ~ok, update_status(fig, 'Riešenie neexistuje'); return; end
end

for i = 1:81
    set(h(i), 'String', num2str(sol(i)), 'Enable', 'inactive');
end
apply_theme(fig);
update_status(fig, 'Sudoku vyriešené');
end
