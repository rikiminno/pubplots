function style = JGCDsubfig(nRows, nCols, height_cm)
%JGCDSUBFIG Style for one subfigure panel of a JGCD multipart figure
%
%   style = publicationStyle.JGCDsubfig(nRows, nCols)
%   style = publicationStyle.JGCDsubfig(nRows, nCols, height_cm)
%
%   nRows, nCols : layout of the LaTeX subfigures in the final figure.
%                  Supported up to 3x2 and 2x3 (at most 6 panels).
%   height_cm    : optional panel height override, e.g. when one panel
%                  contains several stacked axes.
%
%   Each panel is exported at the width it occupies when printed, with
%   >= 8 pt lettering [AIAA]:
%     nCols = 1 -> single column, panel 3.25 in wide
%     nCols = 2 -> page width (7 in), panel 3.25 in (~3.4 in available)
%     nCols = 3 -> page width (7 in), panel 2.25 in
%   A panel exported this way stays compliant if production re-stacks the
%   panels into one column, since it can only be enlarged.
%
%   style.layout carries the placement and a suggested LaTeX subfigure
%   width for the chosen layout.

arguments
    nRows     (1,1) double {mustBeInteger, mustBeInRange(nRows, 1, 3)}
    nCols     (1,1) double {mustBeInteger, mustBeInRange(nCols, 1, 3)}
    height_cm (1,1) double = NaN
end

if nRows * nCols > 6
    error('publicationStyle:JGCDsubfig:unsupportedLayout', ...
        'Layout %dx%d not supported: use at most 3x2 or 2x3.', nRows, nCols);
end

style = pubplots.styles.JGCDsingleColumn();

in2cm = 2.54;

%===========================================================
% Panel width from the number of columns
%===========================================================
switch nCols
    case 1
        panelWidth_in = 3.25;               % one column [AIAA]
        placement     = "single column";
        subfigWidth   = '3.25in';
    case 2
        panelWidth_in = 3.25;               % (7 in - gap)/2 ~ 3.4 in available
        placement     = "page width";
        subfigWidth   = '0.49\textwidth';
    case 3
        panelWidth_in = 2.25;               % (7 in - 2 gaps)/3 ~ 2.25 in
        placement     = "page width";
        subfigWidth   = '0.32\textwidth';
end

%===========================================================
% Panel height from the layout (in), rows x cols
%===========================================================
%                 1 col  2 cols  3 cols
panelHeight_in = [ 2.5    2.5     1.9  ;   % 1 row
                   2.2    2.3     1.8  ;   % 2 rows
                   2.0    2.1     NaN  ];  % 3 rows
h_cm = panelHeight_in(nRows, nCols) * in2cm;
if ~isnan(height_cm)
    h_cm = height_cm;
end

%===========================================================
% Figure size
%===========================================================
style.figure.width_cm    = panelWidth_in * in2cm;
style.figure.height_cm   = h_cm;
style.figure.position_cm = [0 0 style.figure.width_cm h_cm];

if nCols == 3
    style.axes.tickLength = [0.02 0.02];    % shorter axes need relatively longer ticks
end

%===========================================================
% Layout information (for reference / LaTeX placement)
%===========================================================
subcaption_in = 0.25;                       % approx. "a)" line + spacing per row
style.layout.rows             = nRows;
style.layout.cols             = nCols;
style.layout.placement        = placement;  % use figure for single column, figure* for page width
style.layout.latexSubfigWidth = subfigWidth;
style.layout.totalHeight_cm   = nRows * (h_cm + subcaption_in * in2cm);

end