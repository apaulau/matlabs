function t071603v
    clc; clear all;
    
    disp('Loading solutions..');
    load('solutions.mat');
    clc;
    
    disp('Visualising solutions..');
    scrsz = get(0, 'ScreenSize');
    
    %% 1. ����������� ������� � ������������ �������

    figure('Position', [50 125 scrsz(3)-250 scrsz(4)-250], 'Name', '1. ����������� ������� � ������������ �������', 'NumberTitle', 'off');

    % ������ ����������� ������� �������
    subplot(1, 2, 1);
    grid on;
    hold on;
        surf(X, T, exact_solution, 'EdgeColor', 'none');
        view(-160, 28)
        title('����������� ������� �������');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
    hold off;

    % ������ ����������� ������������ �������
    subplot(1, 2, 2);
    grid on;
    hold on;
        surf(X, T, numerical_solution, 'EdgeColor', 'none');
        view(-160, 28)
        title('����������� ������������ �������');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,y)');
    hold off;


    %% 2. ����� ������ ������� � ������������ �������

    figure('Position', [75 100 scrsz(3)-250 scrsz(4)-250], 'Name', '2. ����� ������ ������� � ������������ �������', 'NumberTitle', 'off');
    
    % ������ ����� ������ ������� �������
    subplot(1, 2, 1);
    grid on;
    hold on;
        [C, h] = contour(X, T, exact_solution, 10, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ������� �������');
        xlabel('x');
        ylabel('t');
    hold off;

    % ������ ����� ������ ������������ �������
    subplot(1, 2, 2);
    grid on;
    hold on;
        [C, h] = contour(X, T, numerical_solution, 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ������������ �������');
        xlabel('x');
        ylabel('t');
    hold off;


    %% 3. ����� ������ ���������� � ������������� �����������

    figure('Position', [100 75 scrsz(3)-250 scrsz(4)-250], 'Name', '3. ����� ������ ���������� � ������������� �����������', 'NumberTitle', 'off');

    % ������ ����� ������ ���������� �����������
    subplot(1, 2, 1);
    hold on;
        [C, h] = contour(X, T, abs(exact_solution - numerical_solution), 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ���������� �����������');
        xlabel('x');
        ylabel('t');
    hold off;

    % ������ ����� ������ ������������� �����������
    subplot(1, 2, 2);
    hold on;
        [C, h] = contour(X, T, abs((exact_solution - numerical_solution) ./ exact_solution), 8, 'LineWidth', 2);
        clabel(C, h);
        colorbar;
        title('����� ������ ������������� �����������');
        xlabel('x');
        ylabel('t');
    hold off;
    
    clc;
    disp('Visualising: done.');
end