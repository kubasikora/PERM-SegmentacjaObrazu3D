results = zeros(100,1);
colorImage = imread('./color.png');
depthImage = double(imread('./depth.png'));
for i=1:100
    results(i) = segm3d(colorImage, depthImage);
end
bins = [60, 70, 80, 90, 100, 110, 120, 130, 140, 150];
histogram(results, bins);