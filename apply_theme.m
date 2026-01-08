function apply_theme(fig)

if nargin == 0 || isempty(fig) || ~ishandle(fig)
    fig = gcf;
end

style = getappdata(fig, 'style');

% Paint the background
set(fig, 'Color', style.figureBg);

% Paint the cells
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

% Paint the buttons
buttonHandles = getappdata(fig, 'buttonHandles');
for i = 1:numel(buttonHandles)
    h = buttonHandles(i);
    if ishandle(h)
        set(h, 'BackgroundColor', style.buttonBg, 'ForegroundColor', style.buttonText, ...
               'FontName', style.fontName, 'FontSize', style.buttonFontSize);
    end
end

% 4. Paint the text cells
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