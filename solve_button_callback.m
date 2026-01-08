function solve_button_callback(src,~)
% SOLVE_BUTTON_CALLBACK populates the grid with the calculated solution.

fig = gcf;
cellHandles = getappdata(fig,'cellHandles');

if isempty(cellHandles)
    return;
end
setappdata(fig,'gameActive',false);

% use ~ to discard the second output - invalidMask (errors)
[G, ~] = read_grid_from_handles(cellHandles);

fullG = getappdata(fig,'fullGrid');
if isempty(fullG) || isequal(G, fullG)
    % grid was not generated or is already solved, try to solve the current G
    [solvedG, ok] = solve_iterative(G);
    if ok
        for r = 1:9
            for c = 1:9
                h = cellHandles(r,c);
                set(h,'String',num2str(solvedG(r,c)),...
                    'Enable','inactive');
            end
        end
        update_status(fig,'Status: solved current grid');
        setappdata(fig,'fullGrid',solvedG);
    else
        update_status(fig,'Status: current grid is unsolvable');
    end
else
    % use the stored solution
    for r = 1:9
        for c = 1:9
            h = cellHandles(r,c);
            set(h,'String',num2str(fullG(r,c)),...
                'Enable','inactive');
        end
    end
    update_status(fig,'Status: displayed solution');
end

apply_theme(fig);
set_buttons_enabled(fig, 'off')
end