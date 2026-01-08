function apply_theme(fig)
% APPLY_THEME updates UI to match the selected visual style.

if nargin == 0 || isempty(fig) || ~ishandle(fig)
    fig = gcf;
end

style = getappdata(fig, 'style');

% paint the background
set(fig, 'Color', style.figureBg);

% paint the cells
cellHandles = getappdata(fig, 'cellHandles');
for i = 1:numel(cellHandles)
    h = cellHandles(i);
    if ishandle(h)
        % paint the preset numbers
        if strcmp(get(h, 'Enable'), 'inactive')
            bg = style.prefillBg;
            fg = style.prefillText;
        else
            bg = style.cellBg;
            fg = style.cellText;
        end
        set(h, 'BackgroundColor', bg, 'ForegroundColor', fg, ...
               'FontName', style.fontName, 'FontSize', style.cellFontSize);
    end
end

% paint the buttons
buttonHandles = getappdata(fig, 'buttonHandles');
for i = 1:numel(buttonHandles)
    h = buttonHandles(i);
    if ishandle(h)
        set(h, 'BackgroundColor', style.buttonBg, 'ForegroundColor', style.buttonText, ...
               'FontName', style.fontName, 'FontSize', style.buttonFontSize);
    end
end

% paint the text cells
handlesToUpdate = [getappdata(fig, 'statusHandle'), ...
                   getappdata(fig, 'movesHandle'), ...
                   getappdata(fig, 'mistakesHandle')];

for h = handlesToUpdate
    if ~isempty(h) && ishandle(h)
        set(h, 'BackgroundColor', style.statusBg, 'ForegroundColor', style.statusText, ...
               'FontName', style.fontName, 'FontSize', style.statusFontSize);
    end
end

end