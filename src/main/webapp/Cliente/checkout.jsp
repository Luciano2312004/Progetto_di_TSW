<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="it">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>FastMotors - Checkout</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
                    rel="stylesheet">

                <style>
                    body {
                        font-family: 'Poppins', sans-serif;
                    }

                    .form-card {
                        transition: all 0.3s ease-in-out;
                    }

                    .form-card:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.07);
                    }

                    .form-input {
                        transition: all 0.2s ease;
                        border-width: 2px;
                    }

                    .form-input:focus {
                        border-color: #3B82F6;
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
                        outline: none;
                    }

                    .form-input.error {
                        border-color: #EF4444;
                    }

                    .error-message {
                        color: #EF4444;
                        font-size: 0.875rem;
                        margin-top: 0.5rem;
                        display: none;
                    }

                    .error-message.show {
                        display: block;
                    }

                    .payment-method {
                        cursor: pointer;
                        transition: all 0.2s ease;
                        border-width: 2px;
                    }

                    .payment-method:hover {
                        border-color: #93c5fd;
                    }

                    .payment-method.selected {
                        border-color: #3B82F6;
                        background-color: #eff6ff;
                    }

                    .step-circle {
                        transition: all 0.5s ease-in-out;
                    }

                    .step.completed .step-circle {
                        background-color: #2563EB;
                        color: white;
                        transform: scale(1.1);
                    }

                    .step.active .step-circle {
                        background-color: #3B82F6;
                        color: white;
                    }

                    .step.completed .step-text {
                        color: #1e3a8a;
                        font-weight: 600;
                    }

                    .step.active .step-text {
                        color: #3B82F6;
                        font-weight: 600;
                    }

                    .line-fill {
                        transition: width 0.4s ease-out;
                    }

                    .submit-button {
                        background-image: linear-gradient(to right, #3B82F6, #60A5FA);
                        transition: all 0.3s ease;
                        box-shadow: 0 4px 15px -5px rgba(59, 130, 246, 0.6);
                    }

                    .submit-button:hover {
                        transform: translateY(-2px) scale(1.02);
                        box-shadow: 0 8px 25px -8px rgba(59, 130, 246, 0.8);
                    }

                    .typing-cursor::after {
                        content: '';
                        animation: blink 1s step-end infinite;
                    }

                    @keyframes blink {
                        50% {
                            color: transparent;
                        }
                    }
                </style>
            </head>

            <body class="bg-gray-100">

                <header class="bg-white shadow-sm">
                    <div class="container mx-auto px-6 py-4 flex items-center justify-between">
                        <a href="${pageContext.request.contextPath}/configuratore.jsp"><img
                                src="${pageContext.request.contextPath}/images/logo2.png" alt="FastMotors"
                                class="h-8"></a>
                        <a href="${pageContext.request.contextPath}/configuratore.jsp"
                            class="text-blue-600 hover:text-blue-800 font-medium">← Torna al Configuratore</a>
                    </div>
                </header>

                <div class="bg-white border-b">
                    <div class="container mx-auto px-6 py-6">
                        <div class="flex items-center justify-center w-full max-w-2xl mx-auto">
                            <div id="step-1" class="step flex flex-col items-center text-center px-4">
                                <div
                                    class="step-circle w-10 h-10 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-lg font-bold">
                                    1</div><span
                                    class="step-text mt-2 font-medium text-gray-500 text-sm">Configurazione</span>
                            </div>
                            <div class="flex-1 h-2 bg-gray-300 rounded-full mx-2 relative">
                                <div id="line-1-fill" class="line-fill h-full bg-blue-600 rounded-full"
                                    style="width: 0%;"></div>
                            </div>
                            <div id="step-2" class="step flex flex-col items-center text-center px-4">
                                <div
                                    class="step-circle w-10 h-10 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-lg font-bold">
                                    2</div><span
                                    class="step-text mt-2 font-medium text-gray-500 text-sm">Checkout</span>
                            </div>
                            <div class="flex-1 h-2 bg-gray-300 rounded-full mx-2 relative">
                                <div id="progress-bar-fill" class="line-fill h-full bg-blue-600 rounded-full"
                                    style="width: 0%;"></div>
                            </div>
                            <div id="step-3" class="step flex flex-col items-center text-center px-4">
                                <div
                                    class="step-circle w-10 h-10 bg-gray-300 text-gray-600 rounded-full flex items-center justify-center text-lg font-bold">
                                    3</div><span
                                    class="step-text mt-2 font-medium text-gray-500 text-sm">Conferma</span>
                            </div>
                        </div>
                        <p id="dream-text" class="text-center text-gray-500 italic mt-4 h-5"></p>
                    </div>
                </div>

                <main class="container mx-auto px-6 py-12">
                    <c:choose>
                        <c:when test="${empty sessionScope.cart}">
                            <div class="text-center bg-white p-12 rounded-lg shadow-md max-w-2xl mx-auto">
                                <h1 class="text-3xl font-bold text-gray-800 mb-4">Il tuo carrello è vuoto</h1>
                                <p class="text-gray-600 mb-8">Sembra che non ci siano auto nel tuo carrello. Torna al
                                    configuratore per creare il tuo veicolo dei sogni.</p>
                                <a href="${pageContext.request.contextPath}/configuratore.jsp"
                                    class="bg-blue-600 text-white py-3 px-8 rounded-lg font-semibold hover:bg-blue-700 transition-colors">Vai
                                    al Configuratore</a>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <form id="checkout-form" method="POST" action="${pageContext.request.contextPath}/checkout">
                                <div class="grid lg:grid-cols-5 gap-12">
                                    <div class="lg:col-span-3 space-y-8">
                                        <div class="bg-white rounded-xl p-8 shadow-md form-card">
                                            <h2 class="text-2xl font-semibold mb-6 text-gray-800 flex items-center"><i
                                                    class="fas fa-user-circle fa-fw mr-3 text-blue-500"></i> Dati
                                                Personali</h2>
                                            <div class="grid md:grid-cols-2 gap-6">
                                                <div><label for="firstName"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Nome
                                                        *</label><input type="text" id="firstName" name="firstName"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="Il tuo nome">
                                                    <div class="error-message" id="firstNameError"></div>
                                                </div>
                                                <div><label for="lastName"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Cognome
                                                        *</label><input type="text" id="lastName" name="lastName"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="Il tuo cognome">
                                                    <div class="error-message" id="lastNameError"></div>
                                                </div>
                                                <div class="md:col-span-2"><label for="email"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Email
                                                        *</label><input type="email" id="email" name="email"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="email@esempio.com">
                                                    <div class="error-message" id="emailError"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="bg-white rounded-xl p-8 shadow-md form-card">
                                            <h2 class="text-2xl font-semibold mb-6 text-gray-800 flex items-center"><i
                                                    class="fas fa-shipping-fast fa-fw mr-3 text-blue-500"></i> Indirizzo
                                                di Consegna</h2>
                                            <div class="grid md:grid-cols-2 gap-6">
                                                <div class="md:col-span-2"><label for="address"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Indirizzo
                                                        *</label><input type="text" id="address" name="address"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="Via, Numero civico">
                                                    <div class="error-message" id="addressError"></div>
                                                </div>
                                                <div><label for="city"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Città
                                                        *</label><input type="text" id="city" name="city"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="Roma">
                                                    <div class="error-message" id="cityError"></div>
                                                </div>
                                                <div><label for="zipCode"
                                                        class="block text-sm font-medium text-gray-700 mb-2">CAP
                                                        *</label><input type="text" id="zipCode" name="zipCode"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="00100">
                                                    <div class="error-message" id="zipCodeError"></div>
                                                </div>
                                                <div><label for="province"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Provincia
                                                        *</label><select id="province" name="province"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300 bg-white">
                                                        <option value="">Seleziona...</option>
                                                        <option value="RM">Roma</option>
                                                        <option value="MI">Milano</option>
                                                        <option value="NA">Napoli</option>
                                                        <option value="TO">Torino</option>
                                                    </select>
                                                    <div class="error-message" id="provinceError"></div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="bg-white rounded-xl p-8 shadow-md form-card">
                                            <h2 class="text-2xl font-semibold mb-6 text-gray-800 flex items-center"><i
                                                    class="fas fa-credit-card fa-fw mr-3 text-blue-500"></i> Metodo di
                                                Pagamento</h2>
                                            <div class="grid md:grid-cols-3 gap-4 mb-6">
                                                <div class="payment-method p-4 rounded-lg border-gray-200"
                                                    data-method="credit">
                                                    <div class="text-center"><i
                                                            class="fas fa-credit-card text-2xl text-blue-600 mb-2"></i>
                                                        <div class="font-semibold">Carta di Credito</div>
                                                    </div>
                                                </div>
                                                <div class="payment-method p-4 rounded-lg border-gray-200"
                                                    data-method="financing">
                                                    <div class="text-center"><i
                                                            class="fas fa-percentage text-2xl text-green-600 mb-2"></i>
                                                        <div class="font-semibold">Finanziamento</div>
                                                    </div>
                                                </div>
                                                <div class="payment-method p-4 rounded-lg border-gray-200"
                                                    data-method="bank">
                                                    <div class="text-center"><i
                                                            class="fas fa-university text-2xl text-purple-600 mb-2"></i>
                                                        <div class="font-semibold">Bonifico</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="credit-card-form" class="hidden space-y-4">
                                                <div><label for="cardName"
                                                        class="block text-sm font-medium text-gray-700 mb-2">Nome
                                                        Titolare Carta *</label><input type="text" id="cardName"
                                                        class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                        placeholder="Mario Rossi">
                                                    <div class="error-message" id="cardNameError"></div>
                                                </div>
                                                <div class="grid md:grid-cols-3 gap-6">
                                                    <div class="md:col-span-3"><label for="cardNumber"
                                                            class="block text-sm font-medium text-gray-700 mb-2">Numero
                                                            Carta *</label><input type="text" id="cardNumber"
                                                            class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                            placeholder="1234 5678 9012 3456" maxlength="19">
                                                        <div class="error-message" id="cardNumberError"></div>
                                                    </div>
                                                    <div><label for="cardExpiry"
                                                            class="block text-sm font-medium text-gray-700 mb-2">Scadenza
                                                            *</label><input type="text" id="cardExpiry"
                                                            class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                            placeholder="MM/YY" maxlength="5">
                                                        <div class="error-message" id="cardExpiryError"></div>
                                                    </div>
                                                    <div><label for="cardCVV"
                                                            class="block text-sm font-medium text-gray-700 mb-2">CVV
                                                            *</label><input type="text" id="cardCVV"
                                                            class="form-input w-full px-4 py-3 rounded-lg border-gray-300"
                                                            placeholder="123" maxlength="4">
                                                        <div class="error-message" id="cardCVVError"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="financing-info"
                                                class="hidden bg-green-50 p-4 rounded-lg text-sm text-green-700">
                                                <p>Un nostro consulente ti contatterà per finalizzare la pratica di
                                                    finanziamento.</p>
                                            </div>
                                            <div id="bank-info"
                                                class="hidden bg-purple-50 p-4 rounded-lg text-sm text-purple-700">
                                                <p>Riceverai un'email con i dettagli bancari per completare il
                                                    pagamento.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="lg:col-span-2">
                                        <div class="bg-white rounded-xl shadow-md p-8 sticky top-8">
                                            <h2 class="text-2xl font-semibold mb-6 text-gray-800">Riepilogo Ordine</h2>
                                            <c:set var="grandTotal" value="0" />
                                            <div class="space-y-8">
                                                <c:forEach var="item" items="${sessionScope.cart}">
                                                    <c:set var="grandTotal" value="${grandTotal + item.totalPrice}" />
                                                    <div class="border-b pb-8 last:border-b-0 last:pb-0">
                                                        <div class="flex gap-4 mb-4"><img src="${item.image}"
                                                                class="summary-car-image w-28 h-28 object-cover rounded-lg shadow-sm flex-shrink-0 cursor-pointer hover:opacity-80 transition-opacity"
                                                                alt="${item.name}">
                                                            <div>
                                                                <h3 class="font-bold text-lg text-gray-900">${item.name}
                                                                </h3>
                                                                <p class="font-bold text-blue-600 text-lg">
                                                                    <fmt:formatNumber value="${item.totalPrice}"
                                                                        type="currency" currencySymbol="€" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="text-sm space-y-2 border-t pt-4 mt-4">
                                                            <div class="flex justify-between"><span>Colore Esterni:
                                                                    ${item.selectedColor.name}</span> <span
                                                                    class="font-medium">+
                                                                    <fmt:formatNumber
                                                                        value="${item.selectedColor.price}"
                                                                        type="currency" currencySymbol="€" />
                                                                </span></div>
                                                            <div class="flex justify-between"><span>Colore Interni:
                                                                    ${item.selectedInteriorColor.name}</span> <span
                                                                    class="font-medium">+
                                                                    <fmt:formatNumber
                                                                        value="${item.selectedInteriorColor.price}"
                                                                        type="currency" currencySymbol="€" />
                                                                </span></div>
                                                            <div class="flex justify-between"><span>Ruote:
                                                                    ${item.wheel.name}</span> <span
                                                                    class="font-medium">+
                                                                    <fmt:formatNumber value="${item.wheel.price}"
                                                                        type="currency" currencySymbol="€" />
                                                                </span></div>
                                                            <c:if test="${item.autopilot != null}">
                                                                <div class="flex justify-between">
                                                                    <span>${item.autopilot.name}</span> <span
                                                                        class="font-medium">+
                                                                        <fmt:formatNumber
                                                                            value="${item.autopilot.price}"
                                                                            type="currency" currencySymbol="€" />
                                                                    </span></div>
                                                            </c:if>
                                                            <c:if test="${not empty item.packages}">
                                                                <c:forEach var="pkg" items="${item.packages}">
                                                                    <div class="flex justify-between"><span>Package:
                                                                            ${pkg.name}</span> <span
                                                                            class="font-medium">+
                                                                            <fmt:formatNumber value="${pkg.price}"
                                                                                type="currency" currencySymbol="€" />
                                                                        </span></div>
                                                                </c:forEach>
                                                            </c:if>
                                                            <c:if test="${not empty item.accessories}">
                                                                <c:forEach var="acc" items="${item.accessories}">
                                                                    <div class="flex justify-between"><span>Accessorio:
                                                                            ${acc.name}</span> <span
                                                                            class="font-medium">+
                                                                            <fmt:formatNumber value="${acc.price}"
                                                                                type="currency" currencySymbol="€" />
                                                                        </span></div>
                                                                </c:forEach>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <div class="border-t mt-8 pt-6">
                                                <div class="flex justify-between text-lg font-bold text-gray-800">
                                                    <span>Totale</span><span>
                                                        <fmt:formatNumber value="${grandTotal}" type="currency"
                                                            currencySymbol="€" />
                                                    </span></div>
                                            </div>
                                            <button type="submit"
                                                class="submit-button w-full mt-8 text-white py-4 px-6 rounded-lg font-semibold"><i
                                                    class="fas fa-lock mr-2"></i>Conferma e Procedi</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </main>

                <div id="image-modal"
                    class="fixed inset-0 bg-black/80 backdrop-blur-sm z-50 hidden items-center justify-center p-4">
                    <div class="relative"><img id="modal-image" src=""
                            class="max-w-[80vw] max-h-[80vh] object-contain rounded-lg shadow-2xl"><button
                            id="modal-close"
                            class="absolute -top-4 -right-4 w-10 h-10 bg-white text-black rounded-full text-xl hover:bg-gray-200 transition">&times;</button>
                    </div>
                </div>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const checkoutForm = document.getElementById('checkout-form');
                        if (!checkoutForm) return;

                        // --- ANIMAZIONE TYPEWRITER ---
                        const dreamTextElement = document.getElementById('dream-text');
                        if (dreamTextElement) {
                            const textToType = "Il tuo sogno è vicino...";
                            let i = 0;
                            dreamTextElement.classList.add('typing-cursor');
                            setTimeout(() => {
                                const typingInterval = setInterval(() => {
                                    if (i < textToType.length) {
                                        dreamTextElement.textContent += textToType.charAt(i);
                                        i++;
                                    } else {
                                        clearInterval(typingInterval);
                                        dreamTextElement.classList.remove('typing-cursor');
                                    }
                                }, 100);
                            }, 1500);
                        }

                        // --- LIGHTBOX IMMAGINE ---
                        const modal = document.getElementById('image-modal');
                        const modalImage = document.getElementById('modal-image');
                        const closeModalBtn = document.getElementById('modal-close');
                        document.body.addEventListener('click', function (e) {
                            if (e.target.classList.contains('summary-car-image')) {
                                modalImage.src = e.target.src;
                                modal.classList.remove('hidden');
                                modal.classList.add('flex');
                            }
                        });
                        function closeModal() { modal.classList.add('hidden'); modal.classList.remove('flex'); }
                        if (closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
                        if (modal) modal.addEventListener('click', (e) => { if (e.target === modal) closeModal(); });

                        // --- ROADMAP E VALIDAZIONE ---
                        setTimeout(() => document.getElementById('step-1').classList.add('completed'), 100);
                        setTimeout(() => { document.getElementById('line-1-fill').style.width = '100%'; }, 500);
                        setTimeout(() => document.getElementById('step-2').classList.add('active'), 1000);
                        const progressBar = document.getElementById('progress-bar-fill');
                        const requiredFieldsForProgress = ['firstName', 'lastName', 'email', 'address', 'city', 'zipCode', 'province'];
                        function updateProgress() {
                            let filledCount = 0;
                            requiredFieldsForProgress.forEach(id => {
                                const element = document.getElementById(id);
                                if (element && element.value.trim() !== '') filledCount++;
                            });
                            const percentage = (filledCount / requiredFieldsForProgress.length) * 100;
                            if (progressBar) progressBar.style.width = percentage + '%';
                        }
                        requiredFieldsForProgress.forEach(id => {
                            const element = document.getElementById(id);
                            if (element) element.addEventListener('input', updateProgress);
                        });
                        updateProgress();

                        const paymentMethods = document.querySelectorAll('.payment-method');
                        paymentMethods.forEach(method => {
                            method.addEventListener('click', () => {
                                paymentMethods.forEach(m => m.classList.remove('selected'));
                                method.classList.add('selected');
                                ['credit-card-form', 'financing-info', 'bank-info'].forEach(id => {
                                    const el = document.getElementById(id);
                                    if (el) el.classList.add('hidden');
                                });
                                const selectedMethod = method.dataset.method;
                                if (selectedMethod === 'credit') document.getElementById('credit-card-form').classList.remove('hidden');
                                else if (selectedMethod === 'financing') document.getElementById('financing-info').classList.remove('hidden');
                                else if (selectedMethod === 'bank') document.getElementById('bank-info').classList.remove('hidden');
                            });
                        });

                        // --- FORMATTAZIONE AUTOMATICA CAMPI CARTA ---
                        const cardExpiryInput = document.getElementById('cardExpiry');
                        if (cardExpiryInput) {
                            cardExpiryInput.addEventListener('input', function (e) {
                                let value = e.target.value.replace(/\D/g, '');
                                if (value.length > 2) {
                                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                                }
                                e.target.value = value;
                            });
                        }

                        // --- VALIDAZIONE FORM AL SUBMIT ---
                        checkoutForm.addEventListener('submit', function (event) {
                            let isValid = true;
                            document.querySelectorAll('.error-message').forEach(el => { el.textContent = ''; el.classList.remove('show'); });
                            document.querySelectorAll('.form-input').forEach(el => el.classList.remove('error'));
                            function showError(fieldId, message) {
                                const field = document.getElementById(fieldId);
                                const errorElement = document.getElementById(fieldId + 'Error');
                                if (field) field.classList.add('error');
                                if (errorElement) { errorElement.textContent = message; errorElement.classList.add('show'); }
                                isValid = false;
                            }

                            function isValidExpiryDate(expiry) {
                                if (!/^\d{2}\/\d{2}$/.test(expiry)) return false;
                                const [month, year] = expiry.split('/');
                                const expiryMonth = parseInt(month, 10);
                                const expiryYear = parseInt(year, 10);
                                if (expiryMonth < 1 || expiryMonth > 12) return false;
                                const now = new Date();
                                const currentYear = now.getFullYear() % 100;
                                const currentMonth = now.getMonth() + 1;
                                if (expiryYear < currentYear || (expiryYear === currentYear && expiryMonth < currentMonth)) return false;
                                return true;
                            }

                            ['firstName', 'lastName', 'address', 'city', 'province'].forEach(id => { if (document.getElementById(id).value.trim() === '') showError(id, 'Questo campo è obbligatorio.'); });
                            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(document.getElementById('email').value)) showError('email', 'Inserisci un\'email valida.');
                            if (!/^\d{5}$/.test(document.getElementById('zipCode').value)) showError('zipCode', 'Il CAP deve essere di 5 cifre.');

                            const selectedPayment = document.querySelector('.payment-method.selected');
                            if (selectedPayment && selectedPayment.dataset.method === 'credit') {
                                if (document.getElementById('cardName').value.trim() === '') showError('cardName', 'Il nome del titolare è obbligatorio.');
                                if (!/^\d{16}$/.test(document.getElementById('cardNumber').value)) showError('cardNumber', 'Il numero della carta non è valido.');
                                const cardExpiry = document.getElementById('cardExpiry').value.trim();
                                if (cardExpiry === '') {
                                    showError('cardExpiry', 'La data di scadenza è obbligatoria.');
                                } else if (!isValidExpiryDate(cardExpiry)) {
                                    showError('cardExpiry', 'La data inserita non è valida.');
                                }
                                if (!/^\d{3}$/.test(document.getElementById('cardCVV').value)) showError('cardCVV', 'Il CVV non è valido.');
                            }

                            if (!isValid) {
                                event.preventDefault();
                                window.scrollTo({ top: 0, behavior: 'smooth' });
                                alert('Si prega di correggere gli errori evidenziati nel modulo.');
                            }
                        });
                    });
                </script>
            </body>

            </html>