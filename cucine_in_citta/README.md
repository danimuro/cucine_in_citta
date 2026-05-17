# Cucine in Città

App Flutter standalone che permette di esplorare le cucine disponibili in una città usando le API pubbliche di BestieBite.

## Come runnarlo

- Dispositivo o simulatore iOS

**Setup**
```bash
git clone <url-repo>
cd cucine_in_citta
flutter pub get
flutter run
```

Testato su iPhone 17 Pro con Flutter 3.29.3 e iOS 26.4.1.

## Architettura

- **Riverpod** come state management — `StateNotifierProvider` per la logica di ricerca
- **Sealed classes** per modellare gli stati UI (`SearchIdle`, `SearchTyping`, `SearchSuggestions`, ecc.) — nessuno stato illegale possibile
- **Repository pattern** — `BestieBiteRepository` è l'unico punto di contatto con le API, iniettato nel notifier tramite provider
- **Debounce da 1s** sull'autocomplete — una sola chiamata API per parola digitata
- **Widget separati per stato** — ogni stato ha il suo widget dedicato, `ExploreScreen` fa solo lo switch

## Una cosa di cui sono orgoglioso

Avere imparato velocemente l'utilizzo base di Riverpod in quanto arrivavo da architetture MVVM.

## Una cosa che farei diversamente con più tempo

Aggiungerei `cached_network_image` per le immagini delle cucine, così non vengono ricaricate ogni volta che si rientra nella griglia.
E stessa cosa anche per le città nelle suggestions, salvandole in cache dopo la prima ricerca per poi creare un altro metodo che faccia il match lato codice e non API.