// DEBUG (attiva con ?Debug=1)
const DEBUG = new URLSearchParams(window.location.search).get('Debug') === '1';
const __debugLog = [];
let __debugPanelEl = null;

function dlog(type, message, data) { //Salva gli elementi di Debug nel log
  const entry = {
    t: new Date().toISOString(),
    type,
    message,
    data: data ?? null
  };
  __debugLog.push(entry);
  if (DEBUG) {
    const fn = type === 'error' ? console.error : (type === 'warn' ? console.warn : console.log);
    fn(`[catalogo][${type}] ${message}`, data ?? '');
    ensureDebugPanel();
    appendDebugPanel(entry);
  }
}

function ensureDebugPanel() { //Gestiche il Log in alto a destra con le informazioni di Debug nel momento in cui il catalogo viene avviato
  if (__debugPanelEl || !DEBUG) return;
  const panel = document.createElement('div');
  panel.id = 'catalogo-debug-panel';
  panel.style.cssText = `
    position: fixed;
    top: 12px;
    right: 12px;
    width: 420px;
    max-width: calc(100vw - 24px);
    max-height: calc(100vh - 24px);
    overflow: auto;
    background: rgba(10,10,10,0.92);
    color: #fff;
    z-index: 999999;
    border-radius: 10px;
    box-shadow: 0 10px 35px rgba(0,0,0,0.4);
    font-family: Arial, sans-serif;
    font-size: 12px;
    padding: 12px;
  `;
  panel.innerHTML = `
    <div style="display:flex; align-items:center; gap:8px; margin-bottom:10px;">
      <div style="font-weight:700; font-size:13px;">DEBUG catalogo</div>
      <div style="margin-left:auto; display:flex; gap:6px;">
        <button id="dbg-copy" style="cursor:pointer; border:none; padding:6px 8px; border-radius:6px;">Copia log</button>
        <button id="dbg-clear" style="cursor:pointer; border:none; padding:6px 8px; border-radius:6px;">Pulisci</button>
        <button id="dbg-close" style="cursor:pointer; border:none; padding:6px 8px; border-radius:6px;">×</button>
      </div>
    </div>
    <div id="dbg-body" style="display:flex; flex-direction:column; gap:6px;"></div>
  `;
  document.body.appendChild(panel);
  __debugPanelEl = panel;

  panel.querySelector('#dbg-close').addEventListener('click', () => panel.remove());
  panel.querySelector('#dbg-clear').addEventListener('click', () => {
    __debugLog.length = 0;
    panel.querySelector('#dbg-body').innerHTML = '';
  });
  panel.querySelector('#dbg-copy').addEventListener('click', async () => {
    const text = JSON.stringify(__debugLog, null, 2);
    try {
      await navigator.clipboard.writeText(text);
      dlog('info', 'Log copiato negli appunti');
    } catch {
      // fallback
      const ta = document.createElement('textarea');
      ta.value = text;
      document.body.appendChild(ta);
      ta.select();
      document.execCommand('copy');
      ta.remove();
      dlog('info', 'Log copiato (fallback)');
    }
  });
}

function appendDebugPanel(entry) { //Appende le varie informazioni nel log e le mostra con un colore di verso in base al tipo
  if (!__debugPanelEl) return;
  const body = __debugPanelEl.querySelector('#dbg-body');
  const color = entry.type === 'error' ? '#ff6b6b' : (entry.type === 'warn' ? '#ffd166' : '#9be7ff');
  const wrap = document.createElement('div');
  wrap.style.cssText = `
    border-left: 4px solid ${color};
    padding: 6px 8px;
    background: rgba(255,255,255,0.06);
    border-radius: 8px;
  `;
  const dataHtml = entry.data
    ? `<pre style="white-space:pre-wrap; margin:6px 0 0 0; opacity:0.9;">${escapeHtml(JSON.stringify(entry.data, null, 2))}</pre>`
    : '';
  wrap.innerHTML = `
    <div style="opacity:0.8; font-size:11px;">${entry.t}</div>
    <div><strong style="color:${color}">${escapeHtml(entry.type.toUpperCase())}</strong> — ${escapeHtml(entry.message)}</div>
    ${dataHtml}
  `;
  body.appendChild(wrap);
}

