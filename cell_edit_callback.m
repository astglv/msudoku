function cell_edit_callback(hCell, ~)
s = strtrim(get(hCell,'String'));
fig = gcf;

if isempty(s)
    set(hCell,'String','');
    return;
end

v = str2double(s);
if isnan(v) || v < 1 || v > 9 || floor(v)~=v
    set(hCell,'String','');
    update_status(fig,'Status: enter an integer from 1 to 9');
    return;
end

set(hCell,'String',num2str(v));

gameActive = getappdata(fig,'gameActive');
if isempty(gameActive) || ~gameActive
    return;
end

moves = getappdata(fig,'moves');
moves = moves + 1;
setappdata(fig,'moves',moves);

movesHandle = getappdata(fig,'movesHandle');
if ~isempty(movesHandle) && ishandle(movesHandle)
    set(movesHandle,'String',sprintf('Moves: %d',moves));
end
update_status(fig,sprintf('Status: move %d (entered %d)',moves,v));

end