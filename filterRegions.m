function [BW_out,properties] = filterRegions(BW_in)
%filterRegions  Filter BW image using auto-generated code from imageRegionAnalyzer app.
%  [BW_OUT,PROPERTIES] = filterRegions(BW_IN) filters binary image BW_IN
%  using auto-generated code from the imageRegionAnalyzer App. BW_OUT has
%  had all of the options and filtering selections that were specified in
%  imageRegionAnalyzer applied to it. The PROPERTIES structure contains the
%  attributes of BW_out that were visible in the App.

% Auto-generated by imageRegionAnalyzer app on 11-Jun-2019
%---------------------------------------------------------

BW_out = BW_in;

% Get properties.
properties = regionprops(BW_out, {'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'FilledArea', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity', 'PixelList'});

% Sort the properties.
properties = sortProperties(properties, 'Area');

% Uncomment the following line to return the properties in a table.
% properties = struct2table(properties);



function properties = sortProperties(properties, sortField)

% Compute the sort order of the structure based on the sort field.
[~,idx] = sort([properties.(sortField)], 'descend');

% Reorder the entire structure.
properties = properties(idx);
