import * as posenet from '@tensorflow-models/posenet';
import dat from 'dat.gui';

import {drawBoundingBox, drawKeypoints, drawSkeleton} from './demo_util';

const videoWidth = 300;
const videoHeight = 250;

function isAndroid() {
  return /Android/i.test(navigator.userAgent);
}

function isiOS() {
  return /iPhone|iPad|iPod/i.test(navigator.userAgent);
}

function isMobile() {
  return isAndroid() || isiOS();
}

/**
 * Loads a the camera to be used in the demo
 *
 */
async function setupCamera() {
  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    throw new Error(
        'Browser API navigator.mediaDevices.getUserMedia not available');
  }

  const video = document.getElementById('video');
  video.width = videoWidth;
  video.height = videoHeight;

  const mobile = isMobile();
  const stream = await navigator.mediaDevices.getUserMedia({
    'audio': false,
    'video': {
      facingMode: 'user',
      width: mobile ? undefined : videoWidth,
      height: mobile ? undefined : videoHeight,
    },
  });
  video.srcObject = stream;

  return new Promise((resolve) => {
    video.onloadedmetadata = () => {
      resolve(video);
    };
  });
}

async function loadVideo() {
  const video = await setupCamera();
  video.play();

  return video;
}

const guiState = {
  algorithm: 'single-pose',
  input: {
    mobileNetArchitecture: isMobile() ? '0.50' : '0.75',
    outputStride: 16,
    imageScaleFactor: 0.5,
  },
  singlePoseDetection: {
    minPoseConfidence: 0.1,
    minPartConfidence: 0.5,
  },
  output: {
    showVideo: true,
    showSkeleton: true,
    showPoints: true,
    showBoundingBox: false,
  },
  net: null,
};

/**
 * Sets up dat.gui controller on the top-right of the window
 */
function setupGui(cameras, net) {
  guiState.net = net;

  if (cameras.length > 0) {
    guiState.camera = cameras[0].deviceId;
  }
}

/**
 * Feeds an image to posenet to estimate poses - this is where the magic
 * happens. This function loops with a requestAnimationFrame method.
 */
function detectPoseInRealTime(video, net) {
  const canvas = document.getElementById('output');
  const ctx = canvas.getContext('2d');
  // since images are being fed from a webcam
  const flipHorizontal = true;

  canvas.width = videoWidth;
  canvas.height = videoHeight;

  async function poseDetectionFrame() {
    if (guiState.changeToArchitecture) {
      // Important to purge variables and free up GPU memory
      guiState.net.dispose();

      // Load the PoseNet model weights for either the 0.50, 0.75, 1.00, or 1.01
      // version
      guiState.net = await posenet.load(+guiState.changeToArchitecture);

      guiState.changeToArchitecture = null;
    }

    // Scale an image down to a certain factor. Too large of an image will slow
    // down the GPU
    const imageScaleFactor = guiState.input.imageScaleFactor;
    const outputStride = +guiState.input.outputStride;

    let poses = [];
    let minPoseConfidence;
    let minPartConfidence;

    const pose = await guiState.net.estimateSinglePose(
        video, imageScaleFactor, flipHorizontal, outputStride);
    poses.push(pose);

    minPoseConfidence = +guiState.singlePoseDetection.minPoseConfidence;
    minPartConfidence = +guiState.singlePoseDetection.minPartConfidence;

    ctx.clearRect(0, 0, videoWidth, videoHeight);

    if (guiState.output.showVideo) {
      ctx.save();
      ctx.scale(-1, 1);
      ctx.translate(-videoWidth, 0);
      ctx.drawImage(video, 0, 0, videoWidth, videoHeight);
      ctx.restore();
    }

    // For each pose (i.e. person) detected in an image, loop through the poses
    // and draw the resulting skeleton and keypoints if over certain confidence
    // scores
    poses.forEach(({score, keypoints}) => {
      if (score >= minPoseConfidence) {
        if (guiState.output.showPoints) {
          drawKeypoints(keypoints, minPartConfidence, ctx);
        }
        if (guiState.output.showSkeleton) {
          drawSkeleton(keypoints, minPartConfidence, ctx);
        }
        if (guiState.output.showBoundingBox) {
          drawBoundingBox(keypoints, ctx);
        }
      }
    });

    // console.log(poses[0].keypoints);
    if (poses[0].keypoints) {
      // console.log(poses[0].keypoints[9].score);
      let textfield = document.getElementById('position');
      let positions = poses[0].keypoints[10].position;
      let score = poses[0].keypoints[10].score;
      if (score > .7) {
        // x: 0-300
        // y: 0-225
        let x = positions.x;
        let y = positions.y;
        let lists = document.getElementsByClassName('select');
        let selected = null;

        if (x >= 0 && x < 75 && y >= 0 && y < 112) {
          selected = 0;
        }
        else if (x >= 75 && x < 150 && y >= 0 && y < 112) {
          selected = 1;
        }
        else if (x >= 150 && x < 225 && y >= 0 && y < 112) {
          selected = 2;
        }
        else if (x >= 225 && x < 300 && y >= 0 && y < 112) {
          selected = 3;
        }
        else if (x >= 0 && x < 75 && y >= 112 && y < 225) {
          selected = 4;
        }
        else if (x >= 75 && x < 150 && y >= 112 && y < 225) {
          selected = 5;
        }
        else if (x >= 150 && x < 225 && y >= 112 && y < 225) {
          selected = 6;
        }
        else if (x >= 225 && x < 300 && y >= 112 && y < 225) {
          selected = 7;
        }
        else {
          selected = null;
        }
        textfield.innerHTML = 'selected: ' + selected + ' position x: ' + positions.x + ' position y: ' + positions.y + ' score: ' + score;

        if (selected) {
          lists[selected].classList.add('hover');
          for (let i = 0; i < lists.length; i++) {
            if (i != selected) {
              lists[i].classList.remove('hover');
            }
          }
        }

        // textfield.innerHTML = 'position x: ' + positions.x + ' position y: ' + positions.y;

        if (poses[0].keypoints[9].score > .7 && poses[0].keypoints[9].position.y < 50) {
          // textfield.innerHTML = 'detected!';
          let scroll = (positions.x - 150)/15;
          document.getElementById('scroll').scrollLeft += scroll;
          for (let i = 0; i < lists.length; i++) {
            lists[i].classList.remove('hover');
          }
        }
      }
    }

    requestAnimationFrame(poseDetectionFrame);
  }

  poseDetectionFrame();
}

/**
 * Kicks off the demo by loading the posenet model, finding and loading
 * available camera devices, and setting off the detectPoseInRealTime function.
 */
export async function bindPage() {
  // Load the PoseNet model weights with architecture 0.75
  const net = await posenet.load(0.75);

  // document.getElementById('loading').style.display = 'none';
  document.getElementById('main').style.display = 'block';

  let video;

  try {
    video = await loadVideo();
  } catch (e) {
    throw e;
  }

  setupGui([], net);
  detectPoseInRealTime(video, net);
}

navigator.getUserMedia = navigator.getUserMedia ||
    navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
// kick off the demo
bindPage();
