function bestPoint = closestToIdealNormalized(front)
% front: N×M matrix of nondominated solutions (N points, M objectives)
% bestPoint: the solution closest to the normalized ideal point

    % Normalize each objective column to [0,1]
    minVals = min(front, [], 1);
    maxVals = max(front, [], 1);
    normFront = (front - minVals) ./ (maxVals - minVals);

    % Ideal point in normalized space is [0,0,...,0]
    idealPoint = zeros(1, size(front,2));

    % Compute Euclidean distances to ideal point
    distances = sqrt(sum((normFront - idealPoint).^2, 2));

    % Find the closest solution (in normalized space)
    [~, idx] = min(distances);
    bestPoint = front(idx,:);  % return original (un-normalized) solution
end