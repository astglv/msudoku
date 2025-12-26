function sudoku_gui(showIntro, loadPuzzleFile)
% SUDOKU_GUI Hlavné okno hry Sudoku
if nargin < 1, showIntro = true; end
if nargin < 2, loadPuzzleFile = ''; end

% Nastavenie okna s priamym definovaním farby pozadia
hFig = figure('Name','Sudoku Premium','NumberTitle','off',...
              'Position',[200 100 660 620],...
              'MenuBar','none','Resize','off',...
              'Color',[0.97 0.97 0.98]);

% Zobrazenie pôvodných pravidiel
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
        '- Clear All: Reset the entire board'};
    msgbox(introText, 'Welcome', 'help');
end

% Vytvorenie hracej plochy 9x9
cellHandles = zeros(9);
for r = 1:9
    for c = 1:9
        addX = floor((c-1)/3)*10; addY = floor((r-1)/3)*10;
        cellHandles(r,c) = uicontrol('Style','edit','String','',...
            'Position',[20+(c-1)*47+addX, 580-r*47-addY, 45, 45],...
            'FontSize',18,'FontName','Arial Bold',...
            'HorizontalAlignment','center',...
            'BackgroundColor',[1 1 1],...
            'Callback',@cell_edit_callback);
    end
end

% Tlačidlá (Priame priradenie callbackov na samostatné súbory)
uicontrol('Style','pushbutton','String','New (Easy)','Position',[500 520 140 35],...
    'Callback',@(s,e)generate_button_callback(s,'easy'));
uicontrol('Style','pushbutton','String','New (Medium)','Position',[500 475 140 35],...
    'Callback',@(s,e)generate_button_callback(s,'medium'));
uicontrol('Style','pushbutton','String','New (Hard)','Position',[500 430 140 35],...
    'Callback',@(s,e)generate_button_callback(s,'hard'));

uicontrol('Style','pushbutton','String','Solve','Position',[500 360 140 35],...
    'Callback',@solve_button_callback);
uicontrol('Style','pushbutton','String','Check','Position',[500 315 140 35],...
    'Callback',@check_button_callback);
uicontrol('Style','pushbutton','String','Clear All','Position',[500 225 140 35],...
    'Callback',@clear_button_callback);

% Status panely
statusH = uicontrol('Style','text','String','Status: ready','Position',[20 20 610 30],...
    'HorizontalAlignment','left','Tag','status_box','FontSize', 11,'BackgroundColor',[0.97 0.97 0.98]);
movesH = uicontrol('Style','text','String','Moves: 0','Position',[20 55 200 30],...
    'HorizontalAlignment','left','FontSize', 11,'BackgroundColor',[0.97 0.97 0.98]);
mistakesH = uicontrol('Style','text','String','Mistakes: 0/5','Position',[240 55 200 30],...
    'HorizontalAlignment','left','FontSize', 11,'BackgroundColor',[0.97 0.97 0.98]);

% Uloženie dát do objektu okna
setappdata(hFig,'cellHandles',cellHandles);
setappdata(hFig,'statusHandle',statusH);
setappdata(hFig,'movesHandle',movesH);
setappdata(hFig,'mistakesHandle',mistakesH);
setappdata(hFig,'moves',0);
setappdata(hFig,'mistakes',0);

% Prvotné nastavenie vizuálu
apply_theme(hFig);
end
