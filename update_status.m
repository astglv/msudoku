function update_status(fig, message)
% UPDATE_STATUS  Safely updates the status text in the GUI.
if nargin < 1 || isempty(fig) || ~ishandle(fig)
    fig = gcf;
end

statusBox = findobj(fig,'Tag','status_box');
if isempty(statusBox) || ~ishandle(statusBox)
    warning('Status box not found.');
    return;
end

set(statusBox,'String',message);
end


