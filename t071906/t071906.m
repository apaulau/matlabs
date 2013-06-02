%% ������������ ������ �6
% �� ������� [0,1] ������� �������, ����������� �������� 2 � 1 �
% ������������ � �������� �������������� ����� 719 (1011001111), 1->2, 0->1
% ��������� ���������������� ��� ������� ��� ������ ������� ���� �����, ������������ � ��������������:
% � - ��������� ��������
% � - ������� �������

% ������� ����������
clear all;


%% ����� ����������

% ���������� ��������� � ������� ���� �����
N = 20;

% ��������� ����������
xMin = 0;
xMax = 1;
yMin = 1;
yMax = 2;

% ������� ��� ��������� ����������
step = (xMax-xMin)/N;

% ����� ������� ������� ���������, ������� ������ ���� �������������.
% ������� �� ����� ������.
epsilon = 0.0001;

fX = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
fY = [2.0, 1.0, 2.0, 2.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0]; 

% �������, �������� ���� ����������� �����
xLegendre = -1:step:1;
xBessel = 0:step:1;
x = xMin:epsilon:(xMin + max(fX));
f = func719(fX, fY, xMin, yMin, x);    

%% ���������� � ��� ����� � ������� ������� �������
reduceForBessel = @(t)(t*max(fX) + xMin);
fBessel = zeros(1, length(xBessel));
for i = 1:length(xBessel)
    fBessel(i) = approxBessel(@(t) (func719(fX, fY, xMin, yMin, reduceForBessel(t))),...
        xBessel(i), N);
end

%% ���������� � ��� ����� � ������� ������� ��������
reduceForLegendre = @(t) (((t+1)/2)*max(fX) + xMin);
fLegendre = zeros(1,length(xBessel));
for i = 1:length(xLegendre)
    fLegendre(i) = approxLegendre(@(t) (func719(fX, fY, xMin, yMin, reduceForLegendre(t))),...
        xLegendre(i), N);
end

xBessel = reduceForBessel(xBessel);
xLegendre = reduceForLegendre(xLegendre);

%% ������������
%����� 2 ����. �� ������ - ������������� ��������� �������.
%�� ������ - ������������� ���������� ��������.

%��������� ��� ���� ��������, �������� � �������� ������
set(0, 'Units', 'pixels');
scrsz = get(0,'ScreenSize');

%% ������ ���� - ������������� ��������� �������

figure('Name', '������������� ��������� �������', 'Position', [25 125 scrsz(3)-250 scrsz(4)-250]);
graph1 = subplot(1,1,1);
axis([xMin, xMax, min(fBessel), max(fBessel)]);

hold on;

% ���������� �������� ������� � �� �������������
plot(x, f, 'Color', 'green', 'LineWidth', 2);
plot(xBessel, fBessel, 'Color', 'red', 'LineWidth', 2);

% ��������� ������� ���� � ��������� �������
title ('�������� ������� (�������) � �� ������������� ��������� ������� (�������)');
xlabel ('x');
ylabel ('y');

% �� �������
setAllowAxesRotate(rotate3d, graph1, false);

hold off;

%% ������ ���� - ������������� ���������� ��������

figure('Name', '������������� ���������� ��������', 'Position', [50 100 scrsz(3)-250 scrsz(4)-250]);
graph2 = subplot(1,1,1);
axis([xMin, xMax, min(fLegendre), max(fLegendre)]);

hold on;

% ���������� �������� ������� � �� �������������
plot(x, f, 'Color', 'green', 'LineWidth', 2);
plot(xLegendre, fLegendre, 'Color', 'red', 'LineWidth', 2);

% ��������� ������� ���� � ��������� �������
title ('�������� ������� (�������) � �� ������������� ���������� �������� (�������)');
xlabel ('x');
ylabel ('y');

% �� �������
setAllowAxesRotate(rotate3d, graph2, false);

hold off;
