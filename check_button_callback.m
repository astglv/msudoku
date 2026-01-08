function check_button_callback(src,~)
% CHECK_BUTTON_CALLBACK identifies rule violations, updates mistake counts, and checks for win/loss conditions.

fig = gcf;
style = getappdata(fig, 'style');
cellHandles = getappdata(fig,'cellHandles');
if isempty(cellHandles)
    return;
end

[G, invalidMask] = read_grid_from_handles(cellHandles);

% conflictMask - sudoku rule violations(true)
conflictMask = false(9);
for r = 1:9
    for c = 1:9
        v = G(r,c);
        if v == 0, continue; end
        G(r,c) = 0;
        if ~can_place(G,r,c,v)
            ok = false;
            conflictMask(r,c) = true;
        end
        G(r,c) = v;
    end
end

% mask logic
allErrors = invalidMask | conflictMask;
puzzle = getappdata(fig, 'puzzle');
userEntered = (puzzle == 0 & G ~= 0); % cells filled by player
userErrorMask = userEntered & allErrors;
correctMask = userEntered & ~allErrors;

highlight_cells(cellHandles, allErrors, style.highlight);
highlight_cells(cellHandles, correctMask, style.correctHighlight);

% game status and mistakes
gameActive = getappdata(fig, 'gameActive');
if ~gameActive, return; end

errorCount = sum(userErrorMask(:));
if errorCount > 0
    mistakes = getappdata(fig, 'mistakes') + errorCount;
    setappdata(fig, 'mistakes', mistakes);

    mH = getappdata(fig, 'mistakesHandle');
    if ishandle(mH), set(mH, 'String', sprintf('Mistakes: %d/5', mistakes)); end

    if mistakes >= 5
        update_status(fig, 'Status: 5 mistakes - YOU LOSE!');
        setappdata(fig, 'gameActive', false);
        set_buttons_enabled(fig, 'off');
    else
        update_status(fig, sprintf('Status: %d conflicts found!', errorCount));
    end
else
    % no errors found
    if all(G(:) ~= 0)
        update_status(fig, 'Status: WIN! Puzzle completed.');
        setappdata(fig, 'gameActive', false);
        set_buttons_enabled(fig, 'off');
    else
        update_status(fig, 'Status: Current entries are correct.');
    end
end

end