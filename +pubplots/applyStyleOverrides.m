function style = applyStyleOverrides(style, varargin)
%APPLYSTYLEOVERRIDES Override fields in a publication style struct
%
%   style = publicationStyle.applyStyleOverrides(style, 'field1', value1,
%   ...)
%
%   Supports nested fields using dot notation, e.g.:
%       style = publicationStyle.applyStyleOverrides(style, ...
%           'axes.fontSize_pt', 8, ... 'line.lineWidth_pt', 1.5);
%
%   Input:
%       style   - style struct to override varargin - name-value pairs for
%       overrides
%
%   Output:
%       style   - updated style struct with applied overrides

%------------------------------
% Validate input
%------------------------------
if mod(numel(varargin), 2) ~= 0
    error('Overrides must be specified as name-value pairs.');
end

%------------------------------
% Apply each override
%------------------------------
for k = 1:2:numel(varargin)
    fieldPath = varargin{k};
    newValue  = varargin{k+1};

    if ~ischar(fieldPath) && ~isstring(fieldPath)
        error('Field names must be strings.');
    end

    fieldParts = split(fieldPath, '.');  % split nested path
    style = setNestedField(style, fieldParts, newValue);
end
end

%---------------------------------------------------
function s = setNestedField(s, fieldParts, value)
%SETNESTEDFIELD Recursively sets a nested field in a struct

if numel(fieldParts) == 1
    % Base case: assign value
    if isfield(s, fieldParts{1})
        s.(fieldParts{1}) = value;
    else
        error('Field "%s" does not exist in the style struct.', fieldParts{1});
    end
else
    % Recursive case
    if isfield(s, fieldParts{1})
        s.(fieldParts{1}) = setNestedField(s.(fieldParts{1}), fieldParts(2:end), value);
    else
        error('Field "%s" does not exist in the style struct.', fieldParts{1});
    end
end
end
