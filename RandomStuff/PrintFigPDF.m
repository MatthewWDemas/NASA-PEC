function  PrintFigPDF( fig_name, file_name )
%PrintFigPDF Takes in a figure handle and filename and prints a PDF of the
%figure to that location.
%   I was duplicating this section of code too often, so I bundled it into
%   a function.
    fig = fig_name;
    fig.PaperUnits = 'inches';
    fig.PaperSize = [22 17];
    fig.PaperPosition = [0 0 22 17];
    fig.PaperPositionMode = 'manual';
    %fig.PaperOrientation = 'landscape';
    print(fig, file_name,...
        '-dpdf', '-r600')
end