function showConfigPopup(payload) { //Mostra un pop up prima di spostarsi al configuratore mostrando quali informazioni gli stanno venendo passate
  // chiudi eventuale popup già aperto
  document.getElementById('config-debug-modal')?.remove();

  const overlay = document.createElement('div');
  overlay.id = 'config-debug-modal';
  overlay.style.cssText = `
    position: fixed; inset: 0; z-index: 1000000;
    background: rgba(0,0,0,0.55);
    display: flex; align-items: center; justify-content: center;
    padding: 16px;
  `;

  const box = document.createElement('div');
  box.style.cssText = `
    width: min(720px, 100%);
    max-height: min(80vh, 100%);
    overflow: auto;
    background: #111;
    color: #fff;
    border-radius: 12px;
    box-shadow: 0 10px 35px rgba(0,0,0,0.5);
    font-family: Arial, sans-serif;
    padding: 14px;
  `;

  const pretty = JSON.stringify(payload, null, 2);
  box.innerHTML = `
    <div style="display:flex; align-items:center; gap:8px; margin-bottom:10px;">
      <div style="font-weight:700;">Dati inviati al configuratore</div>
      <div style="margin-left:auto; display:flex; gap:8px;">
        <button id="cfg-copy" style="cursor:pointer; border:none; padding:6px 10px; border-radius:8px;">Copia</button>
        <button id="cfg-continue" style="cursor:pointer; border:none; padding:6px 10px; border-radius:8px;">Continua</button>
        <button id="cfg-close" style="cursor:pointer; border:none; padding:6px 10px; border-radius:8px;">Chiudi</button>
      </div>
    </div>
    <pre style="white-space:pre-wrap; margin:0; opacity:0.95;">${escapeHtml(pretty)}</pre>
  `;

  overlay.appendChild(box);
  document.body.appendChild(overlay);

  overlay.addEventListener('click', (e) => { if (e.target === overlay) overlay.remove(); });
  box.querySelector('#cfg-close').addEventListener('click', () => overlay.remove());

  box.querySelector('#cfg-copy').addEventListener('click', async () => {
    try {
      await navigator.clipboard.writeText(pretty);
    } catch {
      const ta = document.createElement('textarea');
      ta.value = pretty;
      document.body.appendChild(ta);
      ta.select();
      document.execCommand('copy');
      ta.remove();
    }
  });

  // Risolto da chi clicca "Continua"
  return new Promise((resolve) => {
    box.querySelector('#cfg-continue').addEventListener('click', () => {
      overlay.remove();
      resolve(true);
    });
  });
}
//Fine funzioni di Debug

document.addEventListener('DOMContentLoaded', async function () {
  try {
    dlog('info', 'Init catalogo.js avviato', { path: location.pathname, search: location.search });

    // 1) Attesa che tutte le auto siano caricate dal file JSON creato sulla base del DB
    await caricaCatalogoDaJSON();

    // 2) Inizializzazione delle immaggini e funzioni e asse legate
    initGallerie();
    initHoverAutoscroll();
    initConfiguraButtons();

    // 3) Inizializzazzione dei sistemi di filtraggio ordinamento e ricerca
    initFiltri();
    initOrdinamenti();
    initSearch();
    //Applica il sistema di filtraggio automatico in base all'url
    applicaFiltroDaURL();

    // 5) Debug: verifica reale immagini (404 / nome errato)
    if (DEBUG) {
      setupDebugImageChecks();
      dlog('info', 'Debug immagini attivo (intercetto onerror su <img>)');
    }
  } catch (e) {
    dlog('error', 'Errore inizializzazione catalogo', { error: String(e) });
  }
});

let fullCatalogData = []; //Cache client-side che contiene l'intero catalogo

function initSearch() {//Implementazione della barra di ricerca nel catalogo
  const searchInput = document.getElementById('catalogo-search');
  if (!searchInput) return;

  let debounceTimer;

  searchInput.addEventListener('input', (e) => {
    const term = e.target.value.trim();

    // Cancella il timer precedente
    clearTimeout(debounceTimer);

   // Timer effettivo della ricerca (300ms in cui l'utente non sta scrivendo)
    debounceTimer = setTimeout(async () => {
      try {
        const base = window.location.pathname.split('/')[1] || ''; //Identifica il contesto del progetto
        const param = term ? `&q=${encodeURIComponent(term)}` : ''; //Salva quanto scritto dall'utente
        const url = `/${base}/api/catalogo?action=getCatalogo${param}`; // Richiesta AJAX al backend per ricevere quali auto matchano
		//Mesaggi di errore
        const res = await fetch(url);
        if (!res.ok) throw new Error('Network response was not ok');

        const lista = await res.json();
        renderCatalogo(lista); //Aggiornamento dinamico del catalogo senza ricaricamento
      } catch (err) {
        dlog('error', 'Errore ricerca AJAX', { err });
      }
    }, 300); //Tempo di attesa
  });
}


function renderCatalogo(lista) {
  const catalogoEl = document.querySelector('.catalogo');
  if (!catalogoEl) return;

  catalogoEl.innerHTML = ''; //Svuota il catalogo (Serve nel caso in cui ci sono i filtri)
  const frag = document.createDocumentFragment(); //Crea prima le card e poi le inserisce
  let created = 0;//Variabili per il  Debug
  let skipped = 0;

  for (const a of lista) {
    // Logica per il filtro disponibilità maggiore di 0
    if (!a || a.disponibile === false || (a.quantitaStock ?? 0) <= 0) {
      skipped++;
      continue;
    }
    const card = creaCardAuto(a);
    frag.appendChild(card);
    created++;
  }

  catalogoEl.appendChild(frag); //inserimento delle card nel DOM

  // Gestione messaggio "Nessun Risultato"
  const noResultsMsg = document.getElementById('no-results-message');
  if (noResultsMsg) {
    noResultsMsg.style.display = (created === 0) ? 'block' : 'none';
  }

  dlog('info', 'Render catalogo', { created, skipped }); //render per il Debug

  // Re-inizializza componenti e chiamata all'animazione per lo scroll
  initGallerie();
  initHoverAutoscroll();
  initConfiguraButtons();

  // --- NUOVA LOGICA ANIMAZIONE SCROLL ---
  // Invece di mostrare tutto subito, attiviamo l'Observer
  setupScrollAnimations(); 
}

