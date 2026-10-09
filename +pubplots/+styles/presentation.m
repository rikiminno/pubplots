function style = presentation()
%FULLWIDTHDEFAULT Create default style for presentation figures
%
%   style = publicationStyle.presentation()
%
%   Returns a fully populated style struct suitable for presentation
%   figures in scientific talks. All fields have explicit names for easy
%   inspection and modification.

%===========================================================
% Figure properties
%===========================================================
style.figure.units              = 'pixels';
style.figure.backgroundColor    = 'white';
style.figure.renderer           = 'painters';

% Full-width and height figure size
style.figure.width_px           = 1920;  % full paper width
style.figure.height_px          = 1080;  % proportional height
style.figure.windowStyle        = "normal";

% Position vector convenience (derived)
style.figure.position_cm        = [50 50 ...
    style.figure.width_px ...
    style.figure.height_px];

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
style.axes.fontSize_pt          = 20;
style.axes.fontWeight           = 'normal';

style.axes.lineWidth_pt         = 1.2;

style.axes.tickDirection        = 'out';
style.axes.tickLength           = [0.02 0.02];

style.axes.box                  = 'on';
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
style.line.lineWidth_pt         = 3;
style.marker.size_pt            = 10;
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
style.label.fontSize_pt         = 22;
style.label.fontWeight          = 'normal';

style.title.fontSize_pt         = 28;
style.title.fontWeight          = 'bold';

%===========================================================
% Super title (sgtitle)
%===========================================================
style.supertitle.fontName             = style.axes.fontName;
style.supertitle.fontSize_pt          = 36;
style.supertitle.fontWeight           = 'bold';
style.supertitle.interpreter          = 'latex';
style.supertitle.color                = 'black';
style.supertitle.horizontalAlignment  = 'center';

%===========================================================
% Legend
%===========================================================
style.legend.fontSize_pt        = 20;
style.legend.fontName           = style.axes.fontName;
style.legend.location           = 'best';
style.legend.box                = 'off';

%===========================================================
% Colorbar
%===========================================================
style.colorbar.fontSize_pt      = 20;
style.colorbar.lineWidth_pt     = 1.2;

%===========================================================
% Export settings
%===========================================================
style.export.format             = 'pdf';
style.export.dpi                = 600;
style.export.transparent        = false;

end
