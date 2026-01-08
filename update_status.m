function update_status(fig, message)
% UPDATE_STATUS  Safely updates the status text in the GUI.

if nargin < 1 || isempty(fig), fig = gcf; end
sh = getappdata(fig, 'statusHandle');
if ~isempty(sh) && ishandle(sh)
    set(sh, 'String', message);
else
    disp(message)
end
end