function setupScrollAnimations() {//Funzione per le animazioni che fanno apparire le card con lo scroll
  const cards = document.querySelectorAll('.auto:not(.auto-visible)');
  
  // Configurazione dell'Observer
  const observerOptions = {
    root: null,   // osserva rispetto alla finestra del browser
    rootMargin: '0px',
    threshold: 0.1 // scatta quando il 10% della card è visibile
  };

  const observer = new IntersectionObserver((entries, observerInstance) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        // La card è entrata nello schermo: aggiungi la classe per animarla
        entry.target.classList.add('auto-visible');
        
        // Smetti di osservare questa card (l'animazione avviene una volta sola)
        observerInstance.unobserve(entry.target);
      }
    });
  }, observerOptions);

  cards.forEach(card => {
    observer.observe(card);
  });
}


function initGallerie() {//Funzione per le gallerie delle varie car
  const containers = document.querySelectorAll('[class*="galleria-container"]');
  dlog('info', 'initGallerie: containers trovati', { count: containers.length });

  containers.forEach(container => {//Iterazione su ogni galleria
    const galleria = container.querySelector('.galleria'); //recupera lo slider
    const immagini = Array.from(container.querySelectorAll('.auto-immagine')); //Recupera tutte le immaggini legate alla singola auto
    const btnPrev = container.querySelector('.freccia-sinistra');//Gestione delle freccie destra, sinistra e del puntino sottostante
    const btnNext = container.querySelector('.freccia-destra');
    const puntini = Array.from(container.querySelectorAll('.puntino'));
    if (!galleria || immagini.length === 0) return;
	//Gestione dinamica dello stile 
    let index = 0;
    galleria.style.display = 'flex';
    galleria.style.transition = 'transform 0.35s ease';
    immagini.forEach(img => { img.style.flex = '0 0 100%'; });
	//funzioni per lo spostamento all'immaggine precedente e sucessiva
    function aggiornaUI() {
      galleria.style.transform = `translateX(-${index * 100}%)`;
      if (puntini.length) puntini.forEach((p, i) => p.classList.toggle('attivo', i === index));
    }
    function next() { index = (index + 1) % immagini.length; aggiornaUI(); }
    function prev() { index = (index - 1 + immagini.length) % immagini.length; aggiornaUI(); }

    btnNext?.addEventListener('click', (e) => { e.preventDefault(); next(); });
    btnPrev?.addEventListener('click', (e) => { e.preventDefault(); prev(); });

    puntini.forEach((p, i) => {
      p.addEventListener('click', (e) => { e.preventDefault(); index = i; aggiornaUI(); });
    });

    aggiornaUI();
  });
}


async function caricaCatalogoDaJSON() {//Funzione che carica il catalogo in formato JSON
  const catalogoEl = document.querySelector('.catalogo');
  if (!catalogoEl) {
    dlog('error', 'Elemento .catalogo non trovato nel DOM'); //log per l'errore se il catalogo non è stato caricato correttamente
    return;
  }

  const base = window.location.pathname.split('/')[1] || '';//recupera il contesto 
  const url = `/${base}/api/catalogo?action=getCatalogo`;//Chiamata per recuperare il catalogo dal backend
  dlog('info', 'Fetch catalogo', { url });

  const res = await fetch(url);
  dlog('info', 'Risposta fetch catalogo', { ok: res.ok, status: res.status, contentType: res.headers.get('content-type') });
  if (!res.ok) throw new Error(`HTTP ${res.status} su ${url}`);

  const lista = await res.json(); //Converte il catalogo ricevuto in un file JSON
  dlog('info', 'Catalogo JSON ricevuto', { items: Array.isArray(lista) ? lista.length : 'NON-ARRAY' });

  fullCatalogData = lista; // Salva dati globalmente
  renderCatalogo(fullCatalogData);
}

