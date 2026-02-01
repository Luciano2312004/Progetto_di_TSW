<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
        integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
      <script src="https://cdn.tailwindcss.com"></script>
      <link rel="stylesheet" href="./configuratore.css" />
      <title>FastMotors Configurator</title>
    </head>

    <body>
      <!-- Header con carrello incluso -->
      <jsp:include page="/WEB-INF/fragments/header.jsp" />
      <script>
        const contextPath = '<%= request.getContextPath() %>';
      </script>
      <p><br><br><br></p>
      <main class="flex flex-col md:flex-row justify-between px-4 md:px-10 py-6">
        <!-- Image Section -->
        <section class="w-full md:w-3/4">
          <div class="sticky top-24" style="height: calc(100vh - 6rem);">
            <!-- Exterior Image -->
            <div class="bg-gray-200 flex items-center justify-center overflow-hidden mb-4 relative">
              <img src="./images/Ferrari/ferrarifg.png" alt="Auto selezionata"
                class="max-w-full h-auto transform scale-125" id="exterior-image" />
              <!-- Frecce -->
              <button id="prev-image"
                class="absolute left-2 top-1/2 transform -translate-y-1/2 bg-white rounded-full p-2 shadow">
                &#10094;
              </button>
              <button id="next-image"
                class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-white rounded-full p-2 shadow">
                &#10095;
              </button>
            </div>
            <!-- Galleria immagini esterni -->
            <div id="exterior-gallery" class="flex space-x-4 justify-right mt-4">
              <img src="./images/Ferrari/ferrarifg.png" alt="Vista Frontale"
                class="thumbnail w-24 h-24 object-cover cursor-pointer border-2 border-transparent hover:border-gray-400"
                data-src="./images/Ferrari/ferrarifg.png" id="frontimg" />
              <img src="./images/Ferrari/ferrarisg.png" alt="Vista Laterale"
                class="thumbnail w-24 h-24 object-cover cursor-pointer border-2 border-transparent hover:border-gray-400"
                data-src="./images/Ferrari/ferrarisg.png" />
              <img src="./images/Ferrari/ferrarirg.png" alt="Vista Retro"
                class="thumbnail w-24 h-24 object-cover cursor-pointer border-2 border-transparent hover:border-gray-400"
                data-src="./images/Ferrari/ferrarirg.png" />
              <img src="./images/Lamborghini/sianintern1.png" alt="Vista Interni 1"
                class="thumbnail w-24 h-24 object-cover cursor-pointer border-2 border-transparent hover:border-gray-400"
                data-src="./images/Lamborghini/sianintern1.png" />
              <img src="./images/Lamborghini/sianintern11.png" alt="Vista Interni 2"
                class="thumbnail w-24 h-24 object-cover cursor-pointer border-2 border-transparent hover:border-gray-400"
                data-src="./images/Lamborghini/sianintern11.png" />
            </div>
        </section>
        <!-- Sidebar -->
        <aside class="w-full md:w-1/3 pl-0 md:pl-8 mt-6 md:mt-0 z-2">
          <h1 class="text-5xl text-center font-bold mb-5">LaFerrari</h1>
          <h2 class="text-xl text-center font-light">Configura il tuo sogno</h2>
          <!-- Performance Stats -->
          <div class="flex justify-between items-center py-4 px-2 mb-6">
            <!-- Autonomia -->
            <div class="text-center">
              <div class="flex items-baseline justify-center">
                <span class="text-2xl font-bold" id="range-counter">0</span>
                <span class="text-sm font-medium text-gray-600 ml-1">CV</span>
              </div>
              <p class="text-xs text-gray-500 mt-1">Potenza<br><span class="font-medium">(CV)</span></p>
            </div>
            <!-- Velocità -->
            <div class="text-center">
              <div class="flex items-baseline justify-center">
                <span class="text-2xl font-bold" id="speed-counter">0</span>
                <span class="text-sm font-medium text-gray-600 ml-1">km/h</span>
              </div>
              <p class="text-xs text-gray-500 mt-1">Velocità<br><span class="font-medium">massima</span></p>
            </div>
            <!-- Accelerazione -->
            <div class="text-center">
              <div class="flex items-baseline justify-center">
                <span class="text-2xl font-bold" id="acceleration-counter">0</span>
                <span class="text-sm font-medium text-gray-600 ml-1">s</span>
              </div>
              <p class="text-xs text-gray-500 mt-1">0-100 km/h</p>
            </div>
          </div>
          <!-- Exterior Buttons -->
          <div class="my-8" id="exterior-buttons">
            <h3 class="font-semibold mb-2">Colore Esterni</h3>
            <div class="flex space-x-4">
              <button class="btn-selected transition-transform duration-300 hover:scale-110">
                <img src="./images/button-stealth-grey.avif" alt="Stealth Grey" class="w-22" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110">
                <img src="./images/button-pearl-white.avif" alt="Pearl White" class="w-22" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110">
                <img src="./images/button-deep-blue-metallic.avif" alt="Deep Blue" class="w-22" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110">
                <img src="./images/button-solid-black.avif" alt="Solid Black" class="w-22" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110">
                <img src="./images/button-ultra-red.avif" alt="Ultra Red" class="w-22" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110">
                <img src="./images/button-quicksilver.avif" alt="Quicksilver" class="w-22" />
              </button>
            </div>
          </div>
          <!-- Interior Buttons -->
          <div class="my-8" id="interior-buttons">
            <h3 class="font-semibold mb-2">Colore Interni</h3>
            <div class="flex space-x-4">
              <button class="btn-selected transition-transform duration-300 hover:scale-110">
                <img src="./images/button-dark.avif" alt="Dark" class="w-12" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110">
                <img src="./images/button-light.avif" alt="Light" class="w-12" />
              </button>
            </div>
          </div>
          <!-- Wheel Buttons -->
          <div class="mb-8" id="wheel-buttons">
            <h3 class="font-semibold mb-2">Ruote</h3>
            <div class="flex space-x-4">
              <button class="btn-selected transition-transform duration-300 hover:scale-110 wheel-option"
                data-wheel="Standard" aria-pressed="true" title="Standard Wheels">
                <img src="./images/s-l1200.png" alt="Standard Wheels" class="w-22" />
              </button>
              <button class="transition-transform duration-300 hover:scale-110 wheel-option" data-wheel="Performance"
                aria-pressed="false" title="Ruote Performance (+$2,500)">
                <img src="./images/s-l1200 (1).png" alt="Performance Wheels" class="w-22" />
              </button>
            </div>
          </div>
          <!-- Packages Section  -->
          <div class="mb-8" id="packages-section">
            <h3 class="font-semibold mb-4">Packages</h3>
            <div class="grid grid-cols-2 gap-3">
              <!-- Performance Package -->
              <div class="package-option" data-package="performance" data-price="5000">
                <img src="./images/package-performance.jpg" alt="Performance Package"
                  class="w-full h-20 object-cover rounded-lg mb-2">
                <h4 class="font-medium text-sm">Performance</h4>
                <p class="text-xs text-gray-600">Dinamiche potenziate FastMotors™</p>
                <p class="text-sm font-bold text-blue-600">+$5,000</p>
              </div>
              <!-- Comfort Package -->
              <div class="package-option" data-package="comfort" data-price="3000">
                <img src="./images/package-lights.jpg" alt="Lights Package"
                  class="w-full h-20 object-cover rounded-lg mb-2">
                <h4 class="font-medium text-sm">Luci</h4>
                <p class="text-xs text-gray-600">Interni Premium</p>
                <p class="text-sm font-bold text-blue-600">+$800</p>
              </div>
              <!-- Sport Package -->
              <div class="package-option" data-package="sport" data-price="4500">
                <img src="./images/package-sport.jpg" alt="Sport Package"
                  class="w-full h-20 object-cover rounded-lg mb-2">
                <h4 class="font-medium text-sm">Sport</h4>
                <p class="text-xs text-gray-600">Kit Aerodinamica</p>
                <p class="text-sm font-bold text-blue-600">+$4,500</p>
              </div>
              <!-- Tech Package -->
              <div class="package-option" data-package="tech" data-price="3500">
                <img src="./images/package-tech.jpg" alt="Tech Package"
                  class="w-full h-20 object-cover rounded-lg mb-2">
                <h4 class="font-medium text-sm">Tech</h4>
                <p class="text-xs text-gray-600">Schermi intelligenti. Include Apple Car Play</p>
                <p class="text-sm font-bold text-blue-600">+$1,600</p>
              </div>
            </div>
          </div>
          <!-- Advanced Options Dropdown -->
          <div class="mb-8" id="advanced-options-section">
            <button id="advanced-toggle"
              class="flex items-center justify-between w-full py-3 px-4 bg-gray-50 hover:bg-gray-100 rounded-lg transition-colors duration-300">
              <span class="font-semibold">Opzioni di Autopilotaggio <b>FastMotors™</b></span>
              <i class="fas fa-chevron-down transition-transform duration-300" id="advanced-chevron"></i>
            </button>
            <div id="advanced-content" class="advanced-dropdown">
              <div class="grid grid-cols-1 gap-6 pt-4">
                <!-- Option 1 -->
                <div class="advanced-option" data-option="Autopilot-base" data-price="2500">
                  <img src="./images/autopilot-base.gif" alt="Autopilot-base"
                    class="w-full h-20 object-cover rounded-lg mb-2 advanced-gif" id="autopilot1">
                  <h4 class="font-medium text-sm">Versione base dell'Autopilot</h4>
                  <p class="text-xs text-gray-600">Include un Sistema di Autosterzatura e Controllo del traffico
                    adattivo, oltre al controllo dei semafori e degli stop.</p>
                  <p class="text-sm font-bold text-blue-600">+$4,800</p>
                </div>
                <!-- Option 2 -->
                <div class="advanced-option" data-option="Autopilot-advanced" data-price="1800">
                  <img src="./images/autopilot-advanced.gif" alt="Autopilot avanzato"
                    class="w-full h-20 object-cover rounded-lg mb-2 advanced-gif" id="autopilot2">
                  <h4 class="font-medium text-sm">Autopilot avanzato</h4>
                  <p class="text-xs text-gray-600">Include la versione base dell'Autopilot, più la guida assistita da
                    uno svincolo di ingresso a uno di uscita in autostrada, cambi di corsia e sorpassi avviati dal
                    conducente.</p>
                  <p class="text-sm font-bold text-blue-600">+$6,750</p>
                </div>
                <!-- Option 3 -->
                <div class="advanced-option disabled" data-option="Autopark" data-price="3200">
                  <img src="./images/autopilot-parking.gif" alt="Autopark"
                    class="w-full h-20 object-cover rounded-lg mb-2 advanced-gif" id="autopilot3">
                  <h4 class="font-medium text-sm">Autopark</h4>
                  <p class="text-xs text-gray-600">Aggiunge la funzionalità Autopark al tuo Autopilot, permettendo al
                    veicolo di individuare e fermarsi al parcheggio più vicino, entro i limiti sagoma della segnaletica
                    orizzontale.</p>
                  <p class="text-sm font-bold text-blue-600">+$1,800</p>
                </div>
                <!-- Option 4 -->
                <div class="advanced-option disabled" data-option="Smart-summon" data-price="2800">
                  <img src="./images/autopilot-smart-summon.gif" alt="Smart summon"
                    class="w-full h-20 object-cover rounded-lg mb-2 advanced-gif" id="autopilot4">
                  <h4 class="font-medium text-sm">Smart Summon</h4>
                  <p class="text-xs text-gray-600">Aggiunge la funzionalità Smart Summon al tuo Autopilot, permettendo
                    al veicolo di raggiungere la tua posizione.</p>
                  <p class="text-sm font-bold text-blue-600">+$1,500</p>
                </div>
              </div>
            </div>
          </div>
          <!-- Enhanced Accessories Section -->
          <div class="my-8" id="accessories-section">
            <h3 class="font-semibold mb-4">Accessori</h3>
            <!-- External Accessories -->
            <div class="mb-6">
              <button
                class="accessory-category-toggle flex items-center justify-between w-full py-3 px-4 bg-gray-50 hover:bg-gray-100 rounded-lg transition-colors duration-300">
                <span class="font-medium">Esterni</span>
                <i class="fas fa-chevron-down transition-transform duration-300 accessory-chevron"></i>
              </button>
              <div class="accessory-dropdown">
                <div class="space-y-3 pt-4">
                  <!-- Roof Rack -->
                  <label
                    class="accessory-item flex items-center justify-between py-3 px-4 border rounded-lg shadow hover:shadow-md transition-shadow">
                    <div class="flex items-center space-x-4">
                      <img src="./images/accessory-luci-cortesia.png" alt="Roof Rack"
                        class="w-16 h-12 object-cover rounded border">
                      <div>
                        <span class="font-medium">Luci di Cortesia</span>
                        <p class="text-sm text-gray-500">Luci LED sotto le portiere con scritta "FastMotors"</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-3">
                      <input type="checkbox" class="accessory-form-checkbox h-5 w-5" data-category="external"
                        data-price="183">
                      <span class="font-semibold text-blue-600">$183</span>
                    </div>
                  </label>
                  <!-- Mudguards -->
                  <label
                    class="accessory-item flex items-center justify-between py-3 px-4 border rounded-lg shadow hover:shadow-md transition-shadow">
                    <div class="flex items-center space-x-4">
                      <img src="./images/accessory-oscuramento-vetri.jpg" alt="Mudguards"
                        class="w-16 h-12 object-cover rounded border">
                      <div>
                        <span class="font-medium">Vetri Oscurati</span>
                        <p class="text-sm text-gray-500">Protezione raggi UV & Privacy</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-3">
                      <input type="checkbox" class="accessory-form-checkbox h-5 w-5" data-category="external"
                        data-price="250">
                      <span class="font-semibold text-blue-600">$250</span>
                    </div>
                  </label>
                  <!-- Tow Hitch -->
                  <label
                    class="accessory-item flex items-center justify-between py-3 px-4 border rounded-lg shadow hover:shadow-md transition-shadow">
                    <div class="flex items-center space-x-4">
                      <img src="./images/accessory-luci-led.jpg" alt="Tow Hitch"
                        class="w-16 h-12 object-cover rounded border">
                      <div>
                        <span class="font-medium">Fari principali a LED</span>
                        <p class="text-sm text-gray-500">Ricamati con potenza HD-Matrix</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-3">
                      <input type="checkbox" class="accessory-form-checkbox h-5 w-5" data-category="external"
                        data-price="550">
                      <span class="font-semibold text-blue-600">$550</span>
                    </div>
                  </label>
                </div>
              </div>
            </div>
            <!-- Internal Accessories -->
            <div class="mb-6">
              <button
                class="accessory-category-toggle flex items-center justify-between w-full py-3 px-4 bg-gray-50 hover:bg-gray-100 rounded-lg transition-colors duration-300">
                <span class="font-medium">Interni</span>
                <i class="fas fa-chevron-down transition-transform duration-300 accessory-chevron"></i>
              </button>
              <div class="accessory-dropdown">
                <div class="space-y-3 pt-4">
                  <!-- Center Console Trays -->
                  <label
                    class="accessory-item flex items-center justify-between py-3 px-4 border rounded-lg shadow hover:shadow-md transition-shadow">
                    <div class="flex items-center space-x-4">
                      <img src="./images/accessory-carplay.jpg" alt="Console Trays"
                        class="w-16 h-12 object-cover rounded border">
                      <div>
                        <span class="font-medium">Apple Car Play</span>
                        <p class="text-sm text-gray-500">Connettività massima del cellulare</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-3">
                      <input type="checkbox" class="accessory-form-checkbox h-5 w-5" data-category="internal"
                        data-price="350">
                      <span class="font-semibold text-blue-600">$350</span>
                    </div>
                  </label>
                  <!-- Floor Mats -->
                  <label
                    class="accessory-item flex items-center justify-between py-3 px-4 border rounded-lg shadow hover:shadow-md transition-shadow">
                    <div class="flex items-center space-x-4">
                      <img src="./images/accessory-surround.jpg" alt="Floor Mats"
                        class="w-16 h-12 object-cover rounded border">
                      <div>
                        <span class="font-medium">Impianto Audio Surround</span>
                        <p class="text-sm text-gray-500">Sistema audio a 12 altoparlanti per un'esperienza immersiva</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-3">
                      <input type="checkbox" class="accessory-form-checkbox h-5 w-5" data-category="internal"
                        data-price="160">
                      <span class="font-semibold text-blue-600">$160</span>
                    </div>
                  </label>
                  <!-- Sunshade -->
                  <label
                    class="accessory-item flex items-center justify-between py-3 px-4 border rounded-lg shadow hover:shadow-md transition-shadow">
                    <div class="flex items-center space-x-4" id="Scroll">
                      <img src="./images/accessory-sedili.jpg" alt="Sunshade"
                        class="w-16 h-12 object-cover rounded border">
                      <div>
                        <span class="font-medium">Sedili massaggianti termici</span>
                        <p class="text-sm text-gray-500">Per un comfort e relax superiore.</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-3">
                      <input type="checkbox" class="accessory-form-checkbox h-5 w-5" data-category="internal"
                        data-price="225">
                      <span class="font-semibold text-blue-600">$225</span>
                    </div>
                  </label>
                </div>
              </div>
            </div>
          </div>
          <!-- Total Price Section (INTEGRATA) -->
          <div class="pt-4">
            <h3 class="font-semibold text-lg">Prezzo Finale</h3>
            <p id="total-price" class="text-2xl font-bold">$52,490</p>
            <!-- BOTTONE AGGIUNGI AL CARRELLO (id compatibile con main.js) -->
            <button id="add-to-cart-btn"
              class="w-full mt-4 bg-blue-600 text-white py-3 px-6 rounded-lg font-semibold hover:bg-blue-700 transition-colors duration-300">
              Aggiungi al carrello
            </button>
          </div>
          <!-- Payment Breakdown -->
          <div class="border-t pt-4 mt-6">
            <h3 class="font-semibold text-lg">Pagamento del finanziamento stimato</h3>
            <div class="mt-4">
              <p>
                Anticipo:
                <span id="down-payment" class="font-bold">$5000</span>
              </p>
              <p>Durata finanziamento: <span class="font-bold">5 Anni</span></p>
              <p>Rata interessi: <span class="font-bold">3% APR</span></p>
              <p>
                Pagamento mensile stimato:
                <span id="monthly-payment" class="font-bold text-2xl">$818.65</span>
              </p>
            </div>
          </div>
        </aside>
      </main>
      <script>
        document.addEventListener("DOMContentLoaded", () => {
          const addBtn = document.getElementById("add-to-cart-btn");
          if (!addBtn) return;
          addBtn.addEventListener("click", async () => {
            // Raccogliamo tutti i dati, inclusi i prezzi di ogni opzione
            // Raccogliamo tutti i dati, inclusi i prezzi di ogni opzione
            const imageSrc = document.getElementById("frontimg")?.src || ""; // Leggiamo dall'ID della thumbnail // Usiamo la variabile globale
            // Correctly parse Italian currency format:
            // 1. Remove dots (thousands separators)
            // 2. Replace comma with dot (decimal separator)
            // 3. Remove non-numeric characters (except the new dot)
            const rawPrice = document.getElementById("total-price")?.textContent || "0";
            const cleanPrice = rawPrice.replace(/\./g, "").replace(/,/g, ".");
            const totalPrice = parseFloat(cleanPrice.replace(/[^\d.]/g, "")) || 0;
            // --- CORREZIONE ---
            // Usiamo i dati dinamici globali caricati da main2.js
            const basePrice = window.basePrice || 52490;
            const currentCarData = window.autoCorrente || { modello: 'LaFerrari' };
            const modelId = currentCarData.modello.toLowerCase().replace(/[\s-]+/g, '') || 'auto';
            // --- FINE CORREZIONE ---
            const colorEl = document.querySelector("#exterior-buttons .btn-selected img"); const selectedColor = { name: colorEl?.alt || 'N/D', price: 0 }; // Prezzo colore base è 0
            const intColorEl = document.querySelector("#interior-buttons .btn-selected img");
            const selectedInteriorColor = { name: intColorEl?.alt || 'N/D', price: 0 };
            const wheelEl = document.querySelector(".wheel-option[aria-pressed='true']");
            const wheel = { name: wheelEl?.dataset.wheel || 'standard', price: (wheelEl?.dataset.wheel === 'performance' ? 2500 : 0) };
            // Pacchetti e accessori come array di oggetti
            const packages = Array.from(document.querySelectorAll(".package-option.selected")).map(el => ({
              name: el.querySelector('h4').textContent,
              price: parseFloat(el.dataset.price)
            }));
            const accessories = Array.from(document.querySelectorAll(".accessory-form-checkbox:checked")).map(el => ({
              name: el.closest('.accessory-item').querySelector('.font-medium').textContent,
              price: parseFloat(el.dataset.price)
            }));
            const autopilotEl = document.querySelector(".advanced-option.selected");
            const autopilot = autopilotEl ? {
              name: autopilotEl.querySelector('h4').textContent,
              price: parseFloat(autopilotEl.dataset.price)
            } : null;
            const carItem = {
              // --- CORREZIONE ---
              id: modelId + '-' + Date.now(), // ID dinamico (Fixed JSP EL conflict)
              name: currentCarData.modelloReale || currentCarData.modello, // FIXED: Use Raw DB Name
              year: parseInt(currentCarData.anno) || 2024, // ADDED: Pass year to backend
              // --- FINE CORREZIONE ---
              image: imageSrc,
              basePrice: basePrice, // Ora usa window.basePrice
              totalPrice: totalPrice,
              qty: 1,
              selectedColor: selectedColor,
              selectedInteriorColor: selectedInteriorColor,
              wheel: wheel,
              packages: packages,
              accessories: accessories,
              autopilot: autopilot
            };
            try {
              const response = await fetch('<%=request.getContextPath()%>/cart/add', {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(carItem)
              });
              if (!response.ok) throw new Error("Errore del server: " + response.status);
              const data = await response.json();
              if (data.success) {
                if (typeof refreshCartDisplay === 'function') await refreshCartDisplay();
                if (typeof openCart === 'function') openCart();
              } else {
                alert("⚠️ Errore: " + (data.message || 'Errore sconosciuto'));
              }
            } catch (err) {
              console.error(err);
              alert("⚠️ Errore di rete durante l'aggiunta al carrello.");
            }
          });
        });
      </script>
      <script src="./configuratore.js"></script>
    </body>

    </html>