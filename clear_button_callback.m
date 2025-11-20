function clear_button_callback(src,~)
fig = gcf;
cellHandles = getappdata(fig,'cellHandles');

if isempty(cellHandles)
    return;
end

for idx = 1:numel(cellHandles)
    set(cellHandles(idx),'String','',...
        'Enable','on');
end

setappdata(fig,'fullGrid',zeros(9));
setappdata(fig,'puzzle',zeros(9));
setappdata(fig,'moves',0);
setappdata(fig,'mistakes',0);

mistakesHandle = getappdata(fig,'mistakesHandle');
if ~isempty(mistakesHandle) && ishandle(mistakesHandle)
    set(mistakesHandle,'String','Mistakes: 0/5');
end

movesHandle = getappdata(fig,'movesHandle');
if ~isempty(movesHandle) && ishandle(movesHandle)
    set(movesHandle,'String','Moves: 0');
end

apply_theme(fig);
update_status(fig,'Status: cleared');

buttonHandles = getappdata(fig,'buttonHandles');

if ~isempty(buttonHandles)

    checkButtonIndex = 5;
    clearEntriesButtonIndex = 6;

    if numel(buttonHandles) >= clearEntriesButtonIndex && ishandle(buttonHandles(clearEntriesButtonIndex))
        set(buttonHandles(clearEntriesButtonIndex), 'Enable', 'on');
    end
    if numel(buttonHandles) >= checkButtonIndex && ishandle(buttonHandles(checkButtonIndex))
        set(buttonHandles(checkButtonIndex), 'Enable', 'on');
    end
end

