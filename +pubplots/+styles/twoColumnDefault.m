function style = twoColumnDefault()
%TWOCOLUMNDEFAULT Create double-column default publication figure style
%
%   style = publicationStyle.twoColumnDefault()
%
%   This function returns a fully populated style struct intended for
%   scientific publication figures on double-columns journals. The struct
%   is organized by graphics object type and uses explicit, human-readable
%   field names.

%===========================================================
% Figure properties
%===========================================================
style.figure.units              = 'centimeters';
style.figure.backgroundColor    = 'white';
style.figure.renderer           = 'painters';

% Single-column figure size (typical journal default)
style.figure.width_cm           = 8.6;
style.figure.height_cm          = 6.5;

% Position vector convenience (derived)
style.figure.position_cm        = [0 0 ...
    style.figure.width_cm ...
    style.figure.height_cm];
style.figure.windowStyle        = "normal";

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
style.axes.fontName             = 'Times New Roman';
style.axes.fontSize_pt          = 9;
style.axes.fontWeight           = 'normal';

style.axes.lineWidth_pt         = 0.75;

style.axes.tickDirection        = 'in';
style.axes.tickLength           = [0.015 0.015];

style.axes.box                  = 'off';
style.axes.layer                = 'top';

style.axes.xGrid                = 'on';
style.axes.yGrid                = 'on';
style.axes.zGrid                = 'on';

style.axes.xMinorTick           = 'on';
style.axes.yMinorTick           = 'on';
style.axes.zMinorTick           = 'on';

%===========================================================
% Line and marker properties
%===========================================================
style.line.lineWidth_pt         = 1.2;

style.marker.size_pt            = 6;
style.marker.edgeColorMode      = 'auto';
style.marker.faceColorMode      = 'auto';

%===========================================================
% Text and labels
%===========================================================
style.text.fontName             = style.axes.fontName;
style.text.fontSize_pt          = style.axes.fontSize_pt;
style.text.fontWeight           = 'normal';
style.text.interpreter          = 'latex';

%===========================================================
% Axis labels and title
%===========================================================
style.label.fontSize_pt         = 10;
style.label.fontWeight          = 'normal';

style.title.fontSize_pt         = 10;
style.title.fontWeight          = 'normal';

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
style.legend.fontSize_pt        = 8;
style.legend.fontName           = style.axes.fontName;
style.legend.location           = 'best';
style.legend.box                = 'off';

%===========================================================
% Colorbar
%===========================================================
style.colorbar.fontSize_pt      = 8;
style.colorbar.lineWidth_pt     = 0.75;

%===========================================================
% Export settings
%===========================================================
style.export.format             = 'pdf';
style.export.dpi                = 600;
style.export.transparent        = false;

end

