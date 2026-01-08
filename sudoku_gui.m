function sudoku_gui(showIntro, loadPuzzleFile)
% SUDOKU_GUI  Initializes the Sudoku GUI layout.

% Input parameters:
%   showIntro - (optional) logical, if true shows game introduction (default: true)
%   loadPuzzleFile - (optional) string, path to .txt file to load puzzle from (default: '')
if nargin < 1, showIntro = true; end
if nargin < 2, loadPuzzleFile = ''; end

% Style setup
style.fontName = 'Arial Rounded MT Bold';
style.cellFontSize = 18;
style.buttonFontSize = 12;
style.statusFontSize = 12;

style.figureBg = [0.97 0.97 0.98];
style.cellBg = [1 1 1];
style.cellText = [0.1 0.1 0.1];
style.prefillBg = [0.92 0.95 1];
style.prefillText = [0 0.2 0.6];
style.buttonBg = [0.88 0.92 0.98];
style.buttonText = [0.1 0.1 0.1];
style.statusBg = [0.9 0.93 0.98];
style.statusText = [0.05 0.05 0.05];
style.highlight = [1 0.7 0.7];
style.correctHighlight = [0.7 1 0.7];

% Game introduction at the beginning
hFig = figure('Name','Sudoku','NumberTitle','off',...
              'Position',[200 100 660 620],...
              'MenuBar','none','Resize','off');
if showIntro
    introText = {
        '                  === SUDOKU GAME ===';
        ' ';
        'RULES:';
        '- Fill the 9x9 grid with digits 1-9';
        '- Each row must contain all digits 1-9 exactly once';
        '- Each column must contain all digits 1-9 exactly once';
        '- Each 3x3 block must contain all digits 1-9 exactly once';
        ' ';
        'CONTROLS:';
        '- Click on cells to enter numbers (1-9)';
        '- New (Easy/Medium/Hard): Generate a new puzzle';
        '- Check: Validate your entries and find conflicts';
        '- Solve: Auto-complete the puzzle';
        '- Clear Entries: Remove only your entered digits';
        '- Clear All: Reset the entire board';
        '- Theme: Toggle between Day and Night themes';
        ' ';
        'SCORING:';
        '- Moves: Number of moves you made';
        '- Mistakes: You lose after 5 mistakes';
        '- Win: Complete the puzzle correctly!'
    };
    msgbox(introText, 'Welcome to Sudoku', 'help');
end

cellSize = 45;
gap = 2;
blockGap = 10;
startX = 20;
startY = 580;
cellHandles = zeros(9);
for r = 1:9
    for c = 1:9
        addX = floor((c-1)/3)*blockGap;
        addY = floor((r-1)/3)*blockGap;
        x = startX + (c-1)*(cellSize+gap) + addX;
        y = startY - (r)*(cellSize+gap) - addY;

        cellHandles(r,c) = uicontrol('Style','edit','String','',...
            'Position',[x y cellSize cellSize],...
            'FontSize',style.cellFontSize,'FontName',style.fontName,...
            'HorizontalAlignment','center',...
            'BackgroundColor',style.cellBg,...
            'Callback', @cell_edit_callback);
    end
end

btnX = 500; btnW = 140; btnH = 35;
buttonHandles = []; % Initialize array to store button handles

buttonHandles(1) = uicontrol('Style','pushbutton','String','New (Easy)','Position',[btnX, 520, btnW, btnH],...
    'Callback',@(src,evt)generate_button_callback(src,'easy'));
buttonHandles(2) = uicontrol('Style','pushbutton','String','New (Medium)','Position',[btnX, 475, btnW, btnH],...
    'Callback',@(src,evt)generate_button_callback(src,'medium'));
buttonHandles(3) = uicontrol('Style','pushbutton','String','New (Hard)','Position',[btnX, 430, btnW, btnH],...
    'Callback',@(src,evt)generate_button_callback(src,'hard'));
buttonHandles(4) = uicontrol('Style','pushbutton','String','Solve','Position',[btnX, 360, btnW, btnH],...
    'Callback',@solve_button_callback);
buttonHandles(5) = uicontrol('Style','pushbutton','String','Check','Position',[btnX, 315, btnW, btnH],...
    'Callback',@check_button_callback);
buttonHandles(6) = uicontrol('Style','pushbutton','String','Clear Entries','Position',[btnX, 270, btnW, btnH],...
    'Callback',@clear_entries_callback);
buttonHandles(7) = uicontrol('Style','pushbutton','String','Clear All','Position',[btnX, 225, btnW, btnH],...
    'Callback',@clear_button_callback);
buttonHandles(8) = uicontrol('Style','pushbutton','String','Load Puzzle','Position',[btnX, 180, btnW, btnH],...
    'Callback',@load_puzzle_callback);

% Apply button styles
set(buttonHandles, 'BackgroundColor', style.buttonBg, 'ForegroundColor', style.buttonText);

statusHandle = uicontrol('Style','text','String','Status: ready',...
    'Position',[20 20 610 30],...
    'Tag','status_box','HorizontalAlignment','left',...
    'FontSize',style.statusFontSize,'FontName',style.fontName);

movesHandle = uicontrol('Style','text','String','Moves: 0',...
    'Position',[20 55 200 30],...
    'Tag','moves_box','HorizontalAlignment','left',...
    'FontSize',style.statusFontSize,'FontName',style.fontName);

mistakesHandle = uicontrol('Style','text','String','Mistakes: 0/5',...
    'Position',[240 55 200 30],...
    'Tag','mistakes_box','HorizontalAlignment','left',...
    'FontSize',style.statusFontSize,'FontName',style.fontName);

setappdata(hFig,'cellHandles',cellHandles);
setappdata(hFig,'buttonHandles',buttonHandles);
setappdata(hFig,'statusHandle',statusHandle);
setappdata(hFig,'finalElapsed',0);
setappdata(hFig,'movesHandle',movesHandle);
setappdata(hFig,'mistakesHandle',mistakesHandle);
setappdata(hFig,'fullGrid',zeros(9));
setappdata(hFig,'puzzle',zeros(9));
setappdata(hFig,'moves',0);
setappdata(hFig,'mistakes',0);
setappdata(hFig,'gameActive',false);
setappdata(hFig,'style',style);
setappdata(hFig,'loadPuzzleFile',loadPuzzleFile);

apply_theme(hFig);

% Load puzzle from file if provided
if ~isempty(loadPuzzleFile)
    load_puzzle_from_file(hFig, loadPuzzleFile);
end

setappdata(hFig, 'style', style);
set(hFig, 'Color', style.figureBg);

end