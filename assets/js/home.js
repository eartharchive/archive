import TweenLite from "gsap";

const landing = document.getElementById('landing');

if (landing) {
  const globe = document.getElementById('globe');
  window.addEventListener( 'scroll', function() {
    console.log(window.scrollY);
    // adjust size of element top when scroll more than ...
    //globe.style.width = 
    globe.style.transform = "translate(0px, " + window.scrollY + "px);";

  });

  let globeDrop = 250;

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

}