function creaCardAuto(a) {
  const marcaLabel = (a.marca || '').trim();
  const marcaData = marcaLabel.toLowerCase();
  const modello = (a.modello || '').trim();
  const anno = a.anno;
  const motore = (a.motore || '').trim();
  const potenza = (a.potenza || '').trim();
  const prezzoNum = Number(a.prezzo ?? 0);
  const coloreDefault = (a.coloreDefault || '').trim();

  const coloreToClass = {
    'rosso': 'R',
    'blu': 'B',
    'giallo': 'Y',
    'verde': 'G',
    'nero': 'BL',
    'bianco': 'W',
    'grigio': 'GY',
    'arancione': 'O',
    'viola': 'P',
    'oro': 'S',
    'default': 'W'
  };

  const coloreNorm = coloreDefault.toLowerCase().trim();
  const coloreKey = coloreToClass[coloreNorm] || coloreToClass['default'];

  const baseImg = modelloToFilenameBase(modello);

  const wrapper = document.createElement('div');
  wrapper.className = 'auto';

  
  /*Inizializazione delle gallerie */wrapper.innerHTML = `
    <div class="galleria-container${coloreKey}">
      <div class="galleria">
        <img data-src="images/${escapeHtml(baseImg)} (1).png" class="auto-immagine">
        <img data-src="images/${escapeHtml(baseImg)} (2).png" class="auto-immagine">
        <img data-src="images/${escapeHtml(baseImg)} (3).png" class="auto-immagine">
        <img data-src="images/${escapeHtml(baseImg)} (4).png" class="auto-immagine">
      </div>
      <div class="logo-marca">${escapeHtml(marcaLabel)}</div>
      <button class="freccia freccia-sinistra">&#10094;</button>
      <button class="freccia freccia-destra">&#10095;</button>
      <div class="indicatori">
        <span class="puntino attivo"></span>
        <span class="puntino"></span>
        <span class="puntino"></span>
        <span class="puntino"></span>
      </div>
    </div>
    <div class="dati">
      <h2>
        ${escapeHtml(modello)}
        <img data-src="images/${escapeHtml(marcaLabel)}.png" class="logo-img" alt="${escapeHtml(marcaLabel)}">
      </h2>
      <div class="specifiche">
        <p><span>Anno:</span> ${escapeHtml(String(anno))}</p>
        <p><span>Motore:</span> ${escapeHtml(motore)}</p>
        <p><span>Potenza:</span> ${escapeHtml(potenza)}</p>
        <button class="configura-btn"
          data-marca="${escapeHtml(marcaData)}"
          data-modello="${escapeHtml(modello)}"
          data-colore="${escapeHtml(coloreDefault)}"
          data-prezzo="${escapeHtml(String(prezzoNum))}">
          Configura questo modello
        </button>
      </div>
      <div class="prezzo">${formatEuro(prezzoNum)}</div>
    </div>
  `;

  wrapper.querySelectorAll('img.auto-immagine').forEach(img => {//fallback1
    const s = img.getAttribute('data-src');
    if (s) attachImgCaseFallback(img, s);
  });
  wrapper.querySelectorAll('img.logo-img').forEach(img => {//fallback2
    const s = img.getAttribute('data-src');
    if (s) attachImgCaseFallback(img, s);
  });

  return wrapper;
}

function modelloToFilenameBase(modello) {//converte il modello nel nome del file immagine
  return modello;
}

function normalizzaModelloPerConfiguratore(modello) {//normalizzazione del nome del modello (rimozzione marca)
  if (!modello) return modello;
  const parts = modello.trim().split(/\s+/);
  if (parts.length > 1) return parts.slice(1).join(' ');
  return modello;
}

function normalizeForAsset(marca, modello) {//normalizzazione del modello per la marca per i path delle immagini del configuratore (rimozzione marca, spazi e caratteri non alfa-numerici)
  const m = String(marca || '').trim().toLowerCase();
  let x = String(modello || '').trim().toLowerCase();
  if (m && x.startsWith(m + ' ')) x = x.slice(m.length + 1);
  x = x.replace(/\s+/g, '');
  x = x.replace(/[^a-z0-9]/g, '');
  return x;
}

function normalizzaModelloPerConfiguratoreConEccezioni(modelloRaw) { //eccezzioni di normalizazione per evitare di rinominare le immaggini
  const raw = String(modelloRaw || '').trim();
  const k = raw.toLowerCase().replace(/\s+/g, '').replace(/[^a-z0-9]/g, '');
  const EX = {
    'laferrari': 'la ferrari',
    'sf90': 'sf',
    'attackodin': 'Jesko',
    '911carrera4s': '911'
  };
  if (EX[k]) return EX[k];
  return normalizzaModelloPerConfiguratore(raw);
}

function applyAssetExceptions(assetKey) {//eccezzioni per casi specifici con nomi non alineati
  const EX = {
    LaFerrari: 'laferrari',
    SF90: 'sf',
    attackodin: 'jesko',
    carrera4s: '911'
  };
  return EX[assetKey] ?? assetKey;
}

function formatEuro(n) {//formato prezzo in euro
  const it = Math.round(n).toLocaleString('it-IT');
  return `€${it}`;
}

function escapeHtml(s) {
  return String(s)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&#39;');
}

function toTitleCase(s) {
  return String(s).toLowerCase().replace(/\b\w/g, c => c.toUpperCase());
}

