function [S map] = bonemap(Z,varargin)

cellSize = 1;
verticalExaggeration = 2;
nColors = 256;
if nargout==2
    nColors=256;
end
colorScheme = 'bone';
imageStyle = 'normal';
forceindex = false;

if ~isempty(varargin)
    i = 1;
    while i<length(varargin)
        switch lower(varargin{i})
            case 'c'
                cellSize = varargin{i+1};
                i = i + 1;
            case 've'
                verticalExaggeration = varargin{i+1};
                i = i + 1;
            case 'ncolors'
                nColors = varargin{i+1};
                i = i + 1;
                if nargout==2 & nColors==Inf
                    error('If a colormap is requested, the number of colors must be finite.');
                end
            case 'colormap'
                colorScheme = varargin{i+1};
                i = i + 1;
            case 'style';
                imageStyle = lower(varargin{i+1});
                i = i+1;
            case 'forceindex'
                forceindex = true;
            otherwise
                error([varargin{i},' not recognized.']);
        end
        i = i + 1;
    end
end

   Z(isnan(Z)) = -99999;
    
    [Sx Sy] = gradient(Z,cellSize);
    clear S;
    S = single(sqrt(Sx.^2 + Sy.^2));
    clear Sx Sy

    S = atand(verticalExaggeration * S);
    
    if ~strcmp(imageStyle,'reverse')
        S = 1 - mat2gray(S,[0 90]);
    else
        S = mat2gray(S,[0 90]);
    end
    
%     if nargout>0
        if nColors<=256
            S = uint8(gray2ind(S,nColors));
        else
            S = uint16(gray2ind(S,nColors));
        end
        map = eval([colorScheme,'(nColors);']);
%     end
    
    
    if (nargout < 2) & ~forceindex
        S = ind2rgb(S,map);
    end
    
end