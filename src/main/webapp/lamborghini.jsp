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
      <link rel="stylesheet" href="brand-lamborghini.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
      <jsp:include page="WEB-INF/fragments/header.jsp" />
  <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/lamborghini-home - Realizzato con Clipchamp (2).mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">GAMMA</h3>
				<h1 class="home__title">LAMBORGHINI</h1>
				</div>
				  </section>
				  
				  
				  <!--==========================  INFO========================= -->
				  <section class="info section" id="info">
				  <span class="section__subtitle">ADRENALINA SENZA LIMITI</span>
				  <h2 class="section__title info__title"> 
				  VENENO <br>
				  
				  </h2>
				  <div class="info__container container grid">
				  <div class="info__content">
				  <h1 class="info__number">VENENO</h1>
				  <img src="images/lamborghini-info.png" alt="lamborghini" class="info__img">
				  
				  </div>
				  <div class="info__data">
				  <div class="info__group">
				  <h3>POTENZA (KW)</h3>
				  <p><span class="info__num" data-target="750">0</span>CV (552KW) <br>8.250 giri/min </p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>MAX. VELOCITÀ</h3>
				  <p><span class="info__num" data-target="355">0</span> km/h</p>
				  
				  
				  </div>
				  
				   <div class="info__group">
				  <h3>0-100 KM/H</h3>
				  <p><span class="info__num" data-target="2.8">0</span> - 2.9s</p>
				  
				  
				  </div>
				  
				  </div>
				  </div>
				  
				  </section>
				  
				  
				  
				  
				  
				  
				 <section class="about section" id="about">
            <div class="about__container container grid">
            <div class="about__data" >
            <h2 class="section__title about__title">
           POTENZA <br>
            
            <span> AUDACIA</span>
          <br>  ESCLUSIVITÀ
            </h2>
            <p class="about__description">
         DA FASTMOTORS, OGNI LAMBORGHINI NON È SOLO UNA VETTURA: È UNA LEGGENDA SU RUOTE, UNA FUSIONE PERFETTA DI DESIGN AUDACE, PRESTAZIONI STRAORDINARIE E SPIRITO RIVOLUZIONARIO. FONDATA DA FERRUCCIO LAMBORGHINI NEL 1963 A SANT’AGATA BOLOGNESE, LA CASA DEL TORO NASCE DALL’ESIGENZA DI CREARE NON SEMPLICI AUTOMOBILI, MA CAPOLAVORI CAPACI DI SUPERARE OGNI LIMITE.

DALLE ORIGINI NEI TRATTORI AGRICOLI, FINO ALLA MIURA DEL 1966 CHE RIDEFINÌ IL CONCETTO DI SUPERCAR, LAMBORGHINI HA SEMPRE OPERATO UNA SCELTA DI ROTTURA: INNOVAZIONE TECNICA, MOTORI A V12, FORME RITUALI, NOMI ISPIRATI AL TORO, FORTE, IMPETUOSO E SELVAGGIO COME IL SEGNO ZODIACALE DEL SUO FONDATORE.

OGGI DA FASTMOTORS TI OFFRIAMO UNA SELEZIONE LAMBORGHINI CHE RAPPRESENTA QUESTA EREDITÀ: MODELLI NUOVI E ICONICI CHE UNISCONO POTENZA PURA, PRESENZA SCENICA E QUEL DNA CHE FA BATTERE FORTE IL CUORE DI OGNI AMANTE DELLE QUATTRO RUOTE. IL NOSTRO TEAM È PRONTO A GUIDARTI NELLA SCELTA DI UN SOGNO CHE NON È SOLO GUIDA, MA ESPERIENZA, DISTINZIONE, AUDACIA.
            
             </p>
             
             <a href="catalogo.jsp#lamborghini" class="button button__ghost"> 
              LE NOSTRE LAMBORGHINI <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/14052063-hd_1920_1080_25fps.mp4" autoplay loop muted class="about__file"></video>
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