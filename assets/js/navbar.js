import TweenLite from 'gsap'

var menuBtn = document.getElementById('menu-toggle-btn')

menuBtn.addEventListener('click', toggleMenu, false)

var btnScale = 0
var btnRotation = 0
var overlayScale = 0
var menuVisible = false


function toggleMenu() {
  
  TweenLite.to('#close-menu-btn', .2, {
    scale: Math.abs(btnScale - 1),
    rotation: Math.abs(btnRotation - 180),
    display: 'inline-flex'
  })

  TweenLite.to('#burger-menu-btn', .2, {
    scale: btnScale,
  })

  btnScale = Math.abs(btnScale - 1)
  btnRotation = Math.abs(btnRotation - 180)

  overlayScale = Math.abs(overlayScale - 100 ) ;
  TweenLite.to('.menu-overlay', .4, {
    scale: overlayScale,
  })

  var menu = document.getElementById('menu')

  if(!menuVisible){
    menu.style.display = 'block'
  }else{
    menu.style.display = 'none'
  }
  menuVisible = !menuVisible
}