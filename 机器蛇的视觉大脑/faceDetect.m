%һ������£�һ�������Ļ������Ӿ�Ӧ����Ҫ�õ�������������
% Image Processing Toolbox ��ͼ�������䣩
% Computer Vision System Toolbox ��������Ӿ������䣩��
% Image Acquisition Toolbox ��ͼ��ɼ������䣩
% Computer Vision System Toolbox �Ѿ�ʵ�֣�����˵�Դ�)����ʶ��͸��ٵĹ���
%��������ʾ

%��һ�����������-----------------------------------------------------
%ʵ��Ӧ���У���ҿ��԰Ѷ�ȡ��avi�ļ������������ʵʱ���ݵĻ�ȡ��
% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the detector.
videoFileReader = vision.VideoFileReader('visionface.avi');
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame);

% Draw the returned bounding box around the detected face.
boxInserter  = vision.ShapeInserter('BorderColor','Custom',...
    'CustomBorderColor',[255 255 0]);
videoOut = step(boxInserter, videoFrame,bbox);
figure, imshow(videoOut), title('Detected face');

%�ڶ������Ӽ�⵽����������ȡ��Ҫ�����������ڵ�����������׷��ʹ��---------
%�����棬���ǰ�rgbͼ��ת����HSVͼ��
% Get the skin tone information by extracting the Hue from the video frame
% converted to the HSV color space.
[hueChannel,~,~] = rgb2hsv(videoFrame);

% Display the Hue Channel data and draw the bounding box around the face.
figure, imshow(hueChannel), title('Hue channel data');
rectangle('Position',bbox(1,:),'LineWidth',2,'EdgeColor',[1 1 0])

%������������׷��------------------------------------------------------
% Detect the nose within the face region. The nose provides a more accurate
% measure of the skin tone because it does not contain any background
% pixels.
noseDetector = vision.CascadeObjectDetector('Nose');
faceImage    = imcrop(videoFrame,bbox);
noseBBox     = step(noseDetector,faceImage);

% The nose bounding box is defined relative to the cropped face image.
% Adjust the nose bounding box so that it is relative to the original video
% frame.
noseBBox(1:2) = noseBBox(1:2) + bbox(1:2);

% Create a tracker object.
tracker = vision.HistogramBasedTracker;

% Initialize the tracker histogram using the Hue channel pixels from the
% nose.
initializeObject(tracker, hueChannel, noseBBox);

% Create a video player object for displaying video frames.
videoInfo    = info(videoFileReader);
videoPlayer  = vision.VideoPlayer('Position',[300 300 videoInfo.VideoSize+30]);

% Track the face over successive video frames until the video is finished.
while ~isDone(videoFileReader)

    % Extract the next video frame
    videoFrame = step(videoFileReader);

    % RGB -> HSV
    [hueChannel,~,~] = rgb2hsv(videoFrame);

    % Track using the Hue channel data
    bbox = step(tracker, hueChannel);

    % Insert a bounding box around the object being tracked
    videoOut = step(boxInserter, videoFrame, bbox);

    % Display the annotated video frame using the video player object
    step(videoPlayer, videoOut);

end

% Release resources
release(videoFileReader);
release(videoPlayer);
