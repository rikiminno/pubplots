function style = fullScreen()
%FULLSCREEN Create a style for normal fullscreen visualization
%
%   style = publicationStyle.fullscreen()
%
%   This style is intended for interactive use (exploration, debugging,
%   presentations) rather than publication. The figure is maximized to
%   fullscreen and uses larger fonts and line widths for readability.

%===========================================================
% Figure properties
%===========================================================
style.figure.units              = 'normalized';
style.figure.backgroundColor    = 'white';
style.figure.renderer           = 'opengl';

% Fullscreen figure
style.figure.position_cm        = [0 0 1 1];
style.figure.windowStyle        = "docked";

%===========================================================
% Tiled layout preferences (optional)
%===========================================================
style.tiled.enabled             = true;       % Whether to apply tiledlayout formatting
style.tiled.numRows             = 0;          % 0 = auto-compute based on number of axes
style.tiled.numColumns          = 2;          % 0 = auto-compute
style.tiled.TileSpacing         = 'compact';  % 'compact', 'loose', or [x y]
style.tiled.Padding             = 'compact';  % 'compact', 'loose', or [left right bottom top]
style.tiled.margins             = []; % outer margins [left right bottom top]
style.tiled.aspectRatio         = [];         % optional aspect ratio hint (width/height)

%===========================================================
% Axes properties
%===========================================================
style.axes.fontName             = 'Helvetica';
style.axes.fontSize_pt          = 12;
style.axes.fontWeight           = 'normal';

style.axes.lineWidth_pt         = 1.0;

style.axes.tickDirection        = 'out';
style.axes.tickLength           = [0.02 0.02];

style.axes.box                  = 'off';
style.axes.layer                = 'top';

style.axes.xGrid                = 'on';
style.axes.yGrid                = 'on';
style.axes.zGrid                = 'on';

style.axes.xMinorTick           = 'off';
style.axes.yMinorTick           = 'off';
style.axes.zMinorTick           = 'off';

%===========================================================
% Line and marker properties
%===========================================================
style.line.lineWidth_pt         = 2.0;
style.marker.size_pt            = 8;
style.marker.edgeColorMode      = 'auto';
style.marker.faceColorMode      = 'auto';

%===========================================================
% Text and labels
%===========================================================
style.text.fontName             = style.axes.fontName;
style.text.fontSize_pt          = style.axes.fontSize_pt;
style.text.fontWeight           = 'normal';
style.text.interpreter          = 'latex';  % faster, cleaner for exploration

%===========================================================
% Axis labels and title
%===========================================================
style.label.fontSize_pt         = 14;
style.label.fontWeight          = 'normal';

style.title.fontSize_pt         = 16;
style.title.fontWeight          = 'bold';

%===========================================================
% Super title (sgtitle)
%===========================================================
style.supertitle.fontName             = style.axes.fontName;
style.supertitle.fontSize_pt          = style.title.fontSize_pt + 2;
style.supertitle.fontWeight           = 'bold';
style.supertitle.interpreter          = 'latex';
style.supertitle.color                = 'black';
style.supertitle.horizontalAlignment  = 'center';

%===========================================================
% Legend
%===========================================================
style.legend.fontSize_pt        = 11;
style.legend.fontName           = style.axes.fontName;
style.legend.location           = 'best';
style.legend.box                = 'off';

%===========================================================
% Colorbar
%===========================================================
style.colorbar.fontSize_pt      = 11;
style.colorbar.lineWidth_pt     = 1.0;

%===========================================================
% Export settings (not primary use case)
%===========================================================
style.export.format             = 'png';
style.export.dpi                = 150;
style.export.transparent        = false;

end
