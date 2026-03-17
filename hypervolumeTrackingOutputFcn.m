function [state, options, optchanged] = hypervolumeTrackingOutputFcn(options, state, flag)
    persistent hvHistory refPoint
    optchanged = false;

    switch flag
        case 'init'
            hvHistory = [];
            refPoint = [];
        case 'iter'
            if isempty(refPoint)
                % Fix reference point at first generation
                refPoint = max(state.Score, [], 1) + 1;
            end

            hv = computeHypervolume2D(state.Score, refPoint);
            hvHistory(end+1) = hv;

            fprintf('Generation %d: Hypervolume = %.4f\n', state.Generation, hv);
        case 'done'
            assignin('base', 'hypervolumeHistory', hvHistory);
            assignin('base', 'fixedRefPoint', refPoint);
        end
end

function hv = computeHypervolume2D(F, refPoint)
    % Remove dominated points
    F = nondominated(F);
    % Sort by first objective
    F = sortrows(F, 1);

    hv = 0;
    currentTop = refPoint(2);

    for i = 1:size(F,1)
        width = refPoint(1) - F(i,1);
        if width <= 0, continue; end

        height = max(0, currentTop - F(i,2));
        hv = hv + width * height;

        currentTop = min(currentTop, F(i,2));
    end
end

function Fnd = nondominated(F)
    keep = true(size(F,1),1);
    for i = 1:size(F,1)
        if ~keep(i), continue; end
        dominated = all(F <= F(i,:), 2) & any(F < F(i,:), 2);
        dominated(i) = false;
        keep = keep & ~dominated;
    end
    Fnd = F(keep,:);
end