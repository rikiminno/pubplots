function style = fullWidthSquare()
%FULLWIDTHDEFAULT Create default style for full-width publication figures
%that are taller/square
%
%   style = publicationStyle.fullWidthSquare()
%
%   Returns a fully populated style struct suitable for full-page-width
%   figures in scientific publications. All fields have explicit names for
%   easy inspection and modification.

%===========================================================
% Figure properties
%===========================================================
style.figure.units              = 'centimeters';
style.figure.backgroundColor    = 'white';
style.figure.renderer           = 'painters';

% Full-width figure size (typical full-page)
style.figure.width_cm           = 17.0;  % full paper width
style.figure.height_cm          = 15.0;  % proportional height

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
style.tiled.TileSpacing  = "compact";
style.tiled.Padding      = "compact"; % left, right, bottom, top padding
style.tiled.margins      = []; 
style.tiled.aspectRatio  = [];             % optional, can leave empty

%===========================================================
% Axes properties
%===========================================================
style.axes.fontName             = 'Times New Roman';
style.axes.fontSize_pt          = 10;
style.axes.fontWeight           = 'normal';

style.axes.lineWidth_pt         = 0.8;

style.axes.tickDirection        = 'in';
style.axes.tickLength           = [0.01 0.01];

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
style.marker.size_pt            = 7;
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
style.label.fontSize_pt         = 11;
style.label.fontWeight          = 'normal';

style.title.fontSize_pt         = 12;
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
style.legend.fontSize_pt        = 9;
style.legend.fontName           = style.axes.fontName;
style.legend.location           = 'best';
style.legend.box                = 'off';

%===========================================================
% Colorbar
%===========================================================
style.colorbar.fontSize_pt      = 9;
style.colorbar.lineWidth_pt     = 1.0;

%===========================================================
% Export settings
%===========================================================
style.export.format             = 'pdf';
style.export.dpi                = 600;
style.export.transparent        = false;

end
