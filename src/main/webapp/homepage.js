


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


/*=============== SHOW SCROLL UP ===============*/ 


/*=============== SCROLL SECTIONS ACTIVE LINK ===============*/


/*=============== SCROLL REVEAL ANIMATION ===============*/

const sr= ScrollReveal({
	
	origin: 'top',
	distance:'60px',
	duration: 2000,
	delay:300,
	
	
	
})




sr.reveal('.home__swiper', {origin: 'right', distance: '300px', delay: 800})

sr.reveal('.home__data', {origin: 'bottom', distance: '120px', delay: 1600})

sr.reveal('.swiper-pagination-bullet', {origin: 'top', delay: 1800, opacity:0})
sr.reveal('.home__button', {origin: 'top', delay: 2200})
sr.reveal('.about__data, .contact__content', {origin: 'left'})
sr.reveal('.about__video, .contact__img', {origin: 'right'})
sr.reveal('.models__card', {interval:100})
sr.reveal('.footer__container')