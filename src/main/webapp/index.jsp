<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>


<!DOCTYPE html>
   <html lang="it">
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
      <link rel="stylesheet" href="homepage.css">

      <title>Fastmotors</title>
   </head>
   <body>
      <!--==================== HEADER ====================-->
    <jsp:include page="WEB-INF/fragments/header.jsp" />
      <!--==================== MAIN ====================-->
      <main class="main">
         <!--==================== HOME ====================-->
         <section class="home grid section" id="home">
				<video src="videos/5309381-hd_1920_1080_25fps.mp4" muted loop autoplay class="home__bg"></video>
				<div class="home__gradient"> </div>
				
				<div class="home__data">
				<h3 class="home__subtitle">ACCENDI I MOTORI </h3>
				<h1 class="home__title"> FASTMOTORS 
				</h1>
				</div>
				
				
				<div class="home__swiper swiper"> 
				<div class="swiper-wrapper">
				<article class="home__article swiper-slide" >
				<a href="ferrari.jsp"><img src="images/ferrari.svg" id="ferrari" alt="ferrari" class="home__img"></a>
				
				</article>
				
				<article class="home__article swiper-slide">
				<a href="lamborghini.jsp"><img src="images/lamborghini.svg" id="lamborghini" alt="lamborghini" class="home__img"></a>
				
				</article>
				
				<article class="home__article swiper-slide">
				<a href="porsche.jsp"><img src="images/porsche.svg" id="porsche"alt="porsche" class="home__img"></a>
				
				</article>
				<article class="home__article swiper-slide">
				<a href="mclaren.jsp"><img src="images/mclaren.svg" id="mclaren" alt="mclaren" class="home__img"></a>
				
				</article>
				<article class="home__article swiper-slide">
				<a href="koenigsegg.jsp"><img src="images/koenigsegg.svg" id="koenigsegg" alt="koenigsegg" class="home__img"></a>
				
				</article>
				<article class="home__article swiper-slide">
				<a href="bugatti.jsp"><img src="images/bugatti-Photoroom.png" alt="bugatti"  id="bugatti" class="home__img"></a>
				
				</article>
				
				</div>
				
				</div>
				
				  <div class="swiper-pagination"></div>
				
				<a href="#about" class="home__button">
				<span> START</span>
				<i class="ri-arrow-down-s-line"></i></a>
         </section>

         <!--==================== ABOUT ====================-->
         <section class="about section" id="about">
            <div class="about__container container grid">
            <div class="about__data" >
            <h2 class="section__title about__title">
            ACCELLERA <br>
            <span> SUPERA</span>
          <br>  IL LIMITE
            </h2>
            <p class="about__description">
          DA FASTMOTORS CREDIAMO CHE GUIDARE NON SIA SOLO SPOSTARSI, MA VIVERE UN'ESPERIENZA ESCLUSIVA. <br> 
          LA NOSTRA MISSIONE È OFFRIRE AI NOSTRI CLIENTI IL MEGLIO DEL MONDO AUTOMOBILISTICO DI LUSSO <br>
          SELEZIONANDO CON CURA MODELLI UNICI CHE COMBINANO PRESTAZIONI, ELEGANZA E TECNOLOGIA ALL'AVANGUARDIA.  <br>
          OGNI AUTO DEL NOSTRO CATALOGO RAPPRESENTA UN SOGNO A QUATTRO RUOTE, PRONTA A TRASFORMARE LA PASSIONE PER LA GUIDA IN REALTÀ.  <br>
          CON PROFESSIONALITÀ E ATTENZIONE AI DETTAGLI, ACCOMPAGNIAMO I NOSTRI CLIENTI NELLA SCELTA DELL'AUTO PERFETTA  <br>
          RENDENDO OGNI ACQUISTO UN VIAGGIO INDIMENTICABILE
            
            
             </p>
             
             <a href="catalogo.jsp" class="button button__ghost"> 
              CATALOGO <i class="ri-arrow-right-s-line"></i>
             
             </a>
            
             
            
            </div>
            
            <div class="about__video">
            <video src="videos/about-vid.mp4" autoplay loop muted class="about__file"></video>
            </div>
            </div>
         </section>

         <!--==================== MODELS ====================-->
	<section class="models section" id="models">
    <h2 class="section__title">
        ISPIRATI DALLA <br>
        <span>PERFORMANCE</span>
    </h2>
    
    <div class="models__container container grid">
        <article class="models__card" data-marca="Bugatti" data-modello="Chiron" data-colore="Nero" data-prezzo="2400000"
            onclick="window.location.href='catalogo.jsp#bugatti'">
            <img src="images/bugatti-chiron.png" alt="bugatti divo" class="models__img"> 
            <div class="models__gradient"></div>
            <div class="models__data">
                <h3 class="models__name">Bugatti Chiron</h3>
                <span class="models__info">1500CV</span>
            </div>
        </article>
        
        <article class="models__card" data-marca="Lamborghini" data-modello="Veneno" data-colore="Grigio" data-prezzo="3900000"
            onclick="window.location.href='catalogo.jsp#lamborghini'">
            <img src="images/lamborghini-veneno.png" alt="" class="models__img"> 
            <div class="models__gradient"></div>
            <div class="models__data">
                <h3 class="models__name">Lamborghini Veneno</h3>
                <span class="models__info">750CV</span>
            </div>
        </article>
        
        <article class="models__card" data-marca="McLaren" data-modello="P1" data-colore="Giallo" data-prezzo="3800000"
            onclick="window.location.href='catalogo.jsp#mclaren'">
            <img src="images/mclaren-p1.png" alt="" class="models__img"> 
            <div class="models__gradient"></div>
            <div class="models__data">
                <h3 class="models__name">P1</h3>
                <span class="models__info">900CV</span>
            </div>
        </article>
        
        <article class="models__card" data-marca="Ferrari" data-modello="La Ferrari" data-colore="Rosso" data-prezzo="2300000"
            onclick="window.location.href='catalogo.jsp#ferrari'">
            <img src="images/laferrari.png" alt="" class="models__img"> 
            <div class="models__gradient"></div>
            <div class="models__data">
                <h3 class="models__name">La Ferrari</h3>
                <span class="models__info">900CV</span>
            </div>
        </article>
        
        <article class="models__card" data-marca="Koenigsegg" data-modello="Regera" data-colore="Rosso" data-prezzo="2000000"
            onclick="window.location.href='catalogo.jsp#koenigsegg'">
            <img src="images/koenigsegg-regera.png" alt="" class="models__img"> 
            <div class="models__gradient"></div>
            <div class="models__data">
                <h3 class="models__name">Koenigsegg Regera</h3>
                <span class="models__info">1500CV</span>
            </div>
        </article>
        
        <article class="models__card" data-marca="Porsche" data-modello="918" data-colore="Bianco" data-prezzo="195000"
            onclick="window.location.href='catalogo.jsp#porsche'">
            <img src="images/porsche918.png" alt="" class="models__img"> 
            <div class="models__gradient"></div>
            <div class="models__data">
                <h3 class="models__name">Porsche 918</h3>
                <span class="models__info">620CV</span>
            </div>
        </article>
    </div>
</section>


      </main>

      <!--==================== FOOTER ====================-->
       <jsp:include page="footer.jsp" />
      <!--========== SCROLL UP ==========-->
    

      <!--=============== SCROLLREVEAL ===============-->
      <script src="scrollreveal.min.js"></script>

      <!--=============== SWIPER JS ===============-->
      <script src="swiper-bundle.min.js"></script>

      <!--=============== MAIN JS ===============-->
      <script src="homepage.js"></script>
   </body>
</html>