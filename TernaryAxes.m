function TernaryAxes(XLim, Grid, Box, Label, LabelPos, Tick, TickType, NOrS)
% varargin  XLim, Grid, Label, varargin
close all
h = axes;
xmin = XLim(1);
xmax = XLim(2);
set(h, 'visible', 'off');
if ~exist('TickType', 'var')
    TickType = 'Step';  % Number(N) or Step(S)
    NOrS = 0.1;
end
if strcmpi(TickType, 'Number') || strcmpi(TickType, 'N')
    n = NOrS;
elseif strcmpi(TickType, 'Step') || strcmpi(TickType, 'S')
    n = round((xmax - xmin)/NOrS) + 1;
end
PlotTriAngle(xmin, xmax, h);
hold on
if strcmpi(Tick, 'on')
    AddTick(xmin, xmax, n, h);
    k = 0.08;
else
    k = 0.03;
end
% Grid = Grid;
if strcmpi(Grid, 'on')
    PlotGrid(xmin, xmax, n);
end
if strcmpi(Box, 'on')
    AddBox(xmin, xmax, h)
end
if nargin == 2
    Label = {'A', 'B', 'C'};
end
AddLabel(xmin, xmax, Label, LabelPos, k, h);
% load('TEST.mat');
% [TerX, TerY] = XY2Ter(X, Y);
% scatter(TerX, TerY)
end

function PlotTriAngle(xmin, xmax, varargin)
if nargin == 3
    h = varargin{1};
else
    h = gca;
end
v = [xmin, xmin; xmax, xmin; xmin, xmax];
[v(:, 1), v(:, 2)] = XY2Ter(v(:, 1), v(:, 2));
c = [0 0 1; % blue
    1 0 0; % red
    0 1 0]; % gree
patch(h, 'Faces',[1, 2, 3],'Vertices',v,'FaceVertexCData',c,...
    'EdgeColor','flat','FaceColor','w','LineWidth',2);
axis equal
end

function PlotGrid(xmin, xmax, n, varargin)
if nargin == 4
    h = varargin{1};
else
    h = gca;
end
[GridX, GridY] = GetGridXY(xmin, xmax, n);
[GridX, GridY] = XY2Ter(GridX, GridY);
GridX(4, :) = GridX(1, :);
GridY(4, :) = GridY(1, :);
index2 = n:-1:1;
C = {'r', 'g', 'b'};
for i = 1:3
    for j = 2:n-1
        line(h, [GridX(i, j), GridX(i+1, index2(j))], ...
            [GridY(i, j), GridY(i+1, index2(j))], 'Color', C{i});
    end
end
end

function AddTick(xmin, xmax, n, varargin)
delta = (xmax - xmin);
if nargin == 4
    h = varargin{1};
else
    h = gca;
end
[GridX, GridY] = GetGridXY(xmin, xmax, n);
[GridX, GridY] = XY2Ter(GridX, GridY);
Txt = linspace(xmin, xmax, n);
n_row = size(GridX, 1);
Ang = [0, -60, 60];
C = {'r', 'g', 'b'};
k = 0.03;
deltax = [0, k*sin(pi/3)*delta, -k*sin(pi/3)*delta];
deltay = [-k*delta, k*cos(pi/3)*delta, k*cos(pi/3)*delta];
for i = 1:n_row
%     text(h, GridX(i, :), GridY(i, :), {Txt}, 'Color', cell2mat(C(i)));
    for j = 1:n
        x = GridX(i, j);
        y = GridY(i, j);
        text(h, x + deltax(i), y + deltay(i), num2str(Txt(j)), ...
            'FontSize', 12,...
            'Color', C{i}, 'Rotation', Ang(i), 'HorizontalAlignment', 'center');
    end
end
end

function AddLabel(xmin, xmax, Label, LabelPos, k, varargin)
if nargin == 4
    h = varargin{1};
else
    h = gca;
end
delta = (xmax - xmin);
% k = 0.08;
if strcmpi(LabelPos, 'center')
    x = [(xmin + xmax)/2, (xmin + xmax)/2, xmin];
    y = [xmin, (xmin + xmax)/2, (xmin + xmax)/2];
    deltax = [0, k*sin(pi/3)*delta, -k*sin(pi/3)*delta];
    deltay = [-k*delta, k*cos(pi/3)*delta, k*cos(pi/3)*delta];
    Ang = [0, -60, 60];
elseif strcmpi(LabelPos, 'corner')
    x = [xmin, xmax, xmin];
    y = [xmin, xmin, xmax];
    deltax = [-k*sin(pi/3)*delta ,  k*sin(pi/3)*delta, 0];
    deltay = [-k*cos(pi/3)*delta, -k*cos(pi/3)*delta, k*delta];
    Ang = [0, 0, 0];
end
[x, y] = XY2Ter(x, y);

C = {'r', 'g', 'b'};
for i = 1:3
    text(h, x(i) + deltax(i), y(i) + deltay(i), Label{i}, ...
            'FontSize', 12,...
            'Color', C{i}, 'Rotation', Ang(i), 'HorizontalAlignment', 'center');
end
end

function AddBox(xmin, xmax, varargin)
if nargin == 3
    h = varargin{1};
else
    h = gca;
end
v = [xmin, xmin; xmax, xmin; xmin, xmax];
[v(:, 1), v(:, 2)] = XY2Ter(v(:, 1), v(:, 2));
v(1:3, 3) = 1;
c = [0 0 1; % blue
    1 0 0; % red
    0 1 0]; % gree
patch(h, 'Faces',[1, 2, 3],'Vertices',v,'FaceVertexCData',c,...
    'EdgeColor','flat','FaceColor','none','LineWidth',1.5);
hold on
for i = 1:3
    line([v(i, 1), v(i, 1)], [v(i, 2), v(i, 2)], [0, 1],...
        'Color', c(i, :), 'LineWidth',1.5)
end
% axis equal
end

function [GridX, GridY] = GetGridXY(xmin, xmax, n)
x = [xmin, xmax, xmin, xmin];
y = [xmin, xmin, xmax, xmin];
n_x = length(x);
% n = round(n);
GridX = zeros(3, n);
GridY = zeros(3, n);
for i = 1:n_x - 1
    GridX(i, :) = linspace(x(i), x(i+1), n);
    GridY(i, :) = linspace(y(i), y(i+1), n);
end
end