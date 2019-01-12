//import TweenLite from "gsap";

const landing = document.getElementById('landing');

if (landing) {
  const globe = document.getElementById('globe');
  const folder = document.getElementById('folder')
  window.addEventListener( 'scroll', function() {
    console.log(window.scrollY);
    // adjust size of element top when scroll more than ...
    //globe.style.width = 
    //globe.style.transform = "translate(0px, " + window.scrollY + "px);";

    var translateThreshold = 300
    var scaleThreshold = 0.7
    var translateScaleFactor = 1000

    if(window.innerWidth <= 470){
      translateThreshold = 280
      scaleThreshold = 0.55
      translateScaleFactor = 600
    }
    if(window.innerWidth <= 430){
      translateThreshold = 230
      scaleThreshold = 0.5
      translateScaleFactor = 400
    }
    if(window.innerWidth <= 340){
      translateThreshold = 190
      scaleThreshold = 0.5
      translateScaleFactor = 400
    }

    
    var globeSize = (translateScaleFactor-window.scrollY) / translateScaleFactor
    var globeTranslate = 0
    console.log(globeSize);
    if(globeSize > 1){
      globeSize = 1
    }
    if(globeSize < scaleThreshold){
      globeSize = scaleThreshold
    }
    
    

    window.scrollY <= translateThreshold ? globeTranslate = window.scrollY : globeTranslate = translateThreshold


    var translateVal =  "translateY(" + globeTranslate + "px)";

    if(globeTranslate > 290){
      folder.classList.add('opacityTransition')
    }

    

    var scaleVal = " scale(" + globeSize + ")"

    globe.style.transform = translateVal + scaleVal
    globe.style.msTransform = translateVal + scaleVal
    globe.style.webkitTransform = translateVal + scaleVal
  });

  // let globeDrop = 250;

  // function setGlobeDrop() {
  //   if (window.innerWidth >= 768) {
  //     globeDrop = 250;
  //   } else {
  //     globeDrop = 250;
  //   }
  // }

  // function animateGlobe() {
  //   TweenLite.to(".globe", 1, {
  //     y: globeDrop, //490
  //     rotation: 180
  //   });
  // }

  // setGlobeDrop()
  // animateGlobe();

}



