import TweenLite from "gsap";

var globeDrop = 250;

function setGlobeDrop() {
  if (window.innerWidth >= 768) {
    globeDrop = 250;
  } else {
    globeDrop = 250;
  }
}

function animateGlobe() {
  TweenLite.to(".globe", 1, {
    y: globeDrop, //490
    rotation: 180
  });
}

setGlobeDrop()
animateGlobe();

