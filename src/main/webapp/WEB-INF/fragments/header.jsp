<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>

        <link rel="stylesheet" href="header.css">

        <header class="header" id="header">
            <nav class="nav container">
                <a href="index.jsp" class="nav__logo">FASTMOTORS</a>

                <div class="nav__menu" id="nav-menu">
                    <ul class="nav__list">
                        <li><a href="index.jsp" class="nav__link active-link">Home</a></li>
                        <li><a href="index.jsp#about" class="nav__link">Chi siamo</a></li>
                        <li><a href="catalogo.jsp" class="nav__link">Le Nostre Auto</a></li>
                    </ul>

                    <div class="nav__close" id="nav-close">
                        <i class="ri-close-large-line"></i>
                    </div>
                </div>

                <div class="nav__actions">
                    <div class="nav__icons">
                        <!-- Gestione Utente -->
                        <c:if test="${not empty sessionScope.utente}">
                            <div class="nav__user-container">
                                <i class="ri-user-fill nav__user-icon" id="userIcon"></i>
                                <div class="nav__user-dropdown" id="userDropdown">
                                    <p><strong>${sessionScope.utente.nome} ${sessionScope.utente.cognome}</strong></p>
                                    <a href="${pageContext.request.contextPath}/OrdiniUtenteServlet"
                                        class="order-link">Ordini</a><br>
                                    <a href="${pageContext.request.contextPath}/LogoutServlet"
                                        class="logout-link">Logout</a>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty sessionScope.utente}">
                            <div class="nav__user-container">
                                <i class="ri-user-fill nav__user-icon" id="userIcon"></i>
                                <div class="nav__user-dropdown" id="userDropdown">
                                    <a href="${pageContext.request.contextPath}/login.jsp"
                                        class="login-link">Login</a><br>
                                    <a href="${pageContext.request.contextPath}/registrazione.jsp"
                                        class="register-link">Registrati</a>
                                </div>
                            </div>
                        </c:if>

                        <!-- Carrello -->
                        <div class="relative">
                            <button id="cart-toggle" class="nav__icon-link" aria-label="Apri carrello">
                                <i class="ri-shopping-cart-2-fill"></i>
                                <span id="cart-count"
                                    class="absolute -top-2 -right-2 bg-blue-600 text-white text-xs font-bold rounded-full px-2">0</span>
                            </button>
                        </div>
                    </div>

                    <div class="nav__toggle" id="nav-toggle">
                        <i class="ri-menu-line"></i>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Overlay e Sidebar Carrello - CLASSI ORIGINALI -->
        <div id="cart-overlay"
            class="fixed inset-0 bg-black/30 backdrop-blur-sm hidden z-40 transition-opacity duration-300"></div>
        <aside id="cart-sidebar"
            class="fixed right-0 top-16 h-[calc(100%-4rem)] w-full md:w-96 transform translate-x-full transition-transform duration-300 z-50 bg-white shadow-lg">
            <div class="p-4 border-b flex items-center justify-between">
                <h3 class="text-lg font-semibold">Le tue Auto configurate</h3>
                <button id="cart-close" class="text-gray-600 hover:text-gray-900">Chiudi</button>
            </div>
            <div id="cart-items" class="p-4 overflow-auto" style="height: calc(100% - 220px);">
                <div class="text-center py-12 text-gray-500">Il carrello è vuoto</div>
            </div>
            <div class="p-4 border-t">
                <div class="flex justify-between items-center mb-4">
                    <strong>Totale</strong>
                    <span id="cart-total">€0.00</span>
                </div>
                <a id="checkout-link" href="${pageContext.request.contextPath}/Cliente/checkout.jsp"
                    class="block w-full text-center py-3 bg-blue-600 text-white rounded-lg">Procedi all'acquisto</a>
            </div>
        </aside>

        <script>
          
           

            // Funzioni per il carrello - ORIGINALI
            function openCart() {
                const cartSidebar = document.getElementById('cart-sidebar');
                const cartOverlay = document.getElementById('cart-overlay');
                if (!cartSidebar || !cartOverlay) return;

                cartSidebar.classList.remove('translate-x-full');
                cartOverlay.classList.remove('hidden');
                refreshCartDisplay();
            }

            function closeCart() {
                const cartSidebar = document.getElementById('cart-sidebar');
                const cartOverlay = document.getElementById('cart-overlay');
                if (!cartSidebar || !cartOverlay) return;

                cartSidebar.classList.add('translate-x-full');
                cartOverlay.classList.add('hidden');
            }

            async function refreshCartDisplay() {
                const ctx = '${pageContext.request.contextPath}';
                const cartItemsEl = document.getElementById('cart-items');
                const cartCountEl = document.getElementById('cart-count');
                const cartTotalEl = document.getElementById('cart-total');

                try {
                    const resp = await fetch(ctx + '/cart/get', { credentials: 'same-origin' });
                    if (!resp.ok) throw new Error('Errore caricamento carrello. Status: ' + resp.status);
                    const text = await resp.text();
                    const items = text ? JSON.parse(text) : [];

                    cartItemsEl.innerHTML = '';
                    let total = 0;
                    if (!items || items.length === 0) {
                        cartItemsEl.innerHTML = '<div class="text-center py-12 text-gray-500">Il carrello è vuoto</div>';
                        cartCountEl.textContent = '0';
                        cartTotalEl.textContent = '€0.00';
                        return;
                    }

                    items.forEach(item => {
                        const wrapper = document.createElement('div');
                        wrapper.className = 'cart-row flex items-center justify-between py-3 border-b';

                        const formattedPrice = (item.totalPrice || 0).toLocaleString('it-IT', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

                        const itemHTML = `
                <div class="flex items-center gap-4">
                    <img src="${'$'}{item.image || (ctx + '/images/default.png')}" alt="${'$'}{item.name || 'Auto'}" class="w-20 h-20 object-cover rounded">
                    <div>
                        <h3 class="font-semibold">${'$'}{item.name}</h3>
                        <p class="text-sm text-gray-600">
                            Colore esterni: <strong>${'$'}{item.selectedColor?.name || 'N/D'}</strong>, 
                            Colore interni: <strong>${'$'}{item.selectedInteriorColor?.name || 'N/D'}</strong>, 
                            Ruote: <strong>${'$'}{item.wheel?.name || 'N/D'}</strong>
                        </p>
                        <p class="text-lg font-bold">€${'$'}{formattedPrice}</p>
                    </div>
                </div>
                <div><button class="remove-btn text-red-600 hover:underline" data-id="${'$'}{item.id}">Rimuovi</button></div>`;
                        wrapper.innerHTML = itemHTML;
                        cartItemsEl.appendChild(wrapper);
                        total += item.totalPrice || 0;
                    });

                    cartCountEl.textContent = String(items.length);
                    const formattedTotal = total.toLocaleString('it-IT', { minimumFractionDigits: 3, maximumFractionDigits: 3 });
                    cartTotalEl.textContent = '€' + formattedTotal;

                    document.querySelectorAll('.remove-btn').forEach(button => {
                        button.addEventListener('click', async (e) => {
                            const itemId = e.target.dataset.id;
                            await fetch(ctx + '/cart/remove', {
                                method: 'POST',
                                credentials: 'same-origin',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ id: itemId })
                            });
                            refreshCartDisplay();
                        });
                    });
                } catch (e) {
                    console.error('refreshCartDisplay failed', e);
                }
            }

            // Event listeners per il carrello - ORIGINALI
            document.addEventListener('DOMContentLoaded', function () {
                const cartToggle = document.getElementById('cart-toggle');
                const cartClose = document.getElementById('cart-close');
                const cartOverlay = document.getElementById('cart-overlay');

                if (cartToggle) cartToggle.addEventListener('click', openCart);
                if (cartClose) cartClose.addEventListener('click', closeCart);
                if (cartOverlay) cartOverlay.addEventListener('click', closeCart);

                refreshCartDisplay();
            });
        </script>