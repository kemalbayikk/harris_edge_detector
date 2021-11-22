function harrisDetect(imgrgb)
img = rgb2gray(imgrgb);
height = size(img,1);
width = size(img,2);
totalScale = 5;
Mc = zeros(height,width,totalScale);
result = zeros(height,width);
resultAllScales = zeros(height,width);
Mcmax = 0;
for s = 1:totalScale
    scale = s;
    fx = meshgrid(-scale:scale,1);
    fy = fx';
    img = im2double(img);
    imgpad = padarray(img,[1 1]);
    for i = scale+1:size(imgpad,1)-2
            for j = scale+1:size(imgpad,2)-scale-1
                temp = imgpad(i,j-scale:j+scale) .* fx;
                Ix(i,j) = sum(temp(:));
            end
    end
    
    for i = scale+1:size(imgpad,1)-scale-1
            for j = scale+1:size(imgpad,2)-2
                temp = imgpad(i-scale:i+scale,j) .* fy;
                Iy(i,j) = sum(temp(:));
            end
    end
    Ix2 = Ix.^2;
    Iy2 = Iy.^2;
    Ixy = Ix.*Iy;
    g = fspecial('gaussian',3,1.5);
    siz = size(Ix2);
    for i = 2:siz(1)-1
            for j = 2:siz(2)-1
                temp = Ix2(i-1:i+1,j-1:j+1) .* g;
                Ix2(i-1,j-1) = sum(temp(:));
                temp = Iy2(i-1:i+1,j-1:j+1) .* g;
                Iy2(i-1,j-1) = sum(temp(:));
                temp = Ixy(i-1:i+1,j-1:j+1) .* g;
                Ixy(i-1,j-1) = sum(temp(:));
            end
    end
    for i = 1:height
        for j = 1:width
        M = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)]; 
        Mc(i,j,s) = det(M)-0.1*(trace(M))^2;
            if Mc(i,j,s) > Mcmax
               Mcmax = Mc(i,j,s);
            end
        end
    end
    
    %TÜM SCALELARIN Mc MATRİSLERİNİ BULDUM.

