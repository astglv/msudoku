function clear_button_callback(src,~)
% CLEAR_BUTTON_CALLBACK clears the entire board and resets all game data.

fig = gcf;
cellHandles = getappdata(fig,'cellHandles');
if isempty(cellHandles)
    return;
end
set(cellHandles, 'String', '', 'Enable', 'on')

setappdata(fig,'fullGrid',zeros(9));
setappdata(fig,'puzzle',zeros(9));
setappdata(fig,'moves',0);
setappdata(fig,'mistakes',0);

msH = getappdata(fig, 'mistakesHandle');
if ishandle(msH), set(msH, 'String', 'Mistakes: 0/5'); end
mvH = getappdata(fig, 'movesHandle');
if ishandle(mvH), set(mvH, 'String', 'Moves: 0'); end

apply_theme(fig);
update_status(fig,'Status: cleared');
set_buttons_enabled(fig, 'on')

end