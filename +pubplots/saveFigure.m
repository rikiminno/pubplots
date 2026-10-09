function saveFigure(fig, filename, tightCrop)
%SAVEFIGURE Save figure in .fig, .pdf, and .png formats
%
%   saveFigure(fig, filename)
%   saveFigure(fig, filename, tightCrop)
%
%   Ensures that the exported PDF matches the actual figure size.

    arguments
        fig matlab.ui.Figure
        filename (1,:) char
        tightCrop (1,1) logical = true
    end

    %--------------------------------------------------
    % Ensure white background
    %--------------------------------------------------
    set(fig, 'Color', 'w');

    %--------------------------------------------------
    % Ensure correct export sizing
    %--------------------------------------------------
    set(fig, 'PaperPositionMode', 'auto');

    % Force figure to use physical units (important!)
    originalUnits = fig.Units;
    fig.Units = 'centimeters';
    pos = fig.Position; %#ok<NASGU> % ensures MATLAB locks size

    %--------------------------------------------------
    % Parse path
    %--------------------------------------------------
    [folder, name, ~] = fileparts(filename);

    if isempty(name)
        error('Filename must include a valid file name.');
    end

    if isempty(folder)
        folder = pwd;
    end

    if ~exist(folder, 'dir')
        mkdir(folder);
    end

    fullpath = fullfile(folder, name);

    %--------------------------------------------------
    % Save .fig
    %--------------------------------------------------
    savefig(fig, [fullpath '.fig']);

    %--------------------------------------------------
    % Export options
    %--------------------------------------------------
    exportOptsPDF = {'ContentType','vector','BackgroundColor','white'};
    exportOptsPNG = {'Resolution',300,'BackgroundColor','white'};

    if tightCrop
        exportOptsPDF = [exportOptsPDF, {'Bounds','tight'}];
        exportOptsPNG = [exportOptsPNG, {'Bounds','tight'}];
    end

    %--------------------------------------------------
    % Save PDF (correct size!)
    %--------------------------------------------------
    try
        exportgraphics(fig, [fullpath '.pdf'], exportOptsPDF{:});
    catch
        % fallback (force correct size manually)
        set(fig, 'PaperUnits', 'centimeters');
        set(fig, 'PaperSize', fig.Position(3:4));
        set(fig, 'PaperPosition', [0 0 fig.Position(3:4)]);
        print(fig, [fullpath '.pdf'], '-dpdf', '-painters');
    end

    %--------------------------------------------------
    % Save PNG
    %--------------------------------------------------
    try
        exportgraphics(fig, [fullpath '.png'], exportOptsPNG{:});
    catch
        print(fig, [fullpath '.png'], '-dpng', '-r300');
    end

    %--------------------------------------------------
    % Restore original units
    %--------------------------------------------------
    fig.Units = originalUnits;

    %--------------------------------------------------
    % Feedback
    %--------------------------------------------------
    fprintf('Figure saved to:\n');
    fprintf('  %s.fig\n', fullpath);
    fprintf('  %s.pdf\n', fullpath);
    fprintf('  %s.png\n', fullpath);

end