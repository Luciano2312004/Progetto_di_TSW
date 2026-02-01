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

      
  

      <!--=============== CSS ===============-->
      <link rel="stylesheet" href="brand-koenigsegg.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
     <jsp:include page="WEB-INF/fragments/header.jsp" />
  <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/KOENIGSEGG-HOME.mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">GAMMA</h3>
				<h1 class="home__title">KOENIGSEGG</h1>
				</div>
				  </section>
				  
				  
				  <!--==========================  INFO========================= -->
				  <section class="info section" id="info">
				  <span class="section__subtitle">DOVE L'INNOVAZIONE INCONTRA LA VELOCITÀ PURA</span>
				  <h2 class="section__title info__title"> 
				  REGERA <br>
				  
				  </h2>
				  <div class="info__container container grid">
				  <div class="info__content">
				  <h1 class="info__number">REGERA</h1>
				  <img src="images/KOENIGSEGG-INFO (1)-Photoroom.png" alt="regera" class="info__img">
				  
				  </div>
				  <div class="info__data">
				  <div class="info__group">
				  <h3>POTENZA (KW)</h3>
				  <p>1500CV (1100KW) <br>8250 giri/min </p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>MAX. VELOCITÀ</h3>
				  <p>403 km/h</p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>0-100 KM/H</h3>
				  <p>2.7 - 2.8s</p>
				  
				  
				  </div>
				  
				  </div>
				  </div>
				  
				  </section>
				  
				  
				  
				  
				  
				  
				 <section class="about section" id="about">
            <div class="about__container container grid">
            <div class="about__data" >
            <h2 class="section__title about__title">
            RICERCA  <br>
            
            <span> POTENZA</span>
          <br>  DESIGN
            </h2>
            <p class="about__description">
         KOENIGSEGG È SINONIMO DI INNOVAZIONE, VELOCITÀ ESTREMA E ARTIGIANALITÀ SENZA COMPROMESSI. FONDATA NEL 1994 IN SVEZIA DA CHRISTIAN VON KOENIGSEGG, L’AZIENDA NASCE DAL SOGNO DI CREARE LA SUPERSPORTIVA DEFINITIVA, UNENDO TECNOLOGIA AVANZATA, DESIGN UNICO E PRESTAZIONI IMPRESSIONANTI. OGNI MODELLO, DALLE PRIME CCR E CCX FINO ALLE ICONICHE AGERA, REGERA E JESKO, È UN CAPOLAVORO COSTRUITO A MANO, PENSATO PER SUPERARE I LIMITI DELL’AUTOMOTIVE. OGGI KOENIGSEGG NON È SOLO UN MARCHIO DI AUTO, MA UN SIMBOLO DI ECCELLENZA ASSOLUTA, RICERCA SENZA FINE E PASSIONE PURA PER LA GUIDA. SU FASTMOTORS TROVI QUESTI GIOIELLI DESTINATI A CHI DESIDERA IL MASSIMO, SENZA ACCETTARE COMPROMESSI.VENTARE REALTÀ PER TE.
            
            
             </p>
             
             <a href="catalogo.jsp#koenigsegg" class="button button__ghost"> 
              LE NOSTRE KOENIGSEGG <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/koenigsegg.mp4" autoplay loop muted class="about__file"></video>
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