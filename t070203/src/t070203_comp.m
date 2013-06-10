function [] = t070203_comp

%%% Задача %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    u    = @(x, t) -sin(2*x - 3) .* cos(2*t + 3) .* exp(-3*t.^2 -1);
    u_t  = @(x, t) -6*exp(-3*t.^2 - 1) .* t .* cos(3 + 2*t) .* sin(3 - 2*x) - 2*exp(-3*t.^2 -1).*sin(3 + 2*t).*sin(3-2*x);
    u_x  = @(x, t) -2 * cos(2*x - 3) .* cos(2*t + 3) .* exp(-3*t.^2 -1);
    u_xx = @(x, t)  -4 * sin(3-2*x) .* cos(2*t + 3) .* exp(-3*t.^2 -1);
    u_xt = @(x, t)  12 * exp(-1-3*t.^2).* t .* cos(3+2*t)*cos(3 - 2*x) + 4*exp(-3*t.^2 - 1).*cos(3-2*x).*sin(3+2*t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    f    = @(x, t) u_t (x, t) - 9 * u_xx(x, t);
    mu   = @(t)    u_x (0, t);
    nu   = @(t)    u_x (1, t);
    mu_t = @(t)    u_xt(0, t);
    nu_t = @(t)    u_xt(1, t);
    phi  = @(x)    u   (x, 0);

%%% Приводим к однородным граничным условиям %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    w    = @(x, t) (x - x.^2 / 2) .* mu(t) + x.^2 / 2 * nu(t);
    w_t  = @(x, t) (x - x.^2 / 2) .* mu_t(t) + x.^2 / 2 * nu_t(t);
    w_xx = @(x, t) -mu(t) + nu(t);

    g    = @(x, t) f(x, t) + 9 * w_xx(x, t) - w_t(x, t);
    v    = @(x, t) u(x, t) - w(x, t);

%%% Решение задачи Штурма-Лиувилля %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    lambda = @(k) (k ~= 0) * (pi * k).^2;
    lambdasqrt = @(k) pi * k;
    Xkf = @(k, x) (k == 0) + (k ~= 0) * cos(lambdasqrt(k)*x);
    XK_NORM_SQ = @(k)(k == 0) + (k ~= 0) * 0.5;

%%% Создадим сетку %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    T_MIN = 0;
    T_MAX = 0.5;

    X_MIN = 0;
    X_MAX = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    K = 5;
    T = T_MIN:0.01:T_MAX;
    X = X_MIN:0.01:X_MAX;

%%% Препроцессинг %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    TRAPZ_STEP = 0.00001;
    TRAPZ_GRID_X = X_MIN:TRAPZ_STEP:X_MAX;
    XK_TRAPZ = zeros(K, length(TRAPZ_GRID_X));
    VTZERO = v(TRAPZ_GRID_X, 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    UA = zeros(length(T), length(X));
    XK = zeros(K+1, length(X));
    TK = zeros(length(T), K+1);
    UN = zeros(length(T), length(X));

    ABS_ERR = zeros(length(T), length(X));
    REL_ERR = zeros(length(T), length(X));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for k = 0:K
        XK_TRAPZ(k+1, :) = Xkf(k, TRAPZ_GRID_X);
        XK(k+1, :) = Xkf(k, X);
    end

%%% Решение задачи Коши %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    xik = @(k) trapz(TRAPZ_GRID_X, VTZERO .* XK_TRAPZ(k+1, :)) / XK_NORM_SQ(k);

    function [ y ] = gk(k, t)
        y = zeros(length(t));
        for n = 1:length(t)
            y(n) = trapz(TRAPZ_GRID_X, g(TRAPZ_GRID_X, t(n)) .* XK_TRAPZ(k+1, :)) / XK_NORM_SQ(k);
        end
    end

    function [ y ] = Tkf(k, t)
        options = odeset('RelTol', 1e-10);
        [odet Tk ] = ode45(@(u, v)  -9*lambda(k)*v(1) + gk(k, u), [ T_MIN T_MAX ], [ xik(k) ], options);
        y = interp1(odet, Tk, t, 'spline');
    end

%%% Считаем Tk и само решение %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for k = 0:K
        TK(:, k+1) = Tkf(k, T);
    end

    V = TK * XK;

    for i = 1:length(T)
        for j = 1:length(X)
            if (T(i) == 0)
                UN(i, j) = phi(X(j));
            else
                UN(i, j) = (w(X(j), T(i)) + V(i, j)) ;
            end
            UA(i, j) = u(X(j), T(i));

            ABS_ERR(i, j) = abs(UN(i, j) - UA(i, j));
            REL_ERR(i, j) = abs(ABS_ERR(i, j) / UA(i, j));

        end
    end

%%% Экспорт %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    save('solution.mat', 'UA', 'UN', 'X', 'T', 'ABS_ERR', 'REL_ERR');
end
