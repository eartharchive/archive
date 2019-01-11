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

    
    var globeSize = (1000-window.scrollY) / 1000
    var globeTranslate = 0
    console.log(globeSize);
    if(globeSize > 1){
      globeSize = 1
    }
    if(globeSize < 0.7){
      globeSize = 0.7
    }

    if(window.scrollY <= 300){
      globeTranslate = window.scrollY
    }else{
      globeTranslate = 300
    }

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



