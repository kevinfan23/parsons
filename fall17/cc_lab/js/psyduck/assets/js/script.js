var replies = ["Yes", "No", "How should I know?", "Feed me and then I'll tell you", "Maybe"];
var sound = ["yes", "no", "how", "feed me", "maybe"];
var randumNum = 0;
var randomEyes = 0;
var audioElement;


$(document).ready(function(){
  init();
});


function init(){
  //console.log("Hello world");
  audioElement = document.createElement('audio');

  $("#submit").click(function(){
    answerQuestion();
  });
}

function answerQuestion(){
  randomNum = randomNumGenerator(replies);
  console.log("Random reply" + randomNum);

  $('#speech').text(replies[randomNum]);
  playSounds(randomNum);
  randomEyes = randomNumGenerator(eyes);
  $("#eyes").css("background", "url('../img/" + eyes
  [randomEyes] + ".png)'  no-repeat");
  $("#eyes").css("background-size", "100% auto");
}

function playSounds(index){
  audioElement.setAttribute('src',"assets/sound/" + sound[index] + ".mp3");
  audioElement.play();
}

function randomNumGenerator(arrayName){
  return Math.floor(Math.random() * arrayName.length);
}
