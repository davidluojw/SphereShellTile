clear all; clc;


ver3d_CGHD = [ 0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626;
               0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
              -0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626 ] ;


%% spherical shell surface
r_inner = 98;  % 内层半径
r_outer = 100;  % 外层半径

% 内层顶点
ver3d_BCDA_inner = r_inner * [0.577350269189626,  0.577350269189626,  0.577350269189626,  0.577350269189626;
                              0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
                              0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626 ] ;


ver3d_FGCB_inner = r_inner * [-0.577350269189626, -0.577350269189626,  0.577350269189626, 0.577350269189626;
                               0.577350269189626,  0.577350269189626,  0.577350269189626, 0.577350269189626;
                               0.577350269189626, -0.577350269189626, -0.577350269189626, 0.577350269189626 ] ;

ver3d_EHGF_inner = r_inner * [-0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626;
                              -0.577350269189626, -0.577350269189626,  0.577350269189626,  0.577350269189626;
                               0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626 ] ;

ver3d_ADHE_inner = r_inner * [ 0.577350269189626,  0.577350269189626, -0.577350269189626,-0.577350269189626;
                              -0.577350269189626, -0.577350269189626, -0.577350269189626,-0.577350269189626;
                               0.577350269189626, -0.577350269189626, -0.577350269189626, 0.577350269189626 ] ;

ver3d_FBAE_inner = r_inner * [-0.577350269189626, 0.577350269189626,  0.577350269189626, -0.577350269189626;
                               0.577350269189626, 0.577350269189626, -0.577350269189626, -0.577350269189626;
                               0.577350269189626, 0.577350269189626,  0.577350269189626,  0.577350269189626 ] ;

ver3d_CGHD_inner = r_inner * [ 0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626;
                               0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
                              -0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626 ] ;

% 外层顶点
ver3d_BCDA_outer = r_outer * [0.577350269189626,  0.577350269189626,  0.577350269189626,  0.577350269189626;
                              0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
                              0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626 ] ;


ver3d_FGCB_outer = r_outer * [-0.577350269189626, -0.577350269189626,  0.577350269189626, 0.577350269189626;
                               0.577350269189626,  0.577350269189626,  0.577350269189626, 0.577350269189626;
                               0.577350269189626, -0.577350269189626, -0.577350269189626, 0.577350269189626 ] ;

ver3d_EHGF_outer = r_outer * [-0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626;
                              -0.577350269189626, -0.577350269189626,  0.577350269189626,  0.577350269189626;
                               0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626 ] ;

ver3d_ADHE_outer = r_outer * [ 0.577350269189626,  0.577350269189626, -0.577350269189626,-0.577350269189626;
                              -0.577350269189626, -0.577350269189626, -0.577350269189626,-0.577350269189626;
                               0.577350269189626, -0.577350269189626, -0.577350269189626, 0.577350269189626 ] ;

ver3d_FBAE_outer = r_outer * [-0.577350269189626, 0.577350269189626,  0.577350269189626, -0.577350269189626;
                               0.577350269189626, 0.577350269189626, -0.577350269189626, -0.577350269189626;
                               0.577350269189626, 0.577350269189626,  0.577350269189626,  0.577350269189626 ] ;

ver3d_CGHD_outer = r_outer * [ 0.577350269189626, -0.577350269189626, -0.577350269189626,  0.577350269189626;
                               0.577350269189626,  0.577350269189626, -0.577350269189626, -0.577350269189626;
                              -0.577350269189626, -0.577350269189626, -0.577350269189626, -0.577350269189626 ] ;


% 内层控制点
[tile_inner, sgp_inner] = MakeTile(ver3d_CGHD_inner, r_inner);
[rdodesphere_inner] = Multi_SphereFromCube(tile_inner);


% 外层控制点
[tile_outer, sgp_outer] = MakeTile(ver3d_CGHD_outer, r_outer);
[rdodesphere_outer] = Multi_SphereFromCube(tile_outer);

% 绘制瓦片
figure;
hold on;

% 绘制每个瓦片
nrbplot(rdodesphere_inner(1).nurbs, [50 50]);  % 细化程度 50x50
nrbplot(rdodesphere_inner(2).nurbs, [50 50]);
nrbplot(rdodesphere_inner(3).nurbs, [50 50]);
nrbplot(rdodesphere_inner(4).nurbs, [50 50]);
nrbplot(rdodesphere_inner(5).nurbs, [50 50]);
% nrbplot(rdodesphere_inner(6).nurbs, [50 50]);

