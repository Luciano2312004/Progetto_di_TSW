/*=============== SHOW MENU ===============*/
const navMenu = document.getElementById('nav-menu'),
      navToggle = document.getElementById('nav-toggle'),
      navClose = document.getElementById('nav-close')

/* Menu show */
if(navToggle){
    navToggle.addEventListener('click', () =>{
        navMenu.classList.add('show-menu')
    })
}

/* Menu hidden */
if(navClose){
    navClose.addEventListener('click', () =>{
        navMenu.classList.remove('show-menu')
    })
}

/*=============== REMOVE MENU MOBILE ===============*/


/*=============== SWIPER HOME ===============*/ 
const swiperHome = new Swiper('.home__swiper', {
	pagination: {
	        el: ".swiper-pagination",
	        clickable: true,
	        renderBullet:  (index, className) => {
	          return '<span class="' + className + '">' + String(index + 1).padStart(2, '0') + "</span>";
	        },
	      },
		  
		
})

/*=============== CHANGE BACKGROUND HEADER ===============*/

const bgHeader = () =>{
    const header = document.getElementById('header')
    // Add a class if the bottom offset is greater than 50 of the viewport
    this.scrollY >= 50 ? header.classList.add('bg-header') 
                       : header.classList.remove('bg-header')
}
window.addEventListener('scroll', bgHeader)
/*=============== SHOW SCROLL UP ===============*/ 


/*=============== SCROLL SECTIONS ACTIVE LINK ===============*/


/*=============== SCROLL REVEAL ANIMATION ===============*/

const sr= ScrollReveal({
	
	origin: 'top',
	distance:'60px',
	duration: 2000,
	delay:300,
	
	
	
})


const userIcon = document.getElementById('userIcon');
const userDropdown = document.getElementById('userDropdown');

if (userIcon && userDropdown) {
    userIcon.addEventListener('click', () => {
        userDropdown.style.display = userDropdown.style.display === 'block' ? 'none' : 'block';
    });

    // Chiudi cliccando fuori
    document.addEventListener('click', (e) => {
        if (!userIcon.contains(e.target) && !userDropdown.contains(e.target)) {
            userDropdown.style.display = 'none';
        }
    });
}


sr.reveal('.home__swiper', {origin: 'right', distance: '300px', delay: 800})

sr.reveal('.home__data', {origin: 'bottom', distance: '120px', delay: 1600})

sr.reveal('.swiper-pagination-bullet', {origin: 'top', delay: 1800, opacity:0})
sr.reveal('.home__button', {origin: 'top', delay: 2200})
sr.reveal('.about__data, .contact__content', {origin: 'left'})
sr.reveal('.about__video, .contact__img', {origin: 'right'})
sr.reveal('.models__card', {interval:100})
sr.reveal('.footer__container')