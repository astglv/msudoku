function clear_entries_callback(src,~)
% CLEAR_ENTRIES_CALLBACK removes only user-inputted numbers.

fig = gcf;
cellHandles = getappdata(fig,'cellHandles');
puzzle = getappdata(fig,'puzzle');
if isempty(cellHandles)
    return;
end
if isempty(puzzle)
    puzzle = zeros(9);
end

for r = 1:9
    for c = 1:9
        if puzzle(r,c) == 0
            h = cellHandles(r,c);
            set(h,'String','',...
                'Enable','on');
        end
    end
end

setappdata(fig,'moves',0);
apply_theme(fig);
update_status(fig,'Status: user entries cleared');

btns = getappdata(fig, 'buttonHandles');
if ~isempty(buttonHandles) && numel(btns) >= 6
    set(btns([5, 6]), 'Enable', 'on'); % enable 'check' and 'clear entries' buttons
end

end