end
threshold = Mcmax * 0.05;
counter = 0;
counterAllScales = 0;
for s = 1:totalScale
    for i = 2:height-1
        for j = 2:width-1
            if(s == 1)
                if Mc(i,j,s) > threshold && Mc(i,j,s) > Mc(i-1,j-1,s) && Mc(i,j,s) > Mc(i-1,j,s) && Mc(i,j,s) > Mc(i-1,j+1,s) && Mc(i,j,s) > Mc(i,j-1,s) && Mc(i,j,s) > Mc(i,j+1,s) && Mc(i,j,s) > Mc(i+1,j-1,s) && Mc(i,j,s) > Mc(i+1,j,s) && Mc(i,j,s) > Mc(i+1,j+1,s)
                    resultAllScales(i,j) = 1;
                    counterAllScales = counterAllScales + 1;
                    if Mc(i,j,s) > Mc(i,j,s+1) && Mc(i,j,s) > Mc(i-1,j-1,s+1) && Mc(i,j,s) > Mc(i-1,j,s+1) && Mc(i,j,s) > Mc(i-1,j+1,s+1) && Mc(i,j,s) > Mc(i,j-1,s+1) && Mc(i,j,s) > Mc(i,j+1,s+1) && Mc(i,j,s) > Mc(i+1,j-1,s+1) && Mc(i,j,s) > Mc(i+1,j,s+1) && Mc(i,j,s) > Mc(i+1,j+1,s+1)
                        result(i,j) = 1;
                        counter = counter + 1;
                     end
                end
            

            elseif(s == totalScale)
                if Mc(i,j,s) > threshold && Mc(i,j,s) > Mc(i-1,j-1,s) && Mc(i,j,s) > Mc(i-1,j,s) && Mc(i,j,s) > Mc(i-1,j+1,s) && Mc(i,j,s) > Mc(i,j-1,s) && Mc(i,j,s) > Mc(i,j+1,s) && Mc(i,j,s) > Mc(i+1,j-1,s) && Mc(i,j,s) > Mc(i+1,j,s) && Mc(i,j,s) > Mc(i+1,j+1,s)
                    resultAllScales(i,j) = 1;
                    counterAllScales = counterAllScales + 1; 
                    if Mc(i,j,s) > Mc(i,j,s-1) && Mc(i,j,s) > Mc(i-1,j-1,s-1) && Mc(i,j,s) > Mc(i-1,j,s-1) && Mc(i,j,s) > Mc(i-1,j+1,s-1) && Mc(i,j,s) > Mc(i,j-1,s-1) && Mc(i,j,s) > Mc(i,j+1,s-1) && Mc(i,j,s) > Mc(i+1,j-1,s-1) && Mc(i,j,s) > Mc(i+1,j,s-1) && Mc(i,j,s) > Mc(i+1,j+1,s-1)
                        result(i,j) = 1;
                        counter = counter + 1;
                     end
                end
            else
                if Mc(i,j,s) > threshold && Mc(i,j,s) > Mc(i-1,j-1,s) && Mc(i,j,s) > Mc(i-1,j,s) && Mc(i,j,s) > Mc(i-1,j+1,s) && Mc(i,j,s) > Mc(i,j-1,s) && Mc(i,j,s) > Mc(i,j+1,s) && Mc(i,j,s) > Mc(i+1,j-1,s) && Mc(i,j,s) > Mc(i+1,j,s) && Mc(i,j,s) > Mc(i+1,j+1,s)
                    resultAllScales(i,j) = 1;
                    counterAllScales = counterAllScales + 1; 
                    if Mc(i,j,s) > Mc(i,j,s-1) && Mc(i,j,s) > Mc(i-1,j-1,s-1) && Mc(i,j,s) > Mc(i-1,j,s-1) && Mc(i,j,s) > Mc(i-1,j+1,s-1) && Mc(i,j,s) > Mc(i,j-1,s-1) && Mc(i,j,s) > Mc(i,j+1,s-1) && Mc(i,j,s) > Mc(i+1,j-1,s-1) && Mc(i,j,s) > Mc(i+1,j,s-1) && Mc(i,j,s) > Mc(i+1,j+1,s-1)
                        if Mc(i,j,s) > Mc(i,j,s+1) && Mc(i,j,s) > Mc(i-1,j-1,s+1) && Mc(i,j,s) > Mc(i-1,j,s+1) && Mc(i,j,s) > Mc(i-1,j+1,s+1) && Mc(i,j,s) > Mc(i,j-1,s+1) && Mc(i,j,s) > Mc(i,j+1,s+1) && Mc(i,j,s) > Mc(i+1,j-1,s+1) && Mc(i,j,s) > Mc(i+1,j,s+1) && Mc(i,j,s) > Mc(i+1,j+1,s+1)
                            result(i,j) = 1;
                            counter = counter + 1;
                        end
                     end
                end
            end
        end
    end

end
cornersX = zeros(counter);
cornersY = zeros(counter);
rcounter = 1;
for i = 1:size(result,1)
    for j = 1:size(result,2)
        if (result(i,j) == 1)
            cornersX(rcounter) = i;  
            cornersY(rcounter) = j;
            rcounter = rcounter + 1;
        end
    end
end

cornersXAll = zeros(counterAllScales);
cornersYAll = zeros(counterAllScales);
rcounterAll = 1;
for i = 1:size(resultAllScales,1)
    for j = 1:size(resultAllScales,2)
        if (resultAllScales(i,j) == 1)
            cornersXAll(rcounterAll) = i;  
            cornersYAll(rcounterAll) = j;
            rcounterAll = rcounterAll + 1;
        end
    end
end
hAxes = axes( figure );
imshow(imgrgb,"Parent",hAxes);
title( hAxes, " her bir ölçekte bulduğunuz köşelerin tamamını içeren resim. threshold = "+threshold+" total köşe sayısı = "+counterAllScales );
hold on;
plot(cornersYAll,cornersXAll,'r.');

hAxes = axes( figure );
imshow(imgrgb,"Parent",hAxes);
title( hAxes, "tüm ölçeklerin birleştirilmesi ile oluşan ölçek-bağımsız köşeleri içeren resim. threshold = "+threshold+" total köşe sayısı = "+counter);
hold on;
plot(cornersY,cornersX,'r.');

end