function buildCaseFallbackCandidates(pathWithName) {
  const m = String(pathWithName).match(/^(.*\/)([^\/]+)$/);
  if (!m) return [pathWithName];
  const dir = m[1];
  const file = m[2];
  const dot = file.lastIndexOf('.');
  const name = dot >= 0 ? file.slice(0, dot) : file;
  const ext = dot >= 0 ? file.slice(dot) : '';
  const parts = name.split(' ');
  const firstCapRestSame =
    parts.length > 0
      ? [parts[0].charAt(0).toUpperCase() + parts[0].slice(1), ...parts.slice(1)].join(' ') + ext
      : file;

  const lower = name.toLowerCase() + ext;
  const upper = name.toUpperCase() + ext;
  const title = name.toLowerCase().replace(/\b\w/g, c => c.toUpperCase()) + ext;
  const out = [];

  [file, firstCapRestSame, lower, upper, title].forEach(f => {
    const full = dir + f;
    if (!out.includes(full)) out.push(full);
  });

  return out;
}

function attachImgCaseFallback(imgEl, initialSrc) { //fallback per le immaggini
  const candidates = buildCaseFallbackCandidates(initialSrc);
  let idx = 0;
  imgEl.src = candidates[idx];

  function onErr() {
    idx++;
    if (idx < candidates.length) {
      dlog('warn', 'IMG fallback case', { from: candidates[idx - 1], to: candidates[idx] });
      imgEl.src = candidates[idx];
    } else {
      dlog('warn', 'IMG NOT FOUND (all case variants)', { tried: candidates });
      imgEl.removeEventListener('error', onErr);
    }
  }

  imgEl.addEventListener('error', onErr);
}


function setupDebugImageChecks() { //debug per le immagini
  const imgs = Array.from(document.querySelectorAll('img.auto-immagine'));
  dlog('info', 'Immagini in pagina', { count: imgs.length });
  const failed = [];
  const ok = [];

  imgs.forEach((img) => {
    if (img.__dbgHooked) return;
    img.__dbgHooked = true;

    img.addEventListener('load', () => {
      ok.push(img.src);
    });
    img.addEventListener('error', () => {
      failed.push(img.getAttribute('src') || img.src);
      dlog('warn', 'IMG NOT FOUND / ERROR', { src: img.getAttribute('src') || img.src });
    });
  });

  setTimeout(() => {
    dlog('info', 'Riepilogo immagini', { ok: ok.length, failed: failed.length, sampleFailed: failed.slice(0, 20) });
  }, 1200);
}


function applicaFiltroDaURL() { // gestione del Filtro automatico da URL
  const hash = window.location.hash.substring(1);
  if (hash && hash !== 'tutte') {
    const marcheValide = ['ferrari', 'lamborghini', 'porsche', 'mclaren', 'bugatti', 'koenigsegg']; //se riconosce nell'url uno di questi elementi
    if (marcheValide.includes(hash)) {
      setTimeout(() => {
        const filtroElement = document.querySelector(`.filtro-contenuto div[data-marca="${hash}"]`);
        if (filtroElement && !filtroElement.classList.contains('active')) {
          dlog('info', 'Applico filtro da URL', { hash });
          filtroElement.click(); //simula il click sul filtro con quel nome
        }
      }, 300);
    }
  }
}


async function nascondiAutoNonDisponibili() { //funzione che nasconde le card delle auto non disponibili (non piu utilizzata)
  try {
    const base = window.location.pathname.split('/')[1] || '';
    const url = `/${base}/api/catalogo?action=getAutoDisponibili`;
    dlog('info', 'Fetch disponibilità', { url });

    const response = await fetch(url);
    dlog('info', 'Risposta disponibilità', { ok: response.ok, status: response.status, contentType: response.headers.get('content-type') });
    if (!response.ok) return;

    const ct = (response.headers.get('content-type') || '').toLowerCase();
    const raw = await response.text();

    if (!ct.includes('application/json')) {
      dlog('error', 'Disponibilità: content-type non JSON', { contentType: ct, preview: raw.slice(0, 300) });
      return;
    }

    let disponibilita;
    try {
      disponibilita = JSON.parse(raw);
    } catch (e) {
      dlog('error', 'Disponibilità: JSON.parse fallito', { error: String(e), preview: raw.slice(0, 300) });
      return;
    }

    const keys = Object.keys(disponibilita);
    dlog('info', 'Disponibilità: chiavi ricevute', { count: keys.length, sample: keys.slice(0, 20) });

    let autoNascoste = 0;
    let autoVisibili = 0;
    const mismatchKeys = [];

    document.querySelectorAll('.auto').forEach((autoElement) => {
      const h2 = autoElement.querySelector('h2');
      const pAnno = autoElement.querySelector('.specifiche p:nth-child(1)');
      if (!h2 || !pAnno) return;

      const titolo = h2.textContent;
      const modello = titolo.replace(/\s+/g, '').trim();
      const annoMatch = (pAnno.textContent.match(/\d{4}/) || [null])[0];
      const anno = annoMatch ? parseInt(annoMatch, 10) : NaN;

      const chiave = `${modello}_${anno}`;
      const hasKey = Object.prototype.hasOwnProperty.call(disponibilita, chiave);
      const val = hasKey ? disponibilita[chiave] : undefined;
      if (!hasKey) mismatchKeys.push(chiave);

      if (val === false) {
        autoElement.style.display = 'none';
        autoNascoste++;
      } else {
        autoElement.style.display = 'flex';
        autoVisibili++;
      }
    });

    dlog('info', 'Disponibilità: risultato applicazione', {
      autoVisibili,
      autoNascoste,
      mismatchCount: mismatchKeys.length,
      mismatchSample: mismatchKeys.slice(0, 30)
    });
  } catch (e) {
    dlog('error', 'Errore generale in nascondiAutoNonDisponibili', { error: String(e) });
  }
}


