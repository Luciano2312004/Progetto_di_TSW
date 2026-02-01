function startCounting(element) {
    // Legge il numero finale dall'attributo data-target dell'HTML
    const target = parseFloat(element.getAttribute('data-target'));
    let start = 0;
    
    // Impostazioni per la velocità dell'animazione
    // Se è un numero decimale piccolo (come 2.4s)
    if (target < 10 && target % 1 !== 0) {
        let decimalStart = 0.0;
        let timer = setInterval(() => {
            decimalStart += 0.1;
            // .toFixed(1) assicura che mostri solo un decimale (es. 1.2)
            element.textContent = decimalStart.toFixed(1);
            if (decimalStart >= target) {
                element.textContent = target;
                clearInterval(timer);
            }
        }, 80); // Velocità per i decimali

    } else {
        // Se è un numero intero grande (come 900 o 370)
        // Calcoliamo un incremento dinamico per farli finire più o meno nello stesso tempo
        let increment = Math.ceil(target / 40); 
        let timer = setInterval(() => {
            start += increment;
            element.textContent = start;
            if (start >= target) {
                element.textContent = target;
                clearInterval(timer);
            }
        }, 40); // Velocità per gli interi
    }
}

/*=============== REMOVE MENU MOBILE ===============*/


/*=============== SWIPER HOME ===============*/ 

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
sr.reveal('.info__group', {
    origin: 'bottom',
    interval: 150, // Ritardo tra la comparsa di un gruppo e l'altro
    delay: 1000,
    // QUESTO È IL PUNTO CHIAVE: afterReveal
    // Dice a ScrollReveal: "Dopo che hai fatto apparire l'elemento, esegui questa funzione"
    afterReveal: function (el) {
        // Trova lo span con il numero dentro questo gruppo specifico
        const numSpan = el.querySelector('.info__num');
        // Se esiste, fai partire il conteggio
        if (numSpan) {
            startCounting(numSpan);
        }
    }
});
sr.reveal('.info__img', {
    origin: 'left', 
    distance: '150px', 
    duration: 2000,
    delay: 300 
});

sr.reveal('.home__swiper', {origin: 'right', distance: '300px', delay: 800})
sr.reveal('.home__data', {origin: 'bottom', distance: '120px', delay: 1600})
sr.reveal('.swiper-pagination-bullet', {origin: 'top', delay: 1800, opacity:0})
sr.reveal('.home__button', {origin: 'top', delay: 2200})
sr.reveal('.about__data, .contact__content', {origin: 'left'})
sr.reveal('.about__video, .contact__img', {origin: 'right'})
sr.reveal('.models__card', {interval:100})
sr.reveal('.info__img', {distance: '120px'});
sr.reveal('.info__number', {origin:'bottom', distance: '80px', delay:800});
sr.reveal('.info__group', {interval:100, delay:1300});
sr.reveal('.footer__container')

