function sphereRadius = segm3d(colorImage, depthImage)
    % Preprocess images
    [BW, ~] = createMask(colorImage);
    [~, properties] = filterRegions(BW);
    sphereProps = properties(1);

    % Create point cloud
    pointCloud = findROI(colorImage, depthImage, sphereProps.PixelList);

    % Detect the table and extract it from the point cloud
    remainPtCloud = removePlane(pointCloud);

    % Detect the globe and extract it from the point cloud
    [model, ~] = extractSphereFromPointCloud(remainPtCloud);
    sphereRadius = model.Radius;
end

function [model, globePointsCloud] = extractSphereFromPointCloud(remainPointCloud)
    maxDistance = 100;
    roi = [-350, -150, -30, 200, 500, 900];
    %region = findPointsInROI(remainPointCloud, roi);
    [model, inlierIndices] = pcfitsphere(remainPointCloud, maxDistance);%, 'SampleIndices', region);
    globePointsCloud = select(remainPointCloud, inlierIndices);
end

function pointCloud = removePlane(pointCloudWithPlane)
    maxDistance = 30;
    [~, ~, outlierIndices] = pcfitplane(pointCloudWithPlane, maxDistance, 'Confidence', 99.99);
    pointCloud = select(pointCloudWithPlane, outlierIndices);  
end

function pointsCloud = findROI(colorImage, depthImage, pixelList)
    fx = 525;
    fy = fx;
    cx = 312;
    cy = 264;
    
    [imageWidth, imageHeight, ~] = size(colorImage);
    points = zeros(imageWidth, imageHeight, 3);
    
    [~, maskedImage] = createMask(colorImage);
    for k=1:size(pixelList)
        i = pixelList(k, 2);
        j = pixelList(k, 1);
                if(maskedImage(i,j,1) > 90 && maskedImage(i,j,2) > 90 && maskedImage(i,j,3) > 90)
                    x = i; y= j; z = depthImage(i,j);
                    points(i,j,1) = (x - cx)*z/fx;
                    points(i,j,2) = (y - cy)*z/fy;
                    points(i,j,3) = z;
                else
                    points(i,j,1) = Inf;
                    points(i,j,2) = Inf;
                    points(i,j,3) = Inf;
                end
    end
    pointsCloud = pointCloud(points, 'Color', maskedImage);
    [pointsCloud, ~] = removeInvalidPoints(pointsCloud);
end

