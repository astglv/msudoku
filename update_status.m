function update_status(fig, msg)
% UPDATE_STATUS Aktualizuje text v stavovom riadku
sb = findobj(fig, 'Tag', 'status_box');
if ~isempty(sb)
    set(sb, 'String', ['Status: ', msg]);
end
end
