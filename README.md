# Android Lab Docker Container

Questo container fornisce un ambiente completo per l'analisi, il reverse engineering e la manipolazione di APK Android. Include strumenti come apktool, dex2jar, JD-GUI, Bytecode Viewer e un ambiente grafico accessibile via VNC.

## Funzionalità principali
- **openjdk-11-jdk**: Ambiente Java necessario per molti strumenti Android.
- **apktool**: Decodifica e ricompila APK Android.
- **dex2jar**: Converte file .dex in .jar per l'analisi Java.
- **JD-GUI**: Visualizzatore di bytecode Java.
- **Bytecode Viewer**: Analisi avanzata del bytecode.
- **Ambiente grafico**: Fluxbox + X11VNC + XVFB per applicazioni GUI.

## Installazione e avvio del container

1. **Costruisci l'immagine Docker:**
   ```zsh
   docker build -t android-lab .
   ```

2. **Avvia il container:**
   ```zsh
   docker run -it --rm \
     -p 5900:5900 \
     -v "$PWD/apks:/opt/android-lab/apks" \
     android-lab
   ```
   - `-p 5900:5900` espone la porta VNC.
   - `-v ...` monta la cartella degli APK.

## Connessione tramite VNC

Per accedere all'ambiente grafico (necessario per strumenti come JD-GUI o Bytecode Viewer):

1. Avvia il container come sopra.
2. Usa un client VNC (es. Remmina, TigerVNC, RealVNC) per connetterti a:
   - **Indirizzo:** `localhost`
   - **Porta:** `5900`
   - **Password:** (di default nessuna, modificabile in `entrypoint.sh`)

## Esempi di utilizzo di apktool

### Decodifica di un APK
```zsh
apktool d /opt/android-lab/apks/nomefile.apk -o /opt/android-lab/apks/nomefile_decoded
```
Questo comando estrarrà il contenuto dell'APK nella cartella `nomefile_decoded`.

### Ricompilazione di un APK modificato
```zsh
apktool b /opt/android-lab/apks/nomefile_decoded -o /opt/android-lab/apks/nomefile_mod.apk
```
Questo comando ricompila la cartella modificata in un nuovo APK.

### Altri comandi utili
- Visualizza la versione di apktool:
  ```zsh
  apktool --version
  ```
- Visualizza le opzioni disponibili:
  ```zsh
  apktool --help
  ```

## Note
- Per analisi avanzate, puoi usare dex2jar e JD-GUI:
  ```zsh
  d2j-dex2jar.sh /opt/android-lab/apks/classes.dex
  java -jar /opt/jd-gui.jar /opt/android-lab/apks/classes-dex2jar.jar
  ```
- Modifica `entrypoint.sh` per personalizzare l'avvio del container.

---
Per domande o problemi, consulta la documentazione degli strumenti inclusi o apri una issue.