function initFiltri() { //gestione del sistema di filtraggio per marca
  const opzioniFiltro = document.querySelectorAll('.filtro-contenuto div[data-marca]');
  const scrittaCatalogo = document.getElementById('scritta-catalogo');
  const testoBrand = document.getElementById('testo-brand');
  const chiudiScritta = document.getElementById('chiudi-scritta');
  const filtroPrezzoBtn = document.querySelector('.filtro-prezzo-btn');
  const boxFiltroPrezzo = document.querySelector('.filtro-prezzo-box');
  const applicaFiltroPrezzo = document.getElementById('applica-filtro-prezzo');
  const resetFiltroPrezzo = document.getElementById('reset-filtro-prezzo');

  if (!opzioniFiltro.length) return;

  const testiBrand = {//Testi specifici legati ai singoli brand
    'ferrari': 'Ferrari rappresenta il connubio perfetto tra passione, eleganza e performance assoluta. Fondata nel 1947 da Enzo Ferrari, la casa di Maranello ha trasformato il concetto stesso di automobile in un simbolo universale di eccellenza italiana. Ogni modello nasce dal DNA delle corse, con linee scolpite dall\'aerodinamica e motori che vibrano come strumenti musicali, capaci di trasmettere emozioni uniche già al primo avviamento. Ferrari non è soltanto un costruttore di auto, ma un\'icona culturale che incarna sogno e desiderio. Entrare a bordo significa vivere un\'esperienza che va oltre la guida: è appartenere a una leggenda, fatta di innovazione continua, artigianato raffinato e trionfi senza tempo nel motorsport.',
    'lamborghini': 'Lamborghini è sinonimo di audacia, potenza e design fuori dagli schemi. Fondata nel 1963 da Ferruccio Lamborghini, la casa di Sant\'Agata Bolognese ha rivoluzionato l\'idea di supercar, puntando su un linguaggio stilistico aggressivo e inconfondibile. Le sue linee taglienti, ispirate al mondo dell\'aeronautica e agli artigli dei tori da combattimento, incarnano la pura espressione della velocità. Sotto il cofano, i motori V10 e V12 erogano una sinfonia meccanica capace di far battere il cuore di chiunque ami l\'adrenalina. Lamborghini non costruisce semplici automobili: realizza opere d\'arte su ruote che sfidano i limiti della tecnologia e celebrano la libertà di spingersi sempre oltre.',
    'porsche': 'Porsche unisce tradizione e innovazione come nessun altro marchio. Nata nel 1948 con la leggendaria 356, la casa di Stoccarda ha scritto la storia della sportività su strada e in pista. Ogni Porsche rappresenta il perfetto equilibrio tra ingegneria tedesca e piacere di guida, con una filosofia che punta alla precisione assoluta e a un design intramontabile. L\'inconfondibile silhouette della 911 è diventata un\'icona mondiale, simbolo di prestazioni e raffinatezza senza compromessi. Ma Porsche non è solo passato glorioso: oggi è anche avanguardia, con soluzioni ibride ed elettriche che mantengono intatta l\'anima sportiva. Guidare una Porsche significa vivere la passione per la velocità con classe e autenticità.',
    'mclaren': 'McLaren è il ponte tra la pista e la strada, un marchio che porta l\'anima della Formula 1 nell\'esperienza quotidiana di guida. Fondata da Bruce McLaren nel 1963, la casa britannica ha costruito la propria leggenda nelle competizioni e ha trasferito lo stesso spirito nelle supercar di produzione. Ogni McLaren è una fusione di tecnologia avanzata, materiali innovativi e design orientato alla massima efficienza aerodinamica. Il risultato sono vetture che offrono un connubio unico di leggerezza, precisione e potenza brutale. Con McLaren, guidare significa vivere un\'esperienza pura, dinamica e coinvolgente, dove ogni curva diventa un\'emozione da ricordare.',
    'bugatti': 'Bugatti rappresenta l\'essenza del lusso automobilistico spinto oltre ogni limite. Dalla sua fondazione nel 1909 a Molsheim, il marchio francese ha sempre unito eleganza artistica e ingegneria all\'avanguardia. Oggi, con modelli come la Veyron e la Chiron, Bugatti è sinonimo di prestazioni assolute, con velocità che sfidano la fisica e una cura artigianale che trasforma ogni dettaglio in un gioiello. Ogni Bugatti è una scultura in movimento, creata per coniugare comfort regale e potenza senza compromessi. Non è solo un\'auto, ma un\'esperienza di vita riservata a pochi eletti: un capolavoro che unisce passato, presente e futuro del lusso più estremo.',
    'koenigsegg': 'Koenigsegg è il nome che ha ridefinito il concetto di hypercar. Fondata nel 1994 da Christian von Koenigsegg, l\'azienda svedese ha saputo imporsi come laboratorio di ingegneria estrema, dove ogni dettaglio è progettato per raggiungere traguardi mai esplorati antes. Materiali ultraleggeri, soluzioni aerodinamiche innovative e motori capaci di erogare potenze straordinarie rendono ogni modello un capolavoro di tecnologia. Koenigsegg non si limita a costruire auto veloci: crea esperienze radicali, pensate per chi desidera vivere il massimo della performance in ogni istante. Ogni vettura è una rarità esclusiva, destinata a entrare nella leggenda come testimonianza di cosa può nascere dall\'audacia e dalla visione.'
  };

  let marcaCorrente = 'tutte';
  let prezzoMinCorrente = 0;
  let prezzoMaxCorrente = Number.MAX_SAFE_INTEGER;

  async function applicaFiltroMarca(marcaSelezionata) {
    await nascondiAutoNonDisponibili();
    marcaCorrente = marcaSelezionata;
    applicaFiltri();
  }

  async function resettaFiltri() {//reset dei filtri
    await nascondiAutoNonDisponibili();
    marcaCorrente = 'tutte';
    opzioniFiltro.forEach(op => op.classList.remove('active'));
    document.querySelector('.filtro-contenuto div[data-marca="tutte"]')?.classList.add('active');
    document.getElementById('prezzo-min').value = '';
    document.getElementById('prezzo-max').value = '';
    prezzoMinCorrente = 0;
    prezzoMaxCorrente = Number.MAX_SAFE_INTEGER;
    applicaFiltri();
    if (scrittaCatalogo) scrittaCatalogo.style.display = 'none';
  }

  function applicaFiltri() {//funzione che mostra nel DOM solo le auto che rispettano il filtro
    const autoCards = document.querySelectorAll('.auto');//Scorrimento di tutte le card
    let autoVisibili = 0;

    autoCards.forEach(auto => {//lavora solo sulle card visibili
      if (auto.style.display === 'none') return;
	  //estrazione dei dati
      const autoMarca = (auto.querySelector('.logo-marca')?.textContent || '').toLowerCase().trim();
      const prezzoAuto = parseInt(auto.querySelector('.prezzo')?.textContent.replace(/[^\d]/g, '') || '0', 10);
	  //verifica del match
      const matchMarca = (marcaCorrente === 'tutte' || autoMarca === marcaCorrente);
      const matchPrezzo = (prezzoAuto >= prezzoMinCorrente && prezzoAuto <= prezzoMaxCorrente);
	  //applica visibilità
      auto.style.display = (matchMarca && matchPrezzo) ? 'flex' : 'none';
      if (matchMarca && matchPrezzo) autoVisibili++;
    });
	//gestione della scritta
    if (scrittaCatalogo && testoBrand) {
      if (marcaCorrente !== 'tutte' && testiBrand[marcaCorrente] && autoVisibili > 0) {
        testoBrand.textContent = testiBrand[marcaCorrente];
        scrittaCatalogo.style.display = 'block';
      } else {
        scrittaCatalogo.style.display = 'none';
      }
    }

    // Gestione messaggio "Nessun Risultato" (filtri)
    const noResultsMsg = document.getElementById('no-results-message');
    if (noResultsMsg) {
      noResultsMsg.style.display = (autoVisibili === 0) ? 'block' : 'none';
    }
  }

  opzioniFiltro.forEach(opzione => {
    opzione.addEventListener('click', async function () {
      const marcaSelezionata = this.getAttribute('data-marca');
      if (marcaSelezionata === 'tutte') {
        await resettaFiltri();
        return;
      }
      opzioniFiltro.forEach(op => op.classList.remove('active'));
      this.classList.add('active');
      await applicaFiltroMarca(marcaSelezionata);
    });
  });

  applicaFiltroPrezzo?.addEventListener('click', function () {
    const prezzoMin = document.getElementById('prezzo-min').value;
    const prezzoMax = document.getElementById('prezzo-max').value;
    prezzoMinCorrente = parseInt(prezzoMin) || 0;
    prezzoMaxCorrente = parseInt(prezzoMax) || Number.MAX_SAFE_INTEGER;
    applicaFiltri();
    if (boxFiltroPrezzo) boxFiltroPrezzo.style.display = 'none';
  });

  resetFiltroPrezzo?.addEventListener('click', function (e) {
    e.preventDefault?.();
    window.location.reload();
  });

  filtroPrezzoBtn?.addEventListener('click', function () {
    const isVisible = boxFiltroPrezzo?.style.display === 'block';
    if (boxFiltroPrezzo) boxFiltroPrezzo.style.display = isVisible ? 'none' : 'block';
  });

  chiudiScritta?.addEventListener('click', function () {
    if (scrittaCatalogo) scrittaCatalogo.style.display = 'none';
  });

  document.querySelector('.filtro-contenuto div[data-marca="tutte"]')?.classList.add('active');
}

