function style = twoColumnSubfigure()
%TWOCOLUMNSUBFIGURE Create default style for figures intended to be used
%inside a two-column subfigure environment.
%
%   style = publicationStyle.twoColumnSubfigure()
%
%   Returns a fully populated style struct suitable for one panel of a
%   figure composed of two side-by-side subfigures.

%===========================================================
% Figure properties
%===========================================================
style.figure.units              = 'centimeters';
style.figure.backgroundColor    = 'white';
style.figure.renderer           = 'painters';

% Half-page width with a small gap between subfigures
style.figure.width_cm           = 10;
style.figure.height_cm          = 6.5;

style.figure.position_cm        = [0 0 ...
    style.figure.width_cm ...
    style.figure.height_cm];

style.figure.windowStyle        = "normal";

%===========================================================
% Tiled layout preferences
%===========================================================
style.tiled.enabled      = true;
style.tiled.numRows      = 0;
style.tiled.numColumns   = 0;
style.tiled.TileSpacing  = "compact";
style.tiled.Padding      = "compact";
style.tiled.margins      = [];
style.tiled.aspectRatio  = [];

%===========================================================
% Axes properties
%===========================================================
style.axes.fontName             = 'Times New Roman';
style.axes.fontSize_pt          = 8;
style.axes.fontWeight           = 'normal';

style.axes.lineWidth_pt         = 0.8;

style.axes.tickDirection        = 'in';
style.axes.tickLength           = [0.012 0.012];

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
style.line.lineWidth_pt         = 1.1;

style.marker.size_pt            = 6;
style.marker.edgeColorMode      = 'auto';
style.marker.faceColorMode      = 'auto';

%===========================================================
% Text properties
%===========================================================
style.text.fontName             = style.axes.fontName;
style.text.fontSize_pt          = style.axes.fontSize_pt;
style.text.fontWeight           = 'normal';
style.text.interpreter          = 'latex';

%===========================================================
% Axis labels and title
%===========================================================
style.label.fontSize_pt         = 9;
style.label.fontWeight          = 'normal';

style.title.fontSize_pt         = 10;
style.title.fontWeight          = 'bold';

%===========================================================
% Super title (normally unused for subfigures)
%===========================================================
style.supertitle.fontName             = style.axes.fontName;
style.supertitle.fontSize_pt          = 11;
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
style.colorbar.lineWidth_pt     = 0.8;

%===========================================================
% Export settings
%===========================================================
style.export.format             = 'pdf';
style.export.dpi                = 600;
style.export.transparent        = false;

end