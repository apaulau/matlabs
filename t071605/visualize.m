function visualize(X, Y, x_min, x_max, y_min, y_max, area_x, area_y, exact_solution, pdetool_solution)
    scrsz = get(0, 'ScreenSize');

    %% 1. ����������� ������� � ������������ �������

    figure('Position', [50 125 scrsz(3)-250 scrsz(4)-250], 'Name', '1. ����������� ������� � ������������ �������', 'NumberTitle', 'off');

    % ������ ����������� ������� �������
    subplot(1, 2, 1);
    grid on;
    hold on;
        surf(X, Y, exact_solution, 'EdgeColor', 'none');
        set(gca, 'CameraPosition', [0, 0, 60]);
        title('����������� ������� �������');
        xlabel('x');
        ylabel('t');
        zlabel('u(x,t)');
    hold off;

    % ������ ����������� ������������ �������
    subplot(1, 2, 2);
    grid on;
    hold on;
        surf(X, Y, pdetool_solution, 'EdgeColor', 'none');
        set(gca, 'CameraPosition', [0, 0, 60]);
        title('����������� ������������ �������');
        xlabel('x');
        ylabel('y');
        zlabel('u(x,y)');
    hold off;


    %% 2. ����� ������ ������� � ������������ �������

    figure('Position', [75 100 scrsz(3)-250 scrsz(4)-250], 'Name', '2. ����� ������ ������� � ������������ �������', 'NumberTitle', 'off');
    
    % ������ ����� ������ ������� �������
    subplot(1, 2, 1);
    grid on;
    hold on;
        axis([x_min - 0.2 x_max + 0.2 y_min - 0.2 y_max + 0.2]);
        [C, h] = contour(X, Y, exact_solution, 10, 'LineWidth', 2);
        plot(area_x, area_y, 'color', 'k');
        clabel(C, h);
        colorbar;
        title('����� ������ ������� �������');
        xlabel('x');
        ylabel('y');
    hold off;

    % ������ ����� ������ ������������ �������
    subplot(1, 2, 2);
    grid on;
    hold on;
        axis([x_min - 0.2 x_max + 0.2 y_min - 0.2 y_max + 0.2]);
        [C, h] = contour(X, Y, pdetool_solution, 8, 'LineWidth', 2);
        plot(area_x, area_y, 'color', 'k');
        clabel(C, h);
        colorbar;
        title('����� ������ ������������ �������');
        xlabel('x');
        ylabel('y');
    hold off;


    %% 3. ����� ������ ���������� � ������������� �����������

    figure('Position', [100 75 scrsz(3)-250 scrsz(4)-250], 'Name', '3. ����� ������ ���������� � ������������� �����������', 'NumberTitle', 'off');

    % ������ ����� ������ ���������� �����������
    subplot(1, 2, 1);
    hold on;
        axis([x_min - 0.1 x_max + 0.1 y_min - 0.1 y_max + 0.1]);
        [C, h] = contour(X, Y, abs(exact_solution - pdetool_solution), 8, 'LineWidth', 2);
        plot(area_x, area_y, 'color', 'k');
        clabel(C, h);
        colorbar;
        title('����� ������ ���������� �����������');
        xlabel('x');
        ylabel('y');
    hold off;

    % ������ ����� ������ ������������� �����������
    subplot(1, 2, 2);
    hold on;
        axis([x_min - 0.1 x_max + 0.1 y_min - 0.1 y_max + 0.1]);
        [C, h] = contour(X, Y, abs((exact_solution - pdetool_solution) ./ exact_solution), 8, 'LineWidth', 2);
        plot(area_x, area_y, 'color', 'k');
        clabel(C, h);
        colorbar;
        title('����� ������ ������������� �����������');
        xlabel('x');
        ylabel('y');
    hold off;
end