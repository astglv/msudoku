function generate_button_callback(src, level)
fig = gcf;
fullG = generate_full();

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

puz = make_puzzle(fullG, blanks);
cellHandles = getappdata(fig,'cellHandles');

if isempty(cellHandles)
    return;
end

for r = 1:9
    for c = 1:9
        h = cellHandles(r,c);
        if puz(r,c) == 0
            set(h,'String','',...
                'Enable','on');
        else
            set(h,'String',num2str(puz(r,c)),...
                'Enable','inactive');
        end
    end
end

apply_theme(fig);

setappdata(fig,'fullGrid',fullG);
setappdata(fig,'puzzle',puz);
setappdata(fig,'moves',0);
setappdata(fig,'mistakes',0);
setappdata(fig,'gameActive',true);
update_status(fig,sprintf('Status: new %s puzzle, blanks=%d',level,blanks));
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
