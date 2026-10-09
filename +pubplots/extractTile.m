function newFig = extractTile(fig, row, col)
%EXTRACTTILE Extract a tile from a tiledlayout into a new figure.
%
%   newFig = extractTile(fig, row, col)
%
% Inputs
%   fig : Handle to a figure containing a tiledlayout
%   row : Row of the tile to extract
%   col : Column of the tile to extract
%
% Output
%   newFig : Handle to the newly created figure
%
% Example
%   newFig = extractTile(gcf, 2, 1);
%
% Notes
%   - The tiledlayout must use a fixed arrangement, i.e. it must have been
%     created using something such as tiledlayout(2,3).
%   - Axes spanning multiple tiles are handled correctly.
%   - Cartesian, polar, and geographic axes are supported.
%   - Associated legends are copied.
%   - Associated colorbars are copied when MATLAB exposes their associated
%     axes through the ColorBar "Axes" property.
%
% See also TILEDLAYOUT, COPYOBJ

    arguments
        fig (1,1) matlab.ui.Figure
        row (1,1) double {mustBeFinite, mustBeInteger, mustBePositive}
        col (1,1) double {mustBeFinite, mustBeInteger, mustBePositive}
    end

    %% Make sure graphics/layout information is up to date

    if ~isvalid(fig)
        error('extractTile:InvalidFigure', ...
            'The supplied figure handle is no longer valid.');
    end

    drawnow;


    %% Find the tiledlayout

    layouts = findall(fig, 'Type', 'tiledlayout');

    if isempty(layouts)
        error('extractTile:NoTiledLayout', ...
            'The supplied figure does not contain a tiledlayout.');
    end

    % Prefer a tiledlayout whose parent is the figure itself. This avoids
    % accidentally selecting a nested tiledlayout.
    directLayouts = layouts(arrayfun(@(h) isequal(h.Parent, fig), layouts));

    if numel(directLayouts) == 1
        tl = directLayouts;

    elseif numel(layouts) == 1
        % There is only one layout, possibly inside a panel or tab.
        tl = layouts;

    else
        error('extractTile:MultipleTiledLayouts', ...
            ['The supplied figure contains multiple tiledlayouts, so the ' ...
             'requested tile is ambiguous.']);
    end


    %% Verify that row/column addressing is meaningful

    if isprop(tl, 'TileArrangement')
        if ~strcmpi(string(tl.TileArrangement), "fixed")
            error('extractTile:NonFixedLayout', ...
                ['Row/column extraction requires a fixed tiledlayout. ' ...
                 'The supplied layout uses the "%s" arrangement.'], ...
                string(tl.TileArrangement));
        end
    end


    %% Validate requested tile

    gridSize = tl.GridSize;

    if numel(gridSize) ~= 2
        error('extractTile:InvalidGridSize', ...
            'Could not determine the tiledlayout grid size.');
    end

    nRows = gridSize(1);
    nCols = gridSize(2);

    if row > nRows || col > nCols
        error('extractTile:TileOutOfRange', ...
            ['Requested tile (%d,%d) is outside the %d-by-%d ' ...
             'tiledlayout.'], ...
            row, col, nRows, nCols);
    end


    %% Find axes occupying the requested tile

    children = tl.Children;

    isAxes = arrayfun( ...
        @(h) isa(h, 'matlab.graphics.axis.AbstractAxes'), ...
        children);

    allAxes = children(isAxes);

    srcAxes = gobjects(0,1);

    for k = 1:numel(allAxes)

        ax = allAxes(k);

        % An axes in a tiledlayout should have a numeric Layout.Tile.
        % Axes placed in outer tiles ('north', 'south', etc.) are ignored
        % because they do not correspond to a grid row/column.
        tileNumber = ax.Layout.Tile;

        if ~isnumeric(tileNumber) || ...
                ~isscalar(tileNumber) || ...
                ~isfinite(tileNumber)
            continue
        end

        % Determine the upper-left grid location occupied by this axes.
        [axRow, axCol] = getTileRowCol( ...
            tl, tileNumber, nRows, nCols);

        if isnan(axRow) || isnan(axCol)
            continue
        end

        % Account for axes spanning multiple tiles.
        span = ax.Layout.TileSpan;

        if isempty(span) || numel(span) ~= 2
            span = [1 1];
        end

        rowRange = axRow:(axRow + span(1) - 1);
        colRange = axCol:(axCol + span(2) - 1);

        if ismember(row, rowRange) && ismember(col, colRange)
            srcAxes(end+1,1) = ax; %#ok<AGROW>
        end
    end


    %% Check that the tile actually contains an axes

    if isempty(srcAxes)
        error('extractTile:EmptyTile', ...
            ['Tile (%d,%d) does not contain a Cartesian, polar, or ' ...
             'geographic axes. It may be empty or contain a standalone ' ...
             'chart object.'], ...
            row, col);
    end


    %% Detect yyaxis, which COPYOBJ does not reliably preserve

    for k = 1:numel(srcAxes)

        ax = srcAxes(k);

        if isprop(ax, 'YAxis')
            try
                if numel(ax.YAxis) > 1
                    error('extractTile:YYAxisUnsupported', ...
                        ['Tile (%d,%d) contains an axes created with ' ...
                         'yyaxis. MATLAB COPYOBJ does not reliably copy ' ...
                         'yyaxis axes, so extraction has been stopped ' ...
                         'rather than creating an incorrect figure.'], ...
                        row, col);
                end
            catch ME
                if strcmp(ME.identifier, 'extractTile:YYAxisUnsupported')
                    rethrow(ME);
                end
            end
        end
    end


    %% Build the set of objects that must be copied together

    objectsToCopy = gobjects(0,1);

    % Axes first.
    for k = 1:numel(srcAxes)
        objectsToCopy(end+1,1) = srcAxes(k); %#ok<AGROW>
    end


    % Associated legends.
    %
    % MATLAB requires a legend to be copied together with its associated
    % axes. The Legend property gives us that association directly.
    for k = 1:numel(srcAxes)

        ax = srcAxes(k);

        if isprop(ax, 'Legend')

            lgd = ax.Legend;

            if ~isempty(lgd) && isgraphics(lgd)
                objectsToCopy(end+1,1) = lgd; %#ok<AGROW>
            end
        end
    end


    %% Find associated colorbars

    % ColorBar does not provide the same documented Axes property on the
    % axes object itself. Recent MATLAB versions expose the associated axes
    % through the ColorBar object's Axes property. Use it when available.

    figObjects = findall(fig);

    isColorBar = arrayfun( ...
        @(h) isa(h, 'matlab.graphics.illustration.ColorBar'), ...
        figObjects);

    colorbars = figObjects(isColorBar);

    for k = 1:numel(colorbars)

        cb = colorbars(k);
        associatedAxes = [];

        try
            if isprop(cb, 'Axes')
                associatedAxes = cb.Axes;
            else
                associatedAxes = get(cb, 'Axes');
            end
        catch
            % If MATLAB does not expose the association, simply leave this
            % colorbar out rather than risk copying one belonging to a
            % different tile.
            associatedAxes = [];
        end

        if isempty(associatedAxes)
            continue
        end

        belongsToTile = false;

        for j = 1:numel(srcAxes)
            if isequal(associatedAxes, srcAxes(j))
                belongsToTile = true;
                break
            end
        end

        if belongsToTile
            objectsToCopy(end+1,1) = cb; %#ok<AGROW>
        end
    end


    %% Create destination figure

    newFig = figure( ...
        'Name', sprintf('Extracted tile (%d,%d)', row, col), ...
        'NumberTitle', 'off');

    % Preserve the original figure background where possible.
    try
        newFig.Color = fig.Color;
    catch
    end


    %% Create a 1-by-1 tiledlayout in the destination

    newTL = tiledlayout( ...
        newFig, 1, 1, ...
        'Padding', 'compact', ...
        'TileSpacing', 'compact');


    %% Copy axes + associated graphics

    try
        copiedObjects = copyobj(objectsToCopy, newTL);

    catch ME
        % Do not leave an empty/partially constructed figure behind if
        % COPYOBJ fails.
        if isvalid(newFig)
            delete(newFig);
        end

        rethrow(ME);
    end


    %% Place copied axes in the single destination tile

    isCopiedAxes = arrayfun( ...
        @(h) isa(h, 'matlab.graphics.axis.AbstractAxes'), ...
        copiedObjects);

    newAxes = copiedObjects(isCopiedAxes);

    for k = 1:numel(newAxes)

        newAxes(k).Layout.Tile = 1;

        if isprop(newAxes(k).Layout, 'TileSpan')
            newAxes(k).Layout.TileSpan = [1 1];
        end
    end


    %% Final graphics update

    drawnow;

end


function [row, col] = getTileRowCol(tl, tileNumber, nRows, nCols)
%GETTILEROWCOL Return row/column corresponding to a numeric tile index.
%
% Uses TILEROWCOL when available (R2022b+), with a backward-compatible
% fallback for earlier tiledlayout implementations.

    %#ok<INUSD> nRows is retained for clarity/future use.

    if exist('tilerowcol', 'file') == 2

        [row, col] = tilerowcol(tl, tileNumber);

    else

        % Fixed tiledlayout numbering is row-major:
        %
        %   1  2  3
        %   4  5  6
        %
        row = floor((tileNumber - 1) / nCols) + 1;
        col = mod(tileNumber - 1, nCols) + 1;

    end

end