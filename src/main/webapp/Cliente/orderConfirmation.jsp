<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="it">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>FastMotors - Ordine Confermato</title>
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

                    .step-circle {
                        transition: all 0.5s ease-in-out;
                    }

                    .step.completed .step-circle {
                        background-color: #2563EB;
                        color: white;
                        transform: scale(1.1);
                    }

                    .line-fill {
                        transition: width 1s ease-in-out;
                    }

                    .success-animation {
                        animation: successBounce 0.8s ease-out;
                    }

                    @keyframes successBounce {
                        0% {
                            transform: scale(0);
                        }

                        70% {
                            transform: scale(1.1);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }
                </style>
            </head>

            <body class="bg-gray-100">

                <header class="bg-white shadow-sm no-print">
                    <div class="container mx-auto px-6 py-4 flex items-center justify-between">
                        <a href="${pageContext.request.contextPath}/catalogo.jsp"><img
                                src="${pageContext.request.contextPath}/images/logo2.png" alt="FastMotors"
                                class="h-8"></a>
                        <button onclick="window.print()" class="text-blue-600 hover:text-blue-800 font-medium"><i
                                class="fas fa-print mr-2"></i>Stampa</button>
                    </div>
                </header>

                <div class="bg-white border-b no-print">
                    <div class="container mx-auto px-6 py-6">
                        <div class="flex items-center justify-center w-full max-w-2xl mx-auto">
                            <div class="step completed flex flex-col items-center text-center px-4">
                                <div
                                    class="step-circle w-10 h-10 rounded-full flex items-center justify-center text-lg font-bold">
                                    1</div><span class="step-text mt-2 font-medium text-sm">Configurazione</span>
                            </div>
                            <div class="flex-1 h-2 bg-blue-600 rounded-full mx-2 relative"></div>
                            <div class="step completed flex flex-col items-center text-center px-4">
                                <div
                                    class="step-circle w-10 h-10 rounded-full flex items-center justify-center text-lg font-bold">
                                    2</div><span class="step-text mt-2 font-medium text-sm">Checkout</span>
                            </div>
                            <div class="flex-1 h-2 bg-blue-600 rounded-full mx-2 relative"></div>
                            <div class="step completed flex flex-col items-center text-center px-4">
                                <div
                                    class="step-circle w-10 h-10 rounded-full flex items-center justify-center text-lg font-bold">
                                    3</div><span class="step-text mt-2 font-medium text-sm">Conferma</span>
                            </div>
                        </div>
                    </div>
                </div>

                <main class="container mx-auto px-6 py-12">
                    <div class="text-center mb-12">
                        <div
                            class="success-animation inline-block w-20 h-20 bg-green-500 rounded-full flex items-center justify-center mb-6">
                            <i class="fas fa-check text-white text-4xl"></i>
                        </div>
                        <h1 class="text-4xl font-bold text-gray-800 mb-4">Ordine Confermato!</h1>
                        <p class="text-xl text-gray-600 mb-2">Grazie,
                            <c:out value="${sessionScope.confirmedCustomerName}" />! Il tuo sogno sta per diventare
                            realtà.
                        </p>
                        <p class="text-gray-500">ID Ordine: <span
                                class="font-bold text-blue-600">#FM${sessionScope.confirmedOrderId}</span></p>
                    </div>

                    <div class="grid lg:grid-cols-2 gap-12 max-w-6xl mx-auto">
                        <div class="bg-white rounded-xl shadow-md p-8">
                            <h2 class="text-2xl font-semibold mb-6 text-gray-800">Riepilogo del Tuo Ordine</h2>
                            <c:set var="grandTotal" value="0" />
                            <div class="space-y-8">
                                <c:forEach var="item" items="${sessionScope.confirmedOrderItems}">
                                    <c:set var="grandTotal" value="${grandTotal + item.totalPrice}" />
                                    <div class="border-b pb-8 last:border-b-0 last:pb-0">
                                        <div class="flex gap-4 mb-4"><img src="${item.image}"
                                                class="w-28 h-28 object-cover rounded-lg shadow-sm flex-shrink-0"
                                                alt="${item.name}">
                                            <div>
                                                <h3 class="font-bold text-lg text-gray-900">${item.name}</h3>
                                                <p class="font-bold text-blue-600 text-lg">
                                                    <fmt:formatNumber value="${item.totalPrice}" type="currency"
                                                        currencySymbol="€" />
                                                </p>
                                            </div>
                                        </div>
                                        <div class="text-sm space-y-2 border-t pt-4 mt-4">
                                            <div class="flex justify-between"><span>Colore Esterni:
                                                    ${item.selectedColor.name}</span> <span class="font-medium">+
                                                    <fmt:formatNumber value="${item.selectedColor.price}"
                                                        type="currency" currencySymbol="€" />
                                                </span></div>
                                            <div class="flex justify-between"><span>Colore Interni:
                                                    ${item.selectedInteriorColor.name}</span> <span
                                                    class="font-medium">+
                                                    <fmt:formatNumber value="${item.selectedInteriorColor.price}"
                                                        type="currency" currencySymbol="€" />
                                                </span></div>
                                            <div class="flex justify-between"><span>Ruote: ${item.wheel.name}</span>
                                                <span class="font-medium">+
                                                    <fmt:formatNumber value="${item.wheel.price}" type="currency"
                                                        currencySymbol="€" />
                                                </span>
                                            </div>
                                            <c:if test="${item.autopilot != null}">
                                                <div class="flex justify-between"><span>${item.autopilot.name}</span>
                                                    <span class="font-medium">+
                                                        <fmt:formatNumber value="${item.autopilot.price}"
                                                            type="currency" currencySymbol="€" />
                                                    </span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty item.packages}">
                                                <c:forEach var="pkg" items="${item.packages}">
                                                    <div class="flex justify-between"><span>Package: ${pkg.name}</span>
                                                        <span class="font-medium">+
                                                            <fmt:formatNumber value="${pkg.price}" type="currency"
                                                                currencySymbol="€" />
                                                        </span>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${not empty item.accessories}">
                                                <c:forEach var="acc" items="${item.accessories}">
                                                    <div class="flex justify-between"><span>Accessorio:
                                                            ${acc.name}</span> <span class="font-medium">+
                                                            <fmt:formatNumber value="${acc.price}" type="currency"
                                                                currencySymbol="€" />
                                                        </span></div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="border-t mt-8 pt-6">
                                <div class="flex justify-between text-2xl font-bold text-gray-800"><span>Totale
                                        Pagato</span><span>
                                        <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="€" />
                                    </span></div>
                            </div>
                        </div>
                        <div class="space-y-8">
                            <div class="bg-white rounded-xl p-8 shadow-md">
                                <h2 class="text-xl font-semibold mb-6 text-gray-800 flex items-center"><i
                                        class="fas fa-user mr-3 text-blue-600"></i> Informazioni Cliente</h2>
                                <p class="text-gray-700">
                                    <c:out value="${sessionScope.confirmedCustomerName}" />
                                </p>
                            </div>
                            <div class="bg-white rounded-xl p-8 shadow-md">
                                <h2 class="text-xl font-semibold mb-6 text-gray-800 flex items-center"><i
                                        class="fas fa-truck mr-3 text-blue-600"></i> Indirizzo di Consegna</h2>
                                <p class="text-gray-700">
                                    <c:out value="${sessionScope.confirmedShippingAddress}" />
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-12 space-x-4 no-print">
                        <a href="${pageContext.request.contextPath}/catalogo.jsp"
                            class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors"><i
                                class="fas fa-car mr-2"></i>Torna al Catalogo</a>
                    </div>
                </main>

                <% // Pulizia della sessione per evitare di mostrare di nuovo i dati al refresh
                    session.removeAttribute("confirmedOrderId"); session.removeAttribute("confirmedOrderItems");
                    session.removeAttribute("confirmedCustomerName");
                    session.removeAttribute("confirmedShippingAddress"); %>
            </body>

            </html>