nrbplot(rdodesphere_outer(1).nurbs, [50 50]);  % 细化程度 50x50
nrbplot(rdodesphere_outer(2).nurbs, [50 50]);
nrbplot(rdodesphere_outer(3).nurbs, [50 50]);
nrbplot(rdodesphere_outer(4).nurbs, [50 50]);
nrbplot(rdodesphere_outer(5).nurbs, [50 50]);
% nrbplot(rdodesphere_outer(6).nurbs, [50 50]);


% 设置显示属性
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Multi-tile Sphere Shell Surface');
grid on;
hold off;


% 绘制瓦片和控制点
figure;
hold on;

for k = 1:6
    ctrl_pts = double(rdodesphere_inner(k).nurbs.coefs); 

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


for k = 1:6
    ctrl_pts = double(rdodesphere_outer(k).nurbs.coefs); 

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

%% Spericall shell block
shell_coefs = cat(4, tile_inner.coefs, tile_outer.coefs);

knots_r = [0 0 1 1];

tile_shell = nrbmak(shell_coefs, {[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1] [0 0 1 1]});

figure;
hold on;
nrbplot(tile_shell, [50 50 50]);
% 设置显示属性
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Multi-tile Sphere Shell Block');
grid on;
hold off;

rdodesphereshell = struct([]);

for k = 1:6

    shell_coefs = cat(4, rdodesphere_inner(k).nurbs.coefs, rdodesphere_outer(k).nurbs.coefs);

    tile_shell = nrbmak(shell_coefs, {[0 0 0 0 0 1 1 1 1 1] [0 0 0 0 0 1 1 1 1 1] [0 0 1 1]});

    rdodesphereshell(k).nurbs = tile_shell;

end

figure;
hold on;

nrbplot(rdodesphereshell(1).nurbs, [50 50 50]);
% nrbplot(rdodesphereshell(2).nurbs, [50 50 50]);
% nrbplot(rdodesphereshell(3).nurbs, [50 50 50]);
% nrbplot(rdodesphereshell(4).nurbs, [50 50 50]);
% nrbplot(rdodesphereshell(5).nurbs, [50 50 50]);
% nrbplot(rdodesphereshell(6).nurbs, [50 50 50]);


% 设置显示属性
axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Multi-tile Sphere Shell Block');
grid on;
hold off;

figure;
hold on;

for k = 1:6
    ctrl_pts = double(rdodesphereshell(k).nurbs.coefs); 

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

%% write geometry yaml file

% 定义 NURBS 数据
data.TYPE = 'NURBS';
for a = 1:6
    data.GLOBAL_S = rdodesphereshell(a).nurbs.knots{1,1};
    data.GLOBAL_T = rdodesphereshell(a).nurbs.knots{1,2};
    data.GLOBAL_U = rdodesphereshell(a).nurbs.knots{1,3};
    data.DEGREE_S = rdodesphereshell(a).nurbs.order(1) - 1;
    data.DEGREE_T = rdodesphereshell(a).nurbs.order(2) - 1;
    data.DEGREE_U = rdodesphereshell(a).nurbs.order(3) - 1;
    
    ctrlpts_wegts = double(rdodesphereshell(a).nurbs.coefs); 
    size_ctrpts_wegts = size(ctrlpts_wegts);   % 4 5 5 2
    
    data.NUM_CP = size_ctrpts_wegts(2)*size_ctrpts_wegts(3)*size_ctrpts_wegts(4);
    
    x = squeeze(ctrlpts_wegts(1,:,:,:) ./ ctrlpts_wegts(4,:,:,:));
    y = squeeze(ctrlpts_wegts(2,:,:,:) ./ ctrlpts_wegts(4,:,:,:));
    z = squeeze(ctrlpts_wegts(3,:,:,:) ./ ctrlpts_wegts(4,:,:,:));
    w = squeeze(ctrlpts_wegts(4,:,:,:));
    for r=1:size_ctrpts_wegts(4)
        w(:,:,r) = w(:,:,r) / max(max(w(:,:,r)));
    end
    
    % 底层节点先排，再排上层的节点
    % (5*5*2, 4)
    data.ctrlPts = zeros(size_ctrpts_wegts(2) * size_ctrpts_wegts(3) * size_ctrpts_wegts(4), size_ctrpts_wegts(1));
    
    counter = 1;
    for k =1:size_ctrpts_wegts(4)
        for j=1:size_ctrpts_wegts(2)
            for i=1:size_ctrpts_wegts(3)
                data.ctrlPts(counter, :) = [x(i,j,k), y(i,j,k), z(i,j,k), w(i,j,k)];
                counter = counter + 1;
            end
        end
    end
    
    filename = "patch" + num2str(a-1) + ".yml";
    
    % YAML 文件写入函数
    writeYAML(filename, data);
end

