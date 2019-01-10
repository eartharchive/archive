// import TweenLite from 'gsap'

// const navBar = document.getElementById('navBar');

// if (navBar) {
//   const menuBtn = document.getElementById('menu-toggle-btn')

//   menuBtn.addEventListener('click', toggleMenu, false)

//   let btnScale = 0
//   let btnRotation = 0
//   let overlayScale = 0
//   let menuVisible = false


//   function toggleMenu() {

//     TweenLite.to('#close-menu-btn', .2, {
//       scale: Math.abs(btnScale - 1),
//       rotation: Math.abs(btnRotation - 180),
//       display: 'inline-flex'
//     })

//     TweenLite.to('#burger-menu-btn', .2, {
//       scale: btnScale,
//     })

//     btnScale = Math.abs(btnScale - 1)
//     btnRotation = Math.abs(btnRotation - 180)

//     overlayScale = Math.abs(overlayScale - 100);
//     TweenLite.to('.menu-overlay', .4, {
//       scale: overlayScale,
//     })

//     const menu = document.getElementById('menu')

//     if (!menuVisible) {
//       menu.style.display = 'block'
//     } else {
//       menu.style.display = 'none'
//     }
//     menuVisible = !menuVisible
//   }

// }

document.addEventListener('DOMContentLoaded', function () {

  // Get all "navbar-burger" elements
  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.burger'), 0);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {
      console.log("we have burger")

    // Add a click event on each of them
    $navbarBurgers.forEach(function ($el) {
      $el.addEventListener('click', function () {

        // Get the target from the "data-target" attribute
        var target = $el.dataset.target;
        var $target = document.getElementById(target);

        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
        $el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      });
    });
  }

});
