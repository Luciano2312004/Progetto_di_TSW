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
      <link rel="stylesheet" href="brand-ferrari.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
        <jsp:include page="WEB-INF/fragments/header.jsp" />
  <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/12698128_4070_2160_24fps.mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">GAMMA</h3>
				<h1 class="home__title"> FERRARI</h1>
				</div>
				  </section>
				  
				  
				  <!--==========================  INFO========================= -->
				  <section class="info section" id="info">
				  <span class="section__subtitle">IL MITO DEL CAVALLINO RAMPANTE</span>
				  <h2 class="section__title info__title"> 
				  LA FERRARI <br>
				  
				  </h2>
				  <div class="info__container container grid">
				  <div class="info__content">
				  <h1 class="info__number">LA FERRARI</h1>
				  <img src="images/ferrari-info (2).png" alt="la ferrari" class="info__img">
				  
				  </div>
				  <div class="info__data">
				  <div class="info__group">
				  <h3>POTENZA (KW)</h3>
				  <p><span class="info__num" data-target="900">0</span>CV (120KW) <br>9.500 giri/min </p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>MAX. VELOCITÀ</h3>
				  <p><span class="info__num" data-target="370">0</span> km/h</p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>0-100 KM/H</h3>
				  <p><span class="info__num" data-target="2.4">0</span> - 2.5s</p>
				  
				  
				  </div>
				  
				  </div>
				  </div>
				  
				  </section>
				  
				  
				  
				  
				  
				  
				 <section class="about section" id="about">
            <div class="about__container container grid">
            <div class="about__data" >
            <h2 class="section__title about__title">
            VELOCITÀ  <br>
            
            <span> PASSIONE</span>
          <br>  ELEGANZA
            </h2>
            <p class="about__description">
         DA FASTMOTORS, OGNI FERRARI È PIÙ DI UN'AUTO: È UN CAPOLAVORO DI INGEGNERIA, DESIGN E EMOZIONE. FONDATA DA ENZO FERRARI NEL 1939, LA CASA DI MARANELLO HA SCRITTO LA STORIA DELLE CORSE AUTOMOBILISTICHE E DEL LUSSO SU QUATTRO RUOTE, DIVENTANDO UN SIMBOLO MONDIALE DI PRESTAZIONI, INNOVAZIONE E STILE SENZA TEMPO.

CON UNA SELEZIONE ESCLUSIVA DI MODELLI NUOVI E PRE-OWNED, OFFRIAMO UN'ESPERIENZA SU MISURA PER OGNI APPASSIONATO DEL CAVALLINO RAMPANTE. IL NOSTRO TEAM DI ESPERTI, CON ANNI DI ESPERIENZA NEL MONDO FERRARI, È PRONTO A GUIDARTI NELLA SCELTA DEL TUO PROSSIMO SOGNO SU QUATTRO RUOTE.

VISITA FASTMOTORS E SCOPRI COME LA PASSIONE, LA STORIA E LA LEGGENDA DI FERRARI POSSONO DIVENTARE REALTÀ PER TE.
            
            
             </p>
             
             <a href="catalogo.jsp#ferrari" class="button button__ghost"> 
              LE NOSTRE FERRARI <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/13684277_3840_2160_24fps.mp4" autoplay loop muted class="about__file"></video>
            </div>
            </div>
         </section>
         
         
         </main>
         
         
           <jsp:include page="WEB-INF/fragments/footer.jsp" />
      <script src="scrollreveal.min.js"></script>
          <script src="brand.js">
      
</script>

   </body>
</html>