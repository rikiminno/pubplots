function style = JGCDsingleColumn()
%JGCDSINGLECOLUMN Create default style for JGCD single-column figures
%
%   style = publicationStyle.JGCDsingleColumn()
%
%   Returns a fully populated style struct for figures (or individual
%   subfigure panels) sized to one AIAA journal column. AIAA requirements:
%   3 1/4 in column width, <= 3 1/2 in height to avoid adding page length,
%   lettering >= 8 pt at column width, line weight >= 0.28 pt, screens no
%   lighter than 20%, 600 dpi for line art.

%===========================================================
% Figure properties
%===========================================================
style.figure.units              = 'centimeters';
style.figure.backgroundColor    = 'white';
style.figure.renderer           = 'painters';

% Single-column figure size
style.figure.width_cm           = 8.255;  % 3.25 in column width [AIAA]
style.figure.height_cm          = 6.35;   % 2.5 in; keep <= 8.89 cm (3.5 in) [AIAA]

% Position vector convenience (derived)
style.figure.position_cm        = [0 0 ...
    style.figure.width_cm ...
    style.figure.height_cm];
style.figure.windowStyle        = "normal";

%===========================================================
% Tiled layout preferences (optional)
%===========================================================
style.tiled.enabled      = true;
style.tiled.numRows      = 0;              % 0 = auto
style.tiled.numColumns   = 0;              % 0 = auto
style.tiled.TileSpacing  = "compact";      % no waste space between parts [AIAA]
style.tiled.Padding      = "compact";
style.tiled.margins      = [];
style.tiled.aspectRatio  = [];

%===========================================================
% Axes properties
%===========================================================
style.axes.fontName             = 'Times New Roman';
style.axes.fontSize_pt          = 8;      % tick labels; >= 8 pt [AIAA]
style.axes.fontWeight           = 'normal';

style.axes.lineWidth_pt         = 0.5;    % >= 0.28 pt [AIAA]

style.axes.tickDirection        = 'in';
style.axes.tickLength           = [0.015 0.015];  % slightly longer for small axes

style.axes.box                  = 'off';
style.axes.layer                = 'top';

style.axes.xGrid                = 'on';
style.axes.yGrid                = 'on';
style.axes.zGrid                = 'on';
style.axes.gridAlpha            = 0.2;    % screens no lighter than 20% [AIAA]
style.axes.minorGridAlpha       = 0.2;    % (only if your utility applies these)

style.axes.xMinorTick           = 'on';
style.axes.yMinorTick           = 'on';
style.axes.zMinorTick           = 'on';

%===========================================================
% Line and marker properties
%===========================================================
style.line.lineWidth_pt         = 1.0;    % >= 0.28 pt [AIAA]; 1.2 is heavy at this size
style.marker.size_pt            = 4;      % 7 pt markers dominate a 3.25 in panel
style.marker.edgeColorMode      = 'auto';
style.marker.faceColorMode      = 'auto';

%===========================================================
% Text and labels
%===========================================================
style.text.fontName             = style.axes.fontName;
style.text.fontSize_pt          = 8;      % text/annotations default to 10 pt otherwise [AIAA >= 8]
style.text.fontWeight           = 'normal';
style.text.interpreter          = 'latex';

%===========================================================
% Axis labels and title
%===========================================================
style.label.fontSize_pt         = 9;      % [AIAA >= 8]
style.label.fontWeight          = 'normal';

style.title.fontSize_pt         = 9;      % panel titles are replaced by LaTeX subcaptions
style.title.fontWeight          = 'normal';

%===========================================================
% Super title (sgtitle)
%===========================================================
style.supertitle.fontName             = style.axes.fontName;
style.supertitle.fontSize_pt          = 9;  % avoid in journal figures: caption carries the title
style.supertitle.fontWeight           = 'normal';
style.supertitle.interpreter          = 'latex';
style.supertitle.color                = 'black';
style.supertitle.horizontalAlignment  = 'center';

%===========================================================
% Legend
%===========================================================
style.legend.fontSize_pt        = 8;      % set explicitly: MATLAB default is 0.9*axes = 7.2 pt [AIAA >= 8]
style.legend.fontName           = style.axes.fontName;
style.legend.location           = 'best';
style.legend.box                = 'off';

%===========================================================
% Colorbar
%===========================================================
style.colorbar.fontSize_pt      = 8;      % [AIAA >= 8]
style.colorbar.lineWidth_pt     = 0.5;

%===========================================================
% Export settings
%===========================================================
style.export.format             = 'pdf';  % vector PDF accepted for peer review [AIAA]
style.export.dpi                = 600;    % line art raster (PNG/TIFF) [AIAA]
style.export.transparent        = false;

end