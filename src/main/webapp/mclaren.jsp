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
      <link rel="stylesheet" href="brand-mclaren.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
      <jsp:include page="WEB-INF/fragments/header.jsp" />
  <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/mclaren-home.mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">GAMMA</h3>
				<h1 class="home__title">MCLAREN</h1>
				</div>
				  </section>
				  
				  
				  <!--==========================  INFO========================= -->
				  <section class="info section" id="info">
				  <span class="section__subtitle">DESIGN CHE CORRE</span>
				  <h2 class="section__title info__title"> 
				  	MCLAREN P1<br>
				  
				  </h2>
				  <div class="info__container container grid">
				  <div class="info__content">
				  <h1 class="info__number">P1</h1>
				  <img src="images/mclaren-info (1) (1)-Photoroom.png" alt="mclaren" class="info__img">
				  
				  </div>
				  <div class="info__data">
				  <div class="info__group">
				  <h3>POTENZA (KW)</h3>
				  <p>900CV (674KW) <br>8.250 giri/min </p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>MAX. VELOCITÀ</h3>
				  <p>350 km/h</p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>0-100 KM/H</h3>
				  <p>2.5 - 2.6s</p>
				  
				  
				  </div>
				  
				  </div>
				  </div>
				  
				  </section>
				  
				  
				  
				  
				  
				  
				 <section class="about section" id="about">
            <div class="about__container container grid">
            <div class="about__data" >
            <h2 class="section__title about__title">
           FUTURO<br>
            
            <span>DISTINZIONE</span>
          <br>  PASSIONE
            </h2>
            <p class="about__description">
DA FASTMOTORS, OGNI MCLAREN È UN'OPERA D'ARTE MECCANICA, UNA FUSIONE PERFETTA DI TECNOLOGIA AVANZATA, DESIGN INNOVATIVO E PERFORMANCE SENZA COMPROMESSI. FONDATA NEL 1963 DAL VISIONARIO PILOTA NEOZELANDESE BRUCE MCLAREN, LA CASA HA INIZIATO COME TEAM DI CORSE, CONQUISTANDO IL PRIMO GRAN PREMIO NEL 1968 E DOMINANDO IL CAMPIONATO CAN-AM DAL 1967 AL 1971.
)

NEL 1985, LA MCLAREN AUTOMOTIVE È STATA CREATA PER TRASFORMARE L'ESPERIENZA DI CORSA IN UN'ESPERIENZA STRADALE, CON LA PRODUZIONE DELLA MERCEDES-BENZ SLR MCLAREN. NEL 2010, L'AZIENDA È DIVENTATA INDIPENDENTE, LANCIARE LA MP4-12C E DANDO VITA A UNA NUOVA ERA DI SUPERCAR.
)

OGGI, DA FASTMOTORS, OFFRIAMO UNA SELEZIONE DI MCLAREN CHE RAPPRESENTA QUESTO EREDITÀ: MODELLI CHE UNISCONO INNOVAZIONE, PERFORMANCE E DESIGN, PER CHI CERCA NON SOLO UN'AUTO, MA UN'ESPERIENZA UNICA E INDIMENTICABILE.RESENTE O IL FUTURO DI PORSCHE… QUI LO TROVI.
             </p>
             
             <a href="catalogo.jsp#mclaren" class="button button__ghost"> 
              LE NOSTRE MCLAREN <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/mclaren-about.mp4" autoplay loop muted class="about__file"></video>
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