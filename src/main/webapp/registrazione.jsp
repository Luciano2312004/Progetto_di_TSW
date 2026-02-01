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
    <title>FastMotors - Registrazione</title>
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
        <!--==================== REGISTER ====================-->
        <section class="login" id="register">
            <div class="login__bg"></div>
            <div class="login__pattern"></div>
            
            <div class="login__container container">
                <div class="login__content">
                    <form class="login__form" method="post" action="${pageContext.request.contextPath}/Registrazione" id="registerForm">
                        <h1 class="login__title">REGISTRATI</h1>
                        <p class="login__subtitle">UNISCITI ALLA FAMIGLIA FASTMOTORS</p>
                        
                            <div id="formError" class="message message--error"></div>
                            
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
                                <label for="nome" class="login__label">Nome</label>
                                <input type="text" id="nome" name="nome" placeholder="Inserisci il tuo nome" class="login__input" required>
                                  <div id="nomeError" class="form-error"></div>
                            </div>
                            
                            <div class="login__box">
                                <label for="cognome" class="login__label">Cognome</label>
                                <input type="text" id="cognome" name="cognome" placeholder="Inserisci il tuo cognome" class="login__input" required>
                                  <div id="cognomeError" class="form-error"></div>
                            </div>
                            
                            <div class="login__box">
                                <label for="email" class="login__label">Email</label>
                                <input type="email" id="email" name="email" placeholder="Inserisci la tua email" class="login__input" required>
                                 <div id="emailError" class="form-error"></div>
                            </div>
                            
                            <div class="login__box">
                                <label for="telefono" class="login__label">Telefono</label>
                                <input type="tel" id="telefono" name="telefono" placeholder="Inserisci il tuo numero di telefono" class="login__input" required>
                                 <div id="telefonoError" class="form-error"></div>
                            </div>
                            
                            <div class="login__box">
                                <label for="password" class="login__label">Password</label>
                                <input type="password" id="password" name="password" placeholder="Inserisci la tua password" class="login__input" required>
                                <div id="confirmPasswordError" class="form-error"></div>
                            </div>
                            
                            <div class="login__box">
                                <label for="confirmPassword" class="login__label">Conferma Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Conferma la tua password" class="login__input" required>
                                  <div id="confirmPasswordError" class="form-error"></div>
                            </div>
                        </div>
                        
                        <div class="register__terms">
                            <label class="register__checkbox">
                                <input type="checkbox" id="terms" name="terms" required>
                                <span class="register__checkmark"></span>
                                <span class="register__terms-text">
                                    Accetto i <a href="terms.jsp" target="_blank" class="register__terms-link">Termini e Condizioni</a>
                                    e la <a href="privacy.jsp" target="_blank" class="register__terms-link">Privacy Policy</a>
                                </span>
                            </label>
                             <div id="termsError" class="form-error"></div>
                        </div>
                        
                        <button type="submit" class="button" id="registerBtn">
                            <span id="registerText">REGISTRATI</span>
                            <div class="spinner" id="spinner"></div>
                            <i class="ri-arrow-right-s-line" id="registerIcon"></i>
                        </button>
                        
                        <div class="login__register">
                            <span class="login__register-text">Hai già un account? </span>
                            <a href="login.jsp" class="login__register-link">Accedi qui</a>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <script>
    function showError(id, message) {
        document.getElementById(id).textContent = message;
    }
        // Form validation and submission
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const nome = document.getElementById('nome').value.trim();
            const cognome = document.getElementById('cognome').value.trim();
            const email = document.getElementById('email').value.trim();
            const telefono = document.getElementById('telefono').value.trim();
            const password = document.getElementById('password').value.trim();
            const confirmPassword = document.getElementById('confirmPassword').value.trim();
            const terms = document.getElementById('terms').checked;
            const registerBtn = document.getElementById('registerBtn');
            const spinner = document.getElementById('spinner');
            const registerText = document.getElementById('registerText');
            const registerIcon = document.getElementById('registerIcon');
            ['nomeError','cognomeError','emailError','telefonoError','passwordError','confirmPasswordError','termsError','formError'].forEach(id => showError(id,''));
            
            let hasError = false;
            
            if (!nome) { showError('nomeError','Inserisci il nome.'); hasError=true; }
            if (!cognome) { showError('cognomeError','Inserisci il cognome.'); hasError=true; }
            if (!email) { showError('emailError','Inserisci l\'email.'); hasError=true; }
            if (!telefono) { showError('telefonoError','Inserisci il numero di telefono.'); hasError=true; }
            if (!password) { showError('passwordError','Inserisci la password.'); hasError=true; }
            if (!confirmPassword) { showError('confirmPasswordError','Conferma la password.'); hasError=true; }
            if (!terms) { showError('termsError','Devi accettare i termini.'); hasError=true; }
    
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if(email && !emailRegex.test(email)) { 
            	showError('emailError','Email non valida.'); 
            	hasError=true; }
            
            // Phone validation (Italian format)
            const phoneRegex = /^[\+]?[0-9]{10,15}$/;
            if(telefono && !phoneRegex.test(telefono.replace(/\s/g,''))) { 
            	showError('telefonoError','Telefono non valido.'); 
            	hasError=true; }

            
            // Password validation
            if(password && password.length<8) { showError('passwordError','Password minimo 8 caratteri.'); hasError=true; }
    if(password && confirmPassword && password!==confirmPassword) { showError('confirmPasswordError','Le password non coincidono.'); hasError=true; }

    if(hasError) { e.preventDefault(); return; }
            
        
            
    e.preventDefault();
    fetch('${pageContext.request.contextPath}/CheckEmail?email=' + encodeURIComponent(email))
        .then(res => res.json())
        .then(data => {
            if(data.exists) {
                showError('emailError','Email già registrata.');
            } else {
                // Submit del form se tutto ok
                registerBtn.disabled = true;
                spinner.style.display = 'block';
                registerText.textContent = 'REGISTRAZIONE IN CORSO...';
                registerIcon.style.display = 'none';
                e.target.submit();
            }
        })
        .catch(err => showError('formError','Errore server, riprova.'));
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

        // Real-time password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.style.borderColor = '#ff4757';
            } else {
                this.style.borderColor = '';
            }
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