<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>404 - Page Not Found</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/3.5.0/remixicon.css">
    <link rel="stylesheet" href="error.css">
</head>
<body>
    <div class="error__bg"></div>
    <div class="error__pattern"></div>
    
    <div class="error__container">
        <div class="error__content">
            <div class="error__inner">
                <h1 class="error__code">404</h1>
                <h2 class="error__title">PAGE NOT FOUND</h2>
                <p class="error__description">
                   La pagina che stai cercando non esiste.
                </p>
                <a href="${pageContext.request.contextPath}/" class="error__button">
                    <i class="ri-arrow-left-line"></i>
                    Torna alla home
                </a>
            </div>
        </div>
    </div>
</body>
</html>