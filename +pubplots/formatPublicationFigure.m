function formatPublicationFigure(fig, style)
%FORMATPUBLICATIONFIGURE Apply a publication style to a MATLAB figure
%
%   formatPublicationFigure(fig)
%       Applies the default full-width publication style to figure 'fig'
%
%   formatPublicationFigure(fig, style)
%       Applies the provided style struct to figure 'fig'
%
%   Inputs:
%       fig   - Figure handle (scalar) style - Optional style struct (from
%       publicationStyle package)

%-------------------------------
% Input handling
%-------------------------------
if nargin < 1 || isempty(fig)
    fig = gcf;
end
if nargin < 2 || isempty(style)
    style = myPublicationPlots.styles.fullWidthDefault();
end

%-------------------------------
% Validate figure handle
%-------------------------------
if ~ishandle(fig) || ~strcmp(get(fig, 'Type'), 'figure')
    error('Input must be a valid figure handle.');
end

%-------------------------------
% Apply figure properties
%-------------------------------
set(fig, 'Color', style.figure.backgroundColor, ...
    'Units', style.figure.units, ...
    'Position', style.figure.position_cm, ...
    'Renderer', style.figure.renderer, ...
    'WindowStyle', style.figure.windowStyle);
if  ~strcmp(style.figure.windowStyle, "docked") && ...
        isfield(style.figure, 'position_cm') && ...
    all(style.figure.position_cm == [0 0 1 1])
    set(fig, "WindowState", "maximized");
end

%-------------------------------
% Super title (sgtitle)
%-------------------------------
if isfield(style, 'supertitle')
    ch = fig.Children;
    % check for figure children of type text (sgtitles)
    for c = ch(:)'
        if isa(c, 'matlab.graphics.illustration.subplot.Text')
            set(c, 'FontName', style.supertitle.fontName, ...
                'FontSize', style.supertitle.fontSize_pt, ...
                'FontWeight', style.supertitle.fontWeight, ...
                'Interpreter', style.supertitle.interpreter, ...
                'Color', style.supertitle.color, ...
                'HorizontalAlignment', style.supertitle.horizontalAlignment);
        end
    end
end

%-------------------------------
% Find all axes in the figure
%-------------------------------
axesHandles = findall(fig, 'Type', 'axes');

for ax = axesHandles(:)'
    %---------------------------
    % Axes properties
    %---------------------------
    set(ax, 'FontName', style.axes.fontName, ...
        'FontSize', style.axes.fontSize_pt, ...
        'FontWeight', style.axes.fontWeight, ...
        'LineWidth', style.axes.lineWidth_pt, ...
        'TickDir', style.axes.tickDirection, ...
        'TickLength', style.axes.tickLength, ...
        'Box', style.axes.box, ...
        'Layer', style.axes.layer, ...
        'XGrid', style.axes.xGrid, ...
        'YGrid', style.axes.yGrid, ...
        'ZGrid', style.axes.zGrid, ...
        'XMinorTick', style.axes.xMinorTick, ...
        'YMinorTick', style.axes.yMinorTick, ...
        'ZMinorTick', style.axes.zMinorTick);

    %---------------------------
    % Lines and markers in this axes
    %---------------------------
    lines = findall(ax, 'Type', 'line');
    for ln = lines(:)'
        % Only apply style linewidth if the line's LineWidth equals default
        % MATLAB value (0.5)
        currentLW = get(ln, 'LineWidth');
        if isempty(currentLW) || abs(currentLW - get(groot, 'DefaultLineLineWidth')) < eps
            set(ln, 'LineWidth', style.line.lineWidth_pt);
        end
        % Apply marker size always
        set(ln, 'MarkerSize', style.marker.size_pt);
    end

    %---------------------------
    % Text objects in this axes
    %---------------------------
    texts = findall(ax, 'Type', 'text');
    for t = texts(:)'
        set(t, 'FontName', style.text.fontName, ...
            'FontSize', style.text.fontSize_pt, ...
            'FontWeight', style.text.fontWeight, ...
            'Interpreter', style.text.interpreter);
    end

    %---------------------------
    % Axis labels
    %---------------------------
    xlabelHandle = get(ax, 'XLabel');
    ylabelHandle = get(ax, 'YLabel');
    titleHandle  = get(ax, 'Title');
    set(xlabelHandle, 'FontSize', style.label.fontSize_pt, ...
        'FontWeight', style.label.fontWeight);
    set(ylabelHandle, 'FontSize', style.label.fontSize_pt, ...
        'FontWeight', style.label.fontWeight);
    set(titleHandle,  'FontSize', style.title.fontSize_pt, ...
        'FontWeight', style.title.fontWeight);

    %---------------------------
    % Legends
    %---------------------------
    % Only format existing, visible legends
    legendHandle = findobj(fig, 'Type', 'legend', 'Parent', ax);
    if ~isempty(legendHandle)
        for lg = legendHandle(:)'
            % Only process if legend is visible
            if strcmp(lg.Visible, 'on')
                % Filter entries to only those with non-empty DisplayName
                entries = findall(ax, 'Type', 'line');
                names = {entries.DisplayName};
                validIdx = ~cellfun(@isempty, names) & ~strcmp(names, '');
                % Update the legend with valid entries
                if any(validIdx)
                    legend(lg, entries(validIdx));
                    set(lg, 'FontSize', style.legend.fontSize_pt, ...
                        'FontName', style.legend.fontName, ...
                        'Box', style.legend.box, ...
                        'Location', style.legend.location);
                else
                    % If no valid names, hide legend
                    set(lg, 'Visible', 'off');
                end
            end
        end
    end

    %---------------------------
    % Colorbars
    %---------------------------
    colorbars = findall(ax, 'Type', 'colorbar');
    for cb = colorbars(:)'
        set(cb, 'FontSize', style.colorbar.fontSize_pt, ...
            'LineWidth', style.colorbar.lineWidth_pt);
    end
end

%-------------------------------
% Handle tiled layout
%-------------------------------
tLayouts = findall(fig, '-isa', 'matlab.graphics.layout.TiledChartLayout');

for tl = tLayouts(:)'
    % TileSpacing
    if isfield(style.tiled, 'TileSpacing')
        if isnumeric(style.tiled.TileSpacing) || ischar(style.tiled.TileSpacing)
            tl.TileSpacing = style.tiled.TileSpacing;
        end
    end
    % Padding
    if isfield(style.tiled, 'Padding')
        if isnumeric(style.tiled.Padding) || ischar(style.tiled.Padding)
            tl.Padding = style.tiled.Padding;
        end
    end
    % Optional margins (adjust position manually)
    if isfield(style.tiled, 'margins') && ~isempty(style.tiled.margins)
        margins = style.tiled.margins;
        % Convert [left right bottom top] into normalized position
        pos = [margins(1), margins(3), 1 - margins(1) - margins(2), 1 - margins(3) - margins(4)];
        set(tl, 'Units', 'normalized', 'Position', pos);
    end
end

if ~isempty(tLayouts) && isfield(style, 'supertitle')
    for tl = tLayouts(:)'
        sg = tl.Title;
        if ~isempty(sg) && isvalid(sg)
            set(sg, 'FontName', style.supertitle.fontName, ...
                'FontSize', style.supertitle.fontSize_pt, ...
                'FontWeight', style.supertitle.fontWeight, ...
                'Interpreter', style.supertitle.interpreter, ...
                'Color', style.supertitle.color, ...
                'HorizontalAlignment', style.supertitle.horizontalAlignment);
        end
    end
end
end