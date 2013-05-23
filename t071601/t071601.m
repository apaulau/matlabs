%% ������� 01. ����� ������������� ������� ������ ����
% �������� ���������: Uxx + 4Uxy - 5Uyy - 3Ux + 3Uy = 3y + 3x
% ��������� �������: U|(y-2x=0) = 2 + 6x^2 + 4x
%                   Uy|(y-2x=0) = 5x + 2

function t071601

%% ��������� �������������

x_min = -1;
x_max = 1;
y_min = -1;
y_max = 1;
x_h = (x_max - x_min) / 30; 
y_h = (y_max - y_min) / 30; 

[X,Y] = meshgrid(x_min:x_h:x_max, y_min:y_h:y_max);

scrsz = get(0,'ScreenSize');
figure('Position', [50 scrsz(4)/2-100 scrsz(3)-100 scrsz(4)/2], 'Name', '������������ ������ 01', 'NumberTitle', 'off');

%% 1. ������ ��������� ������������� ��������� � �����, �� ������� ��������� �������.

subplot(1,3,1);
hold on;    
    Z = X + Y;
    contour(X, Y, Z, '-.', 'Color', 'b');
    Z = 5*X - Y;
    contour(X, Y, Z, '-.', 'Color', 'b');
    Z = 2*Y;
    plot(Z, Y, 'LineWidth', 3);
    title('\bf ������� ����������� � �������������� �������');
    xlabel('\it X');
    ylabel('\it Y');
hold off;


%% 2. ������ ����� ������ ������� ������ ����

Z = X.*Y + Y.^2 + 2*Y + 2;
subplot(1, 3, 2);
hold on;
    [C, h] = contour(X, Y, Z, 8, 'LineWidth', 2);
    clabel(C, h, 'Rotation', 0, 'BackgroundColor', [1 1 .6], 'Edgecolor', [.7 .7 .7]); 
    colorbar;
    title('\bf ����� ������ �������');
    xlabel('\it X');
    ylabel('\it Y');
    zlabel('\it U');
hold off;


%% 3. ������ ����������� ������� ������ ����

graph3d = subplot(1, 3, 3);
surf(X, Y, Z, 'EdgeColor', 'none') 
hold on;
    title('\bf ����������� �������');
    xlabel('\it X');
    ylabel('\it Y');
    zlabel('\it U');
hold off;
rotate3d(graph3d);