function initOrdinamenti() { // gesione dell'ordinamento del catalogo
  const opzioniOrdine = document.querySelectorAll('.ordina-contenuto div');
  const catalogo = document.querySelector('.catalogo');
  if (!opzioniOrdine.length || !catalogo) return;

  opzioniOrdine.forEach(opzione => {
    opzione.addEventListener('click', function () {
      const ordine = this.getAttribute('data-ordine');
      let autoCards = Array.from(document.querySelectorAll('.auto')); 	  //array con tutte le auto visibili

	  //ordinamento in base ai dati recuperati dalle card visibili
      if (ordine === 'prezzo-crescente') { 
        autoCards.sort((a, b) => prezzoDaCard(a) - prezzoDaCard(b));
      } else if (ordine === 'prezzo-decrescente') {
        autoCards.sort((a, b) => prezzoDaCard(b) - prezzoDaCard(a));
      } else if (ordine === 'anno-crescente') {
        autoCards.sort((a, b) => estraiDato(a, 'Anno:') - estraiDato(b, 'Anno:'));
      } else if (ordine === 'anno-decrescente') {
        autoCards.sort((a, b) => estraiDato(b, 'Anno:') - estraiDato(a, 'Anno:'));
      } else if (ordine === 'potenza-crescente') {
        autoCards.sort((a, b) => estraiDato(a, 'Potenza:') - estraiDato(b, 'Potenza:'));
      } else if (ordine === 'potenza-decrescente') {
        autoCards.sort((a, b) => estraiDato(b, 'Potenza:') - estraiDato(a, 'Potenza:'));
      }

      catalogo.innerHTML = '';
      autoCards.forEach(auto => catalogo.appendChild(auto));
    });
  });

  function prezzoDaCard(card) {
    return parseInt(card.querySelector('.prezzo')?.textContent.replace(/[^\d]/g, '') || '0', 10);
  }

  function estraiDato(auto, dato) {
    const specifiche = auto.querySelectorAll('.specifiche p');
    for (let p of specifiche) {
      if (p.textContent.includes(dato)) {
        return parseInt(p.textContent.replace(/[^\d]/g, '') || '0', 10);
      }
    }
    return 0;
  }
}

 
function initHoverAutoscroll() { //scroll automatico a destra per hover sulla galleria
  const gallerie = document.querySelectorAll('[class*="galleria-container"]');
  gallerie.forEach(container => {
    let timeoutId;
    const frecciaDestra = container.querySelector('.freccia-destra');
    container.addEventListener('mouseenter', function () {
      timeoutId = setTimeout(function () {
        frecciaDestra?.click();
      }, 2000);
    });
    container.addEventListener('mouseleave', function () {
      clearTimeout(timeoutId);
    });
  });
}


