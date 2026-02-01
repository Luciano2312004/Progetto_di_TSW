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
  

      <!--=============== CSS ===============-->
      <link rel="stylesheet" href="brand-bugatti.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
       <jsp:include page="WEB-INF/fragments/header.jsp" />
  <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/bugatti-home.mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">GAMMA</h3>
				<h1 class="home__title">BUGATTI</h1>
				</div>
				  </section>
				  
				  
				  <!--==========================  INFO========================= -->
				  <section class="info section" id="info">
				  <span class="section__subtitle">L'ELEGANZA INCONTRA L'ADRENALINA</span>
				  <h2 class="section__title info__title"> 
				  BUGATTI CHIRON <br>
				  
				  </h2>
				  <div class="info__container container grid">
				  <div class="info__content">
				  <h1 class="info__number">CHIRON</h1>
				  <img src="images/bugatti-info-Photoroom.png" alt="regera" class="info__img">
				  
				  </div>
				  <div class="info__data">
				  <div class="info__group">
				  <h3>POTENZA (KW)</h3>
				  <p><span class="info__num" data-target="1500">0</span>CV (1103KW) <br>6700 giri/min </p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>MAX. VELOCITÀ</h3>
				  <p><span class="info__num" data-target="400">0</span> km/h</p>
				  
				  
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
            ICONA  <br>
            
            <span> PRESTIGIO</span>
          <br>  LUSSO
            </h2>
            <p class="about__description">
        BUGATTI È UN’ICONA MONDIALE DELL’AUTOMOTIVE, SINO NELLE SUE RADICI ARTIGIANALI. FONDATA NEL 1909 DA ETTORE BUGATTI A MOLSHEIM, IN ALSAZIA, LA CASA AUTOMOBILISTICA SI DISTINGUE PER L’UNIONE PERFETTA TRA INGEGNERIA AVANZATA, DESIGN RAFFINATO E PRESTAZIONI ESTREME. NEI PRIMI DECENNI DEL NOVECENTO, LE AUTO BUGATTI DOMINAVANO LE COMPETIZIONI, CON MODELLI LEGGENDARI COME LA TYPE 35. OGGI, SOTTO LA GUIDA DI VOLKSWAGEN, BUGATTI CREA SUPERCAR COME LA VEYRON, LA CHIRON E LA DIVO, SIMBOLI DI LUSSO, POTENZA E TECNOLOGIA SENZA COMPROMESSI. SU FASTMOTORS, OFFRIAMO QUESTE AUTO ESCLUSIVE A CHI DESIDERA IL MASSIMO, DALLA STORIA LEGGENDAIA ALLE PRESTAZIONI DEL FUTURO, PER UN’ESPERIENZA DI GUIDA UNICA E INIMITABILE.
            
             </p>
             
             <a href="catalogo.jsp#bugatti" class="button button__ghost"> 
              LE NOSTRE BUGATTI <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/bugatti-about.mp4" autoplay loop muted class="about__file"></video>
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