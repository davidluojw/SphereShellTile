clear all; clc;


ver3d_BCDA = [0.577350269189626,  0.577350269189626,  0.577350269189626,  0.577350269189626;
              0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
              0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626 ] ;


ver3d_FGCB = [-0.577350269189626, -0.577350269189626,  0.577350269189626, 0.577350269189626;
               0.577350269189626,  0.577350269189626,  0.577350269189626, 0.577350269189626;
               0.577350269189626, -0.577350269189626, -0.577350269189626, 0.577350269189626 ] ;

ver3d_EHGF = [-0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626;
              -0.577350269189626, -0.577350269189626,  0.577350269189626,  0.577350269189626;
               0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626 ] ;

ver3d_ADHE = [ 0.577350269189626,  0.577350269189626, -0.577350269189626,-0.577350269189626;
              -0.577350269189626, -0.577350269189626, -0.577350269189626,-0.577350269189626;
               0.577350269189626, -0.577350269189626, -0.577350269189626, 0.577350269189626 ] ;

ver3d_FBAE = [-0.577350269189626, 0.577350269189626,  0.577350269189626, -0.577350269189626;
               0.577350269189626, 0.577350269189626, -0.577350269189626, -0.577350269189626;
               0.577350269189626, 0.577350269189626,  0.577350269189626,  0.577350269189626 ] ;

ver3d_CGHD = [ 0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626;
               0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
              -0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626 ] ;

[tile1, sgp1] = MakeTile(ver3d_BCDA, 1);
[tile2, sgp2] = MakeTile(ver3d_FGCB, 1);
[tile3, sgp3] = MakeTile(ver3d_EHGF, 1);
[tile4, sgp4] = MakeTile(ver3d_ADHE, 1);
% [tile5, sgp5] = MakeTile(ver3d_FBAE, 1);
[tile6, sgp6] = MakeTile(ver3d_CGHD, 1);

% 绘制瓦片
figure;
hold on;

% 绘制每个瓦片
nrbplot(tile1, [50 50]);  % 细化程度 50x50
nrbplot(tile2, [50 50]);
nrbplot(tile3, [50 50]);
nrbplot(tile4, [50 50]);
% nrbplot(tile5, [50 50]);
nrbplot(tile6, [50 50]);

% 设置显示属性
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Multi-tile Sphere');
grid on;
hold off;


addpath(genpath('Cube'));
[rdodesphere] = Multi_SphereFromCube(tile6); 

% 绘制瓦片
figure;
hold on;

% 绘制每个瓦片
nrbplot(rdodesphere(1).nurbs, [50 50]);  % 细化程度 50x50
nrbplot(rdodesphere(2).nurbs, [50 50]);
nrbplot(rdodesphere(3).nurbs, [50 50]);
nrbplot(rdodesphere(4).nurbs, [50 50]);
% nrbplot(rdodesphere(5).nurbs, [50 50]);
nrbplot(rdodesphere(6).nurbs, [50 50]);

% 设置显示属性
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Multi-tile Sphere');
grid on;
hold off;

% 绘制瓦片和控制点
figure;
hold on;

for k = 1:6
    ctrl_pts = double(rdodesphere(k).nurbs.coefs); 

    x = squeeze(ctrl_pts(1,:,:) ./ ctrl_pts(4,:,:));
    y = squeeze(ctrl_pts(2,:,:) ./ ctrl_pts(4,:,:));
    z = squeeze(ctrl_pts(3,:,:) ./ ctrl_pts(4,:,:));

    scatter3(x(:), y(:), z(:), 100, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','r');

    for i = 1:size(x,1)
        plot3(x(i,:), y(i, :), z(i, :), 'k-', 'LineWidth', 1); 
    end

    for j = 1:size(x,2)
        plot3(x(:, j), y(:, j), z(:, j), 'k-', 'LineWidth', 1);
    end
end

% 设置显示属性
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('NURBS Tiles with Control Points');
grid on;
hold off;






% % 合并控制点，形状为 (4, m, n, l)，l = 2 表示内外两层
% hcon3d_shell = cat(4, hcon3d_inner, hcon3d_outer);
% 
% % 参数化方向的节点矢量
% knots_r = [0 0 1 1];  % 径向方向，线性节点矢量
% 
% % 构造球壳 NURBS 体
% tile = nrbmak(hcon3d_shell, {[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1] [0 0 1 1]});