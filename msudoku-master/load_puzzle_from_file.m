function load_puzzle_from_file(fig, filename)
% LOAD_PUZZLE_FROM_FILE  Loads a Sudoku puzzle from a .txt file.
% 
% The file should contain 9 lines, each with 9 digits (0-9) separated by spaces.
% 0 represents an empty cell.

if nargin < 2 || isempty(filename)
    update_status(fig, 'Status: no filename provided');
    return;
end

if ~exist(filename, 'file')
    update_status(fig, sprintf('Status: file not found: %s', filename));
    return;
end

try
    % Read the file
    fid = fopen(filename, 'r');
    if fid == -1
        update_status(fig, sprintf('Status: could not open file: %s', filename));
        return;
    end
    
    puzzle = zeros(9, 9);
    lineNum = 1;
    
    while ~feof(fid) && lineNum <= 9
        line = fgetl(fid);
        if ischar(line)
            % Remove whitespace and convert to numbers
            numbers = sscanf(line, '%d');
            if length(numbers) >= 9
                puzzle(lineNum, :) = numbers(1:9);
            end
        end
        lineNum = lineNum + 1;
    end
    
    fclose(fid);
    
    % Validate puzzle (should be 9x9, values 0-9)
    if ~isequal(size(puzzle), [9 9])
        update_status(fig, 'Status: invalid puzzle format (must be 9x9)');
        return;
    end
    
    if any(puzzle(:) < 0) || any(puzzle(:) > 9)
        update_status(fig, 'Status: invalid values (must be 0-9)');
        return;
    end
    
    % Load puzzle into GUI
    cellHandles = getappdata(fig, 'cellHandles');
    if isempty(cellHandles)
        update_status(fig, 'Status: GUI not initialized');
        return;
    end
    
    for r = 1:9
        for c = 1:9
            h = cellHandles(r, c);
            if puzzle(r, c) == 0
                set(h, 'String', '', 'Enable', 'on');
            else
                set(h, 'String', num2str(puzzle(r, c)), 'Enable', 'inactive');
            end
        end
    end
    
    % Try to solve the puzzle to get full solution
    [solvedG, ok] = solve_iterative(puzzle);
    if ok
        setappdata(fig, 'fullGrid', solvedG);
    else
        setappdata(fig, 'fullGrid', zeros(9));
    end
    
    setappdata(fig, 'puzzle', puzzle);
    setappdata(fig, 'moves', 0);
    setappdata(fig, 'mistakes', 0);
    setappdata(fig, 'gameActive', true);
    
    apply_theme(fig);
    update_status(fig, sprintf('Status: loaded puzzle from %s', filename));
    
    % Enable buttons
    buttonHandles = getappdata(fig, 'buttonHandles');
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
    
catch ME
    update_status(fig, sprintf('Status: error loading file: %s', ME.message));
end
end

