<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <html lang="en">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <!--=============== FAVICON ===============-->
      <link rel="shortcut icon" href="assets/img/favicon.png" type="image/x-icon">

      <!--=============== REMIXICONS ===============-->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">

      <!--=============== SWIPER CSS ===============-->
      <link rel="stylesheet" href="swiper-bundle.min.css">

      <!--=============== CSS ===============-->
      <link rel="stylesheet" href="brand-porsche.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
       <jsp:include page="WEB-INF/fragments/header.jsp" />
  <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/porsche-home.mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">GAMMA</h3>
				<h1 class="home__title">PORSCHE</h1>
				</div>
				  </section>
				  
				  
				  <!--==========================  INFO========================= -->
				  <section class="info section" id="info">
				  <span class="section__subtitle">IL MITO SENZA TEMPO</span>
				  <h2 class="section__title info__title"> 
				  	PORSCHE 918 <br>
				  
				  </h2>
				  <div class="info__container container grid">
				  <div class="info__content">
				  <h1 class="info__number">918</h1>
				  <img src="images/porsche-info (2).png" alt="porsche" class="info__img">
				  
				  </div>
				  <div class="info__data">
				  <div class="info__group">
				  <h3>POTENZA (KW)</h3>
				  <p>620CV (652KW) <br>8.250 giri/min </p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>MAX. VELOCITÀ</h3>
				  <p>345 km/h</p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>0-100 KM/H</h3>
				  <p>2.6 - 2.7s</p>
				  
				  
				  </div>
				  
				  </div>
				  </div>
				  
				  </section>
				  
				  
				  
				  
				  
				  
				 <section class="about section" id="about">
            <div class="about__container container grid">
            <div class="about__data" >
            <h2 class="section__title about__title">
           ICONA <br>
            
            <span>TRADIZIONE</span>
          <br>  AVANGUARDIA
            </h2>
            <p class="about__description">
     DA FASTMOTORS, OGNI PORSCHE NON È SOLO UN’AUTO: È UN’ICONA CHE UNISCE ANIMA TEDESCA, PRECISIONE MILLIMETRICA E PASSIONE PURA. FONDATA DA FERDINAND PORSCHE NEL 1931 COME STUDIO DI INGEGNERIA A STOCCARDA, LA CASA ASPIRAVA A CREARE VEICOLI CHE SUPERASSERO I LIMITI DELL’INNOVAZIONE.

NEL 1948 NASCE LA PRIMA PORSCHE A PORTARE IL NOME DEL BRAND: LA 356 “NO. 1” ROADSTER, CREATA CON CURA ARTIGIANALE, LEGGEREZZA E SPIRITO CORSAIOLO. È DA QUEL MOMENTO CHE OGNI MODELLO È DIVENTATO SIMBOLO DI PERFORMANCE, AFFIDABILITÀ E DESIGN SENZA TEMPO.

OGGI DA FASTMOTORS TI OFFRIAMO LA QUINTESSENZA DI QUESTA EREDITÀ: MODELLI CHE HANNO FATTO LA STORIA, ACCANTO ALLE ULTIME NOVITÀ CHE MANTENGONO VIVO IL DNA PORSCHE. PER CHI NON CERCA SOLO GUIDA, MA EMOZIONE, DISTINZIONE, PRECISIONE. SE VUOI IL PASSATO, IL PRESENTE O IL FUTURO DI PORSCHE… QUI LO TROVI.
             </p>
             
             <a href="catalogo.jsp#porsche" class="button button__ghost"> 
              LE NOSTRE PORSCHE <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/porsche-about.mp4" autoplay loop muted class="about__file"></video>
            </div>
            </div>
         </section>
         
         
         </main>
         
         
           <jsp:include page="footer.jsp" />
      <script src="scrollreveal.min.js"></script>
          <script src="brand.js">
      
</script>

   </body>
</html>