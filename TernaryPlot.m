function TernaryPlot(X0, Y0, Z0, varargin)
%% Syntax
% TernaryPlot(X, Y, Z)
% TernaryPlot(X, Y, Z, PlotType)
% TernaryPlot(__, Name, Value)
%% Description
% TernaryPlot(X, Y, Z) creates a 3-D ternary surf with A+B+C=1 
% TernaryPlot(X, Y, Z, PlotType) creates ternary plot with type defined by
%                                PlotType
% TernaryPlot(__, Name, Value) specifies the ternary axies properties using
%                              one or more Name, Value pair arguments
%% Input Arguments
% X0, Y0, Z0: The data need to be drawn
%             They should be same in size, 1D or 2D
%             X0, Y0 [0, 1], Z0 no limit
% PlotType: surf or s - for surface
%           contour or c - for countour
%           contourl or c+l - for contour + label
%           contourf or c+f - for contour with color
%           contourfl or c+f+l - for contour with color with label
% Others Name, Value pair arguments
%   Grid: on or off(default)
%   Tick: on(default) | off
%   Label: {'A', 'B', 'C'}(default)
%   LabelPos: 'center'(default) | corner
%   Caxis: [cmin, cmax]
%% Author Information
% Author: Liao Mingqing
% E-mail: liaomq1900127@163.com
% GitHub: https://github.com/hitliaomq/TernaryPlot
% Cite: Mingqing Liao. (2018, December 6). hitliaomq/TernaryPlot. Zenodo.
%       DOI:http://doi.org/10.5281/zenodo.1998782 
% Acknowledge: The following is a reference. https://github.com/alchemyst/ternplot

%% For test
% X0 = 0:0.1:1;
% Y0 = 0:0.1:1;
% [X0, Y0] = meshgrid(X0, Y0);
% Z0 = X0.^2 + Y0.^2;
% N = 100;
% Grid = 'off';
% Label = {'Nb', 'Ti', 'V'};
% PlotType = 'surf';

% default values of input
N = 100;
Grid = 'off';
Box = 'off';
Label = {'A', 'B', 'C'};
PlotType = 's';
Tick = 'on';
LabelPos = 'center';

if nargin < 3
    error('ERROR: The input is not enough. At least 3 verctors.');
elseif nargin == 4
    PlotType = varargin{1};
elseif nargin > 4
    if ismember(varargin{1}, {'surf', 'contour', 'contourf', 'contourl',...
            'contourfl', 's', 'c', 'c+l', 'c+f', 'c+f+l'})
        PlotType = varargin{1};
        i_start = 2;
    else
        i_start = 1;
    end
    n_in = nargin - 2 - i_start;
    if mod(n_in, 2)
        error('ERROR: The input dismatch.');
    end
    flag = 0;
    for i = i_start:(nargin - 3)
        if flag
            flag = 0;
            continue
        else
            varin = varargin{i};
            if strcmpi(varin, 'label')
                Label = varargin{i + 1};
            elseif strcmpi(varin, 'box')
                Box = varargin{i + 1};
            elseif strcmpi(varin, 'grid')
                Grid = varargin{i + 1};
            elseif strcmpi(varin, 'caxis')
                Caxis = varargin{i + 1};
            elseif strcmpi(varin, 'tick')
                Tick = varargin{i + 1};
            elseif strcmpi(varin, 'labelpos')
                LabelPos = varargin{i + 1};
            end
            flag = 1;
        end
        
    end
end

if ismember(PlotType, {'contour', 'contourf', 'contourl',...
        'contourfl', 'c', 'c+l', 'c+f', 'c+f+l'})
    if strcmpi(Box, 'on')
        Box = 'off';
        warning('The Box parameter is set as off.');
    end
end

maxX = max(max(X0));
minX = min(min(X0));
maxY = max(max(Y0));
minY = min(min(Y0));

XLim = [min([minX, minY]), max([maxX, maxY])];
Xi = linspace(maxX, minX, N);
Yi = linspace(minY, maxY, N);
% Z = Xi + Yi;
[Xi, Yi] = meshgrid(Xi, Yi);
Tri = delaunay(Xi, Yi);
% Tri = GetTri(N);

TZi = griddata(X0, Y0, Z0, Xi, Yi, 'v4');
for i = 1:N
    for j = (i+1):N
        TZi(j, i) = nan;
    end
end
[TXi, TYi] = XY2Ter(Xi, Yi);
% Tri = GetTri(N);
TZi_noNan = TZi;
TZi_noNan(isnan(TZi_noNan)) = [];
TZi_norm = (TZi - min(TZi_noNan))/(max(TZi_noNan) - min(TZi_noNan));
TernaryAxes(XLim, Grid, Box, Label, LabelPos, Tick)
hold on
if strcmpi(PlotType, 'surf') || strcmp(PlotType,  's')
    trisurf(Tri, TXi, TYi, TZi_norm, TZi, 'EdgeColor', 'interp');
    shading interp
    colorbar;
    view([0, 0, 1]);
elseif strcmpi(PlotType, 'contour') || strcmp(PlotType, 'c')
    contour(TXi, TYi, TZi, 'k');
elseif strcmpi(PlotType, 'contourl') || strcmpi(PlotType, 'c+l')
    contour(TXi, TYi, TZi, 'k', 'ShowText', 'on');
elseif strcmpi(PlotType, 'contourf') || strcmpi(PlotType, 'c+f')
    contourf(TXi, TYi, TZi); %, 'ShowText', 'on');
    colorbar;
elseif strcmpi(PlotType, 'contourfl') || strcmpi(PlotType, 'c+f+l')
    contourf(TXi, TYi, TZi, 'ShowText', 'on');
    colorbar;
    % colormapeditor;
end

axis equal
colormap('jet');
if ~exist('Caxis', 'var')
    cmin = min(min(Z0));
    cmax = max(max(Z0));
else
    cmin = Caxis(1);
    cmax = Caxis(2);
end
caxis([cmin, cmax]);
[minTX, minTY] = XY2Ter(minX, minY);
[maxTX, ~] = XY2Ter(maxX, minY);
[~, maxTY] = XY2Ter(minX, maxY);
dTX = maxTX - minTX; dTY = maxTY - minTY;
kLim = 0.01;
TXLim = [minTX - kLim*dTX, maxTX + kLim*dTX];
TYLim = [minTY - kLim*dTY, maxTY + kLim*dTY];
set(gca, 'XLim', TXLim, 'YLim', TYLim);

end

