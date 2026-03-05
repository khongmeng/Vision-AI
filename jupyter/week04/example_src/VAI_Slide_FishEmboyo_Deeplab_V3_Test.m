%% VAI_Slide_FishEmboyo_Deeplab_V3_Test.m

%%
% cmap = create whatever color map you want to use to represent each of labels

%%
TestIdx = 1;
%TestImg = imread(imdsTrain.Files{TestIdx});
TestImg = cat(3, imresize(imread(imdsTest.Files{TestIdx}), [224 224]));

cmap = [1 0 0; 0 1 0];

SegResult_CAT = semanticseg(TestImg, SemSeg_CNN);
OverlayImg = labeloverlay(TestImg, SegResult_CAT, 'Colormap', cmap, 'Transparency',0.4);
figure, imshow(OverlayImg); drawnow
%VAI_Slide_SemSeg_Util.camvidPixelLabelColorbar(cmap, ClassNames);

return

