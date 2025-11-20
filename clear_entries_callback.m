function clear_entries_callback(src,~)
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
buttonHandles = getappdata(fig,'buttonHandles');
if ~isempty(buttonHandles)
    % Предполагаем, что Check имеет индекс 5. ПРОВЕРЬТЕ ИНДЕКС!
    checkButtonIndex = 5;

    % Clear Entries (индекс 6) уже нажата, ее нужно только убедиться, что она 'on'
    clearEntriesButtonIndex = 6;

    if numel(buttonHandles) >= clearEntriesButtonIndex && ishandle(buttonHandles(clearEntriesButtonIndex))
        set(buttonHandles(clearEntriesButtonIndex), 'Enable', 'on');
    end
    if numel(buttonHandles) >= checkButtonIndex && ishandle(buttonHandles(checkButtonIndex))
        set(buttonHandles(checkButtonIndex), 'Enable', 'on');
    end
end


