function set_buttons_enabled(fig, state)
% SET_BUTTONS_ENABLED toggles the interactive state of the game control buttons.

    btns = getappdata(fig, 'buttonHandles');
    if ~isempty(btns) && numel(btns) >= 6
        set(btns(5), 'Enable', state); % 'Check' button
        set(btns(6), 'Enable', state); % 'Clear Entries' button
    end
end