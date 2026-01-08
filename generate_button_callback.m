function generate_button_callback(src, level)
fig = gcf;
cellHandles = getappdata(fig, 'cellHandles');
if isempty(cellHandles), return; end

switch lower(level)
    case 'easy'
        blanks = 30;
    case 'medium'
        blanks = 40;
    case 'hard'
        blanks = 50;
    otherwise
        blanks = 40;
end

fullG = generate_full();
puz = make_puzzle(fullG, blanks);

if isempty(cellHandles)
    return;
end

for r = 1:9
    for c = 1:9
        h = cellHandles(r,c);
        if puz(r,c) == 0
            set(h,'String','','Enable','on');
        else
            set(h,'String',num2str(puz(r,c)), 'Enable','inactive');
        end
    end
end

setappdata(fig,'fullGrid',fullG);
setappdata(fig,'puzzle',puz);
setappdata(fig,'moves',0);
setappdata(fig,'mistakes',0);
setappdata(fig,'gameActive',true);
update_status(fig,sprintf('Status: new %s puzzle, blanks=%d',level,blanks));

apply_theme(fig);

buttonHandles = getappdata(fig,'buttonHandles');
if ~isempty(buttonHandles)
    % Indices: 5 = Check, 6 = Clear Entries
    checkButtonIndex = 5;
    clearEntriesButtonIndex = 6;
    set(buttonHandles(5), 'Enable', 'on');
    set(buttonHandles(6), 'Enable', 'on');
end

end