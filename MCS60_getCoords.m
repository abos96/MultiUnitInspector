channels = [11, 12, 13, 14, 15, 16, 17, 18, ... 
    21, 22, 23, 24, 25, 26, 27, 28, ...
    31, 32, 33, 34, 35, 36, 37, 38, ...
    41, 42, 43, 44, 45, 46, 47, 48, ...
    51, 52, 53, 54, 55, 56, 57, 58, ...
    61, 62, 63, 64, 65, 66, 67, 68, ...,
    71, 72, 73, 74, 75, 76, 77, 78, ...,
    81, 82, 83, 84, 85, 86, 87, 88];

coords = zeros(length(channels), 2);
coords(:, 2) = repmat(linspace(0, 1, 8), 1, 8);
coords(:, 1) = repelem(linspace(0, 1, 8), 1, 8);

subset_idx = find(~ismember(channels, [11, 81, 18, 88]));
channels = channels(subset_idx);

% reorderingIdx = zeros(length(channels), 1);
% for n = 1:length(channels)
%     reorderingIdx(n) = find(channelsOrdering(n) == channels);
% end 

 coords = coords(subset_idx, :);

% Re-order the channel IDs and coordinates to match the original
% ordering
% channels = channels(reorderingIdx); 
% coords = coords(reorderingIdx, :);
% reorderingIdx = reorderingIdx;
coords(channels==15,:) = [];
channels(channels==15) = [];
