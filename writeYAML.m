% 定义写入函数
function writeYAML(filename, data)
    fid = fopen(filename, 'w');
    if fid == -1
        error('无法打开文件 %s 进行写入', filename);
    end

    % 写入 YAML 数据
    fprintf(fid, 'TYPE: %s\n', data.TYPE);

    fprintf(fid, 'GLOBAL_S: [');
    for i=1:(length(data.GLOBAL_S)-1)
        fprintf(fid, '%f, ', data.GLOBAL_S(i));
    end
    fprintf(fid, '%f ]\n', data.GLOBAL_S(end));

    fprintf(fid, 'GLOBAL_T: [');
    for i=1:(length(data.GLOBAL_T)-1)
        fprintf(fid, '%f, ', data.GLOBAL_T(i));
    end
    fprintf(fid, '%f ]\n', data.GLOBAL_T(end));

    fprintf(fid, 'GLOBAL_U: [');
    for i=1:(length(data.GLOBAL_U)-1)
        fprintf(fid, '%f, ', data.GLOBAL_U(i));
    end
    fprintf(fid, '%f ]\n', data.GLOBAL_U(end));
    
    fprintf(fid, 'DEGREE_S: %d\n', data.DEGREE_S);
    fprintf(fid, 'DEGREE_T: %d\n', data.DEGREE_T);
    fprintf(fid, 'DEGREE_U: %d\n', data.DEGREE_U);
    fprintf(fid, 'NUM_CP: %d\n\n', data.NUM_CP);

    fprintf(fid, 'ctrlPts: [\n');
    for i = 1:size(data.ctrlPts, 1)
        fprintf(fid, '%.6f, %.6f, %.6f, %.6f', data.ctrlPts(i, :));
        if i < size(data.ctrlPts, 1)
            fprintf(fid, ',\n');
        else
            fprintf(fid, '\n');
        end
    end
    fprintf(fid, ']\n');

    fclose(fid);
end
