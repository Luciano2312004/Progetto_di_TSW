<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!--=============== FAVICON ===============-->
    <link rel="shortcut icon" href="assets/img/favicon.png" type="image/x-icon">
    
    <!--=============== REMIXICONS ===============-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    
      <link rel="stylesheet" href="style-login.css">
    <title>FastMotors - Login</title>
</head>
<body>
    <!--==================== HEADER ====================-->
    <header class="header" id="header">
        <nav class="nav container"> 
            <a href="index.jsp" class="nav__logo">FASTMOTORS</a>
            <a href="index.jsp" class="nav__back">
                <i class="ri-arrow-left-line"></i>
                Torna alla Home
            </a>
        </nav>
    </header>

    <!--==================== MAIN ====================-->
    <main class="main">
        <!--==================== LOGIN ====================-->
        <section class="login" id="login">
            <div class="login__bg"></div>
            <div class="login__pattern"></div>
            
            <div class="login__container container">
                <div class="login__content">
                    <form class="login__form" method="post" action="${pageContext.request.contextPath}/LoginServlet" id="loginForm">
                        <h1 class="login__title">ACCEDI</h1>
                        <p class="login__subtitle">ENTRA NEL MONDO FASTMOTORS</p>
                      
                        
                        <c:if test="${not empty error}">
                            <div class="message message--error">
                                <i class="ri-error-warning-line"></i> ${error}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="message message--success">
                                <i class="ri-check-line"></i> ${success}
                            </div>
                        </c:if>
                        
                        <div class="login__inputs">
                            <div class="login__box">
                                <label for="email" class="login__label">Email</label>
                                <input type="email" id="email" name="email" placeholder="Inserisci la tua email" class="login__input" required>
                                 <div id="emailError" class="form-error"></div>
                            </div>
                            
                            <div class="login__box">
                                <label for="password" class="login__label">Password</label>
                                <input type="password" id="password" name="password" placeholder="Inserisci la tua password" class="login__input" required>
                                 <div id="passwordError" class="form-error"></div>
                            </div>
                            <div id="formError" class="message message--error"></div>
                        </div>
                        
                        
                        
                        <button type="submit" class="button" id="loginBtn">
                            <span id="loginText">ACCEDI</span>
                            <div class="spinner" id="spinner"></div>
                            <i class="ri-arrow-right-s-line" id="loginIcon"></i>
                        </button>
                        
                        <div class="login__register">
                            <span class="login__register-text">Non hai un account? </span>
                            <a href="registrazione.jsp" class="login__register-link">Registrati qui</a>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <script>
        // Form validation and submission
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            const loginBtn = document.getElementById('loginBtn');
            const spinner = document.getElementById('spinner');
            const loginText = document.getElementById('loginText');
            const loginIcon = document.getElementById('loginIcon');
          
            document.getElementById("formError").textContent = "";
            document.getElementById("emailError").textContent = "";
            document.getElementById("passwordError").textContent = "";

            let hasError = false;

            // campi vuoti
            if (!email) {
                document.getElementById("emailError").textContent = "Inserisci l'email.";
                hasError = true;
            }
            if (!password) {
                document.getElementById("passwordError").textContent = "Inserisci la password.";
                hasError = true;
            }
            if (hasError) {
                e.preventDefault();
                return;
            }

            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
            	  document.getElementById("emailError").textContent = "Inserisci un indirizzo email valido.";
                  e.preventDefault();
                return;
            }
            
            // Show loading state
            loginBtn.disabled = true;
            spinner.style.display = 'block';
            loginText.textContent = 'ACCESSO IN CORSO...';
            loginIcon.style.display = 'none';
        });

        // Input focus effects
        document.querySelectorAll('.login__input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            const messages = document.querySelectorAll('.message');
            messages.forEach(message => {
                message.style.opacity = '0';
                setTimeout(() => message.remove(), 300);
            });
        }, 5000);
    </script>
</body>
</html>