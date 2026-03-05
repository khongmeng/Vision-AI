classdef    VAI_Slide_SemSeg_Util
   properties 
      p_labelIDs = 0
   end
    methods     ( Static = true )

        %%
        function [imdsTrain, imdsVal, imdsTest, pxdsTrain, pxdsVal, pxdsTest, testIdx] = ...
                camvidPartitionData(imds,pxds, splitRatio, obj)
            % Partition CamVid data by randomly selecting 60% of the data for training. The
            % rest is used for testing.

            % Set initial random state for example reproducibility.
            %rng(0);
            numFiles = numel(imds.Files);
            shuffledIndices = randperm(numFiles);

            % Use 60% of the images for training.
            numTrain = round(splitRatio(1) * numFiles);
            trainingIdx = shuffledIndices(1:numTrain);

            % Use 20% of the images for validation
            numVal = round(splitRatio(2) * numFiles);
            valIdx = shuffledIndices(numTrain+1:numTrain+numVal);

            % Use the rest for testing.
            testIdx = shuffledIndices(numTrain+numVal+1:end);

            % Create image datastores for training and test.
            trainingImages = imds.Files(trainingIdx);
            valImages = imds.Files(valIdx);
            testImages = imds.Files(testIdx);

            imdsTrain = imageDatastore(trainingImages);
            imdsVal = imageDatastore(valImages);
            imdsTest = imageDatastore(testImages);

            % Extract class and label IDs info.
            classes = pxds.ClassNames;
            labelIDs = obj.p_labelIDs;  % camvidPixelLabelIDs(obj);

            % Create pixel label datastores for training and test.
            trainingLabels = pxds.Files(trainingIdx);
            valLabels = pxds.Files(valIdx);
            testLabels = pxds.Files(testIdx);

            pxdsTrain = pixelLabelDatastore(trainingLabels, classes, labelIDs);
            if isempty(valLabels),  pxdsVal = {};
            else
                pxdsVal = pixelLabelDatastore(valLabels, classes, labelIDs);
            end
            if isempty(testLabels),  pxdsTest = {};
            else
                pxdsTest = pixelLabelDatastore(testLabels, classes, labelIDs);
            end
        end

        %%
        function RtnLabelIDs = camvidPixelLabelIDs(obj)
            RtnLabelIDs = obj.p_labelIDs;
            %labelIDs = { [0 0 0], [255 0 0]};
        end

        %%
        function camvidPixelLabelColorbar(cmap, classNames)
            % Add a colorbar to the current axis. The colorbar is formatted
            % to display the class names with the color.

            colormap(gca,cmap)

            % Add colorbar to current figure.
            c = colorbar('peer', gca);

            % Use class names for tick marks.
            c.TickLabels = classNames;
            numClasses = size(cmap,1);

            % Center tick labels.
            c.Ticks = 1/(numClasses*2):1/numClasses:1;

            % Remove tick mark.
            c.TickLength = 0;
        end
    end
end