function initConfiguraButtons() { //gestione del passaggio delle informazioni al configuratore
  const configuraButtons = document.querySelectorAll('.configura-btn');
  configuraButtons.forEach(button => {
    button.addEventListener('click', function () {
      const marca = this.getAttribute('data-marca');
      const modelloRaw = this.getAttribute('data-modello');
      const modello = normalizzaModelloPerConfiguratoreConEccezioni(modelloRaw);
      const autoEl = this.closest('.auto');
      const colore = (this.getAttribute('data-colore') || '').trim() || 'Nero';

      let modelloAsset = normalizeForAsset(marca, modelloRaw);
      modelloAsset = applyAssetExceptions(modelloAsset);

      const imagePath = `./images/${String(marca).toLowerCase()}/${modelloAsset}.jfif`;

      const payloadDebug = {
        marcaAttr: marca,
        modelloRawAttr: modelloRaw,
        modelloNormalizzato: modello,
        modelloAsset: modelloAsset,
        coloreAttr: this.getAttribute('data-colore'),
        coloreFinale: colore,
        imagePath: imagePath
      };

      const autoData = {
        marca: marca,
        modello: modello,
        modelloReale: modelloRaw,
        colore: colore,
        prezzoBase: this.getAttribute('data-prezzo'),
        anno: (autoEl?.querySelector('.specifiche p:nth-child(1)')?.textContent.match(/\d{4}/)?.[0]) || '',
        motore: (autoEl?.querySelector('.specifiche p:nth-child(2)')?.textContent.split(':').slice(1).join(':') || '').trim(),
        potenza: (autoEl?.querySelector('.specifiche p:nth-child(3)')?.textContent.split(':').slice(1).join(':') || '').trim(),
        imagePath: imagePath
      };

      if (DEBUG) {
        showConfigPopup({ autoData, debug: payloadDebug }).then(() => {
          sessionStorage.setItem('autoSelezionata', JSON.stringify(autoData));
          window.location.href = 'configuratore.jsp';
        });
      } else {
        sessionStorage.setItem('autoSelezionata', JSON.stringify(autoData));
        window.location.href = 'configuratore.jsp';
      }
    });
  });
}