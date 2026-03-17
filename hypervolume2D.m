function hv = hypervolume2D(front, refPoint)
    front = unique(front, 'rows');        % remove duplicates
    front = sortrows(front, 1);           % sort by first objective
    hv = 0;
    for i = 1:size(front,1)
        if i == size(front,1)
            width = refPoint(1) - front(i,1);
        else
            width = front(i+1,1) - front(i,1);
        end
        height = refPoint(2) - front(i,2);
        hv = hv + width * height;
    end
end