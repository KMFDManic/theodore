[:gb:](https://github.com/Zlika/theodore/blob/master/README.md)
[:fr:](https://github.com/Zlika/theodore/blob/master/README-FR.md)

Theodore - Emulateur Thomson MO/TO
=====================================

[![Build status](https://travis-ci.org/Zlika/theodore.svg?branch=master)](https://travis-ci.org/Zlika/theodore)
[![Build status](https://ci.appveyor.com/api/projects/status/7lo7cohkpmn50ogk?svg=true)](https://ci.appveyor.com/project/Zlika/theodore)
[![Coverity Scan Build Status](https://scan.coverity.com/projects/15677/badge.svg)](https://scan.coverity.com/projects/zlika-theodore)
[![GitHub tag](https://img.shields.io/github/tag/Zlika/theodore.svg)](https://github.com/Zlika/theodore/releases)

Theodore est un "core" [libretro](https://github.com/libretro) émulant un ordinateur [Thomson](https://fr.wikipedia.org/wiki/Gamme_MOTO). Cet émulateur est dérivé des émulateurs [DCTO8D](http://dcto8.free.fr/), [DCTO9P](http://dcto9p.free.fr/) et [DCMO5](http://dcmo5.free.fr/) de Daniel Coulom, et supporte actuellement les modèles suivants: TO8, TO8D, TO9, TO9+, MO5.

### Instructions d'installation

Cet émulateur est disponible sur les plateformes suivantes :
* RetroArch : [Installer RetroArch](http://www.retroarch.com/?page=platforms), puis démarrer RetroArch et télécharger le core "theodore" via le "Core Updater".
* [Recalbox](https://www.recalbox.com/) : Theodore est inclus dans votre console de retrogaming préférée depuis la version 2018.06.27.

Il devrait être compatible avec toutes les plateformes supportées par RetroArch (Android, Linux, MacOS, Raspberry Pi, Windows, Nintendo...).

### Instructions de compilation

Sur Linux (et la plupart des autres plateformes) :
```
make
```
Le "core" peut alors s'exécuter avec un "frontend" libretro tel que RetroArch :
```
retroarch -L theodore_libretro.so
```

Pour compiler la version Android, le [NDK Android](https://developer.android.com/ndk/downloads/) doit être utilisé :
```
cd jni
ndk-build
```

### :video_game: Correspondance des boutons de la manette

A => Bouton "Action"

B => Simule la frappe d'une touche sur le clavier pour démarrer un jeu. TO8/TO8D/TO9+ : touche 'B' (BASIC 512), TO9 : touche 'D' (BASIC 128). Si le jeu ne démarre pas, c'est sans doute qu'un autre BASIC doit être utilisé. Cette fonctionnalité permet de démarrer la plupart des jeux sans avoir besoin d'un clavier.

**Fonctionnalité de clavier virtuel :** les boutons Y/X de la manette permettent de faire défiler des chiffres/lettres (Y=défilement vers le bas, X=défilement vers le haut). La bouton "start" simule un appui sur la touche choisie. Pour les manettes sans boutons Y/X, le bouton "select" peut être aussi utilisé pour faire défiler les touches du clavier virtuel.
L'ordre des touches du clavier virtuel est : chiffres (0 à 9), puis lettres (A à Z) puis "Espace" puis "Entrée".

### Correspondance des touches spéciales du clavier

| Clavier Thomson | Clavier PC |
| ------------- | ------------- |
| STOP  | TAB  |
| CNT  | CTRL  |
| CAPSLOCK  | CAPSLOCK  |
| ACC  | ALT  |
| HOME  | HOME  |
| Flèches  | Flèches  |
| INS  | INSERT  |
| EFF  | DEL  |
| F1-F5  | F1-F5  |
| F6-F10  | SHIFT+F1-F5  |

RetroArch utilise beaucoup de raccourcis clavier, ce qui interfère avec l'émulation du clavier de ce core. Pour éviter ce problème, il suffit de configurer une "Hotkey" pour RetroArch, comme indiqué dans [Introduction to Hotkeys](https://docs.libretro.com/guides/retroarch-keyboard-controls/#introduction-to-hotkeys).

### :floppy_disk: Formats de fichiers supportés

L'émulateur peut lire les formats de fichiers suivants : *.fd et *.sap (disquettes), *.k7 (cassettes), *.m7/*.m5 et *.rom (cartouches).

### Variantes Thomson émulées

Par défaut, un ordinateur T08 est émulé. En utilisant l'option "Thomson flavor", il est possible d'émuler d'autres versions (actuellement : TO8, TO8D, TO9, TO9+, MO5).

### Sauvegardes instantanées

L'émulateur supporte la fonctionnalité de "save state" (sauvegarde instantanée) de libretro. Sur RetroArch, cette fonctionnalité est accessible par défaut via les touches F2 (sauvegarde), F4 (chargement), F6/F7 (changement du slot de sauvegarde).

### :innocent: Codes de triche

L'émulateur permet d'utiliser des codes de triche ("cheat codes") au format suivant : 0AAAAA:DD, avec AAAAA l'adresse en RAM (en hexadécimal) et DD la valeur (en hexadécimal) qui sera écrite à l'adresse en question après chaque invocation de la fonction retro_run().

Cf. le répertoire "cheat" qui contient des exemples de cheat codes ainsi qu'un script Python permettant de trouver des cheat codes à partir de plusieurs fichiers de sauvegarde instantanée (save states).

### Désassembleur / Debugger

L'émulateur dispose d'un petit désassembleur / debugger. Il nécessite l'accès à la ligne de commande, et n'est donc pas disponible sur les plateformes pour lesquelles les entrée/sortie standards ne sont pas disponibles ou facilement accessibles.
L'émulateur doit être compilé avec l'option "DASM=1" pour activer cette fonctionnalité (les binaires produits par le buildbot de libretro n'activent pas cette fonctionnalité, donc vous devez compiler l'émulateur par vous-même).
```
make DASM=1
```
RetroArch doit être lancé depuis la ligne de commande :
```
retroarch -L theodore_libretro.so /chemin/vers/jeu
```
Ensuite, il faut ouvrir le menu de RetroArch et activer l'option "Interactive disassembler" de l'émulateur.
Depuis la ligne de commande, les commandes suivantes sont ensuite disponibles :
* Appuie sur la touche `Entrée` : debuggage pas-à-pas. A chaque pas sont affichés l'adresse courante (registre Program Counter), l'instruction exécutée, et la valeur courante des registres du processeur.
* `trace` ou `t` : mode "trace". L'émulateur va afficher toutes les instructions exécutées au fil de l'eau et sans arrêt (sauf si un point d'arrêt est rencontré).
* `run` ou `r` : mode "run". L'émulateur va exécuter toutes les instructions au fil de l'eau mais sans les afficher et sans arrêt (sauf si un point d'arrêt est rencontré).
* `exit` ou `quit` ou `q` : quitte le désassembleur / debugger.
* `bp clear` : efface tous les points d'arrêts.
* `bp list` : affiche la list des points d'arrêt actuellement définis.
* `bp pc xxxx` (avec xxxx un nombre hexadécimal) : ajout d'un point d'arrêt pour la valeur donnée du registre Program Counter.
* `bp read xxxx` (avec xxxx un nombre hexadécimal) : ajout d'un point d'arrêt lors de la lecture à l'adresse donnée.
* `bp write xxxx` (avec xxxx un nombre hexadécimal) : ajout d'un point d'arrêt lors de l'écriture à l'adresse donnée.
* `read xxxx` (avec xxxx un nombre hexadécimal): lit la valeur en mémoire à l'adresse données.
* `write xxxx yy` (avec xxxx et yy des nombres hexadécimaux): écrit la valeur yy en mémoire à l'adresse xxxx.
