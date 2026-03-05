%% VAI_Slide_FishEmboyo_Deeplab_V3_Train.m

%% define "ClassNames" for each label 
% this is only for displaying better info in our output figure. 

%%
obj = VAI_Slide_SemSeg_Util();        % some utility functions
ClassNames = ["background", "Yolk"];
numClasses = numel(ClassNames);
obj.p_labelIDs = [0 1];

%% 
ImgFolder = '..\FishEmbryo_All_Images\FishEmbryo_Raw_Images\Yolk\';
imds = imageDatastore(ImgFolder);     

%% pixel label datastore
LabelFolder = '..\FishEmbryo_All_Images\FishEmbryo_Label_Images\Yolk\';
pxds = pixelLabelDatastore(LabelFolder, ClassNames, VAI_Slide_SemSeg_Util.camvidPixelLabelIDs(obj));

% Analyze Dataset Statistics
tbl = countEachLabel(pxds);
totalNumberOfPixels = sum(tbl.PixelCount);
frequencyPxl = tbl.PixelCount / totalNumberOfPixels;
inverseFrequency = 1./frequencyPxl;

%%
[imdsTrain, imdsVal, imdsTest, pxdsTrain, pxdsVal, pxdsTest, testIdx] = ...
                        VAI_Slide_SemSeg_Util.camvidPartitionData(imds, pxds, [0.8 0.0 0.2], obj);

dsTrain = combine(imdsTrain, pxdsTrain);
dsTrain = transform(dsTrain, @(data)VAI_Slide_AUG_Img_AND_Label(data));

dsTest = combine(imdsTest, pxdsTest);
dsTest = transform(dsTest, @(data)VAI_Slide_AUG_Img_AND_Label(data));

%% DeepLabv3 w/ resnet18 / resnet50
Trgt_ImgSize = [224 224];
lgraph = deeplabv3plusLayers(Trgt_ImgSize, numClasses, "resnet18");
pxLayer = pixelClassificationLayer('Name', 'labels', 'Classes', ClassNames, ...
                       'ClassWeights',inverseFrequency); % ,'ClassWeights',classWeights
lgraph = replaceLayer(lgraph, "classification", pxLayer);

myEpoch = 200;
options = trainingOptions('sgdm', ...
    'Momentum',0.9, ...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs', myEpoch, ...  
    'MiniBatchSize', 9, ...
    'Shuffle','every-epoch', ...
    'ExecutionEnvironment', 'auto', ...
    'Plots','training-progress'         );

[SemSeg_CNN, info] = trainNetwork(dsTrain, lgraph, options);

return
