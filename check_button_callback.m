function check_button_callback(src,~)

fig = gcf;
cellHandles = getappdata(fig,'cellHandles');

if isempty(cellHandles)
    return;
end

apply_theme(fig);
theme = get_active_theme(fig);
if isempty(theme) || ~isfield(theme,'highlight')
    highlightColor = [1 0.8 0.8];
else
    highlightColor = theme.highlight;
end
[G, invalidMask] = read_grid_from_handles(cellHandles);

ok = ~any(invalidMask(:));
if ~ok
    highlight_cells(cellHandles,invalidMask,highlightColor);
end

% conflictMask - sudoku rule violations(true)
conflictMask = false(9);
for r = 1:9
    for c = 1:9
        v = G(r,c);
        if v == 0
            continue;
        end
        G(r,c) = 0;
        if ~can_place(G,r,c,v)
            ok = false;
            conflictMask(r,c) = true;
        end
        G(r,c) = v;
    end
end

if any(conflictMask(:))
    highlight_cells(cellHandles,conflictMask,highlightColor);
end

% Moves and Mistakes Logic

gameActive = getappdata(fig,'gameActive');
moves = getappdata(fig,'moves');

if ok
    % Apply green highlighting for correct entries when there are no errors
    if gameActive
        puzzle = getappdata(fig,'puzzle');
        if isempty(puzzle)
            puzzle = zeros(9);
        end
        userEditableMask = (puzzle == 0);
        userEnteredMask = userEditableMask & (G ~= 0);
        correctMask = userEnteredMask; % All user entries are correct when ok is true

        if any(correctMask(:))
            if isempty(theme) || ~isfield(theme,'correctHighlight')
                correctColor = [0.7 1 0.7];
            else
                correctColor = theme.correctHighlight;
            end
            highlight_cells(cellHandles, correctMask, correctColor);
        end
    end

    if all(G(:)~=0)
        if check_complete(G)
            update_status(fig,sprintf('Status: WIN! Completed in %d moves',moves));
            setappdata(fig,'gameActive',false);

            % Disable buttons Clear Entries and Check
            buttonHandles = getappdata(fig,'buttonHandles');
            clearEntriesButtonHandle = buttonHandles(6);
            if ~isempty(clearEntriesButtonHandle) && ishandle(clearEntriesButtonHandle)
                set(clearEntriesButtonHandle, 'Enable', 'off');
            end

            checkButtonIndex = 5;
            checkButtonHandle = buttonHandles(checkButtonIndex);
            if ~isempty(checkButtonHandle) && ishandle(checkButtonHandle)
                set(checkButtonHandle, 'Enable', 'off');
            end

        else
            update_status(fig,'Status: grid is full but incorrect.');
        end
    else
        update_status(fig,'Status: current values are conflict-free.');
    end
else
    if gameActive
        puzzle = getappdata(fig,'puzzle');
        if isempty(puzzle)
            puzzle = zeros(9);
        end

        allErrorsMask = invalidMask | conflictMask;

        % Calculate correct mask for green highlighting
        % Cells that are: user-entered, have a value, and are correct (no errors)
        userEditableMask = (puzzle == 0);
        userEnteredMask = userEditableMask & (G ~= 0);
        correctMask = userEnteredMask & ~allErrorsMask;

        % Apply green highlighting for correct entries
        if any(correctMask(:))
            if isempty(theme) || ~isfield(theme,'correctHighlight')
                correctColor = [0.7 1 0.7];
            else
                correctColor = theme.correctHighlight;
            end
            highlight_cells(cellHandles, correctMask, correctColor);
        end

        % userErrorMask - Mistakes that count against the player.
        % finds cells that have errors (allErrorsMask)
        % AND ensures we only blame the user for cells they can actually edit (puzzle == 0)
        userErrorMask = userEditableMask & allErrorsMask;

        errorCount = sum(userErrorMask(:));

        if errorCount > 0
            mistakes = getappdata(fig,'mistakes');

            mistakes = mistakes + errorCount;

            setappdata(fig,'mistakes',mistakes);

            mistakesHandle = getappdata(fig,'mistakesHandle');
            if ~isempty(mistakesHandle) && ishandle(mistakesHandle)
                set(mistakesHandle,'String',sprintf('Mistakes: %d/5',mistakes));
            end

            if mistakes >= 5
                update_status(fig,'Status: 5 mistakes - you lose!');
                setappdata(fig,'gameActive',false);

                % Clear all user entries except incorrect ones
                % Keep only incorrect user entries visible and highlighted in red
                for r = 1:9
                    for c = 1:9
                        if puzzle(r,c) == 0
                          set(cellHandles(r,c), 'Enable', 'off');

                        end
                    end
                end



                % Reset all cells to default theme colors first
                apply_theme(fig);

                % Then apply red highlighting only to incorrect user entries
                highlight_cells(cellHandles, userErrorMask, highlightColor);

                buttonHandles = getappdata(fig,'buttonHandles');

                % Disable button 'Clear Entries' (index 6)
                clearEntriesButtonHandle = buttonHandles(6);
                if ~isempty(clearEntriesButtonHandle) && ishandle(clearEntriesButtonHandle)
                    set(clearEntriesButtonHandle, 'Enable', 'off');
                end

                % Disable button 'Check'
                checkButtonIndex = 5;
                checkButtonHandle = buttonHandles(checkButtonIndex);
                if ~isempty(checkButtonHandle) && ishandle(checkButtonHandle)
                    set(checkButtonHandle, 'Enable', 'off');
                end

            else
                update_status(fig,sprintf('Status: conflicts found! Mistakes: %d/5',mistakes));
            end
        else
            update_status(fig,'Status: conflicts or invalid input found (highlighted).');
        end
    else
        update_status(fig,'Status: conflicts or invalid input found (highlighted).');
    end
end
end
