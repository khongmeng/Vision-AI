
%%  AUG_Img_AND_Label.m 

function data = AUG_Img_AND_Label(data)
% Augment images and pixel label images 

%%
RawImg = data{1};
LblImg = data{2};

%%
% do whatever augmentation you want to do with raw and label iamges

RawImg = cat(3, RawImg, RawImg, RawImg);    % from 224×224×1 to 224×224×3

% augmentment RawImg & augment LblImg
data{1} = imresize(RawImg, [224 224]);
data{2} = imresize(LblImg, [224 224], 'nearest');



return



