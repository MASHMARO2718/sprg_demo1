# Godot Tools (extension VS Code) — Fonctions principales et utilisation

L’extension **Godot Tools** pour Visual Studio Code facilite fortement l’édition et le débogage des projets Godot. Voici un résumé des fonctionnalités importantes et des étapes de configuration.

---

## 1. Fonctions langage pour GDScript (édition de code)

- **Coloration syntaxique** — mise en évidence des éléments du code
- **Complétion automatique** — suggestions pendant la frappe
- **Ctrl+Clic pour accéder à la définition** — navigation vers fonctions et variables
- **Infobulles au survol** — documentation ou informations sur l’identificateur sous le curseur
- **Alt+O pour basculer entre `.gd` et `.tscn`** — passage rapide entre script et scène
- **Prise en charge du typage statique** — les annotations de type améliorent en général la complétion

---

## 2. Débogueur GDScript

Avec l’éditeur Godot lancé, vous pouvez **déboguer directement depuis VS Code**. C’est l’une des fonctionnalités les plus utiles de Godot Tools.

### Configuration initiale (une fois)

1. Lancer l’éditeur Godot
2. Dans VS Code, appuyer sur `F1` et ouvrir **Run and Debug** (Exécuter et déboguer)
3. Choisir **create a launch.json file** (créer un fichier launch.json)
4. Sélectionner **`Debug Godot`**
5. Ensuite, utiliser **`F5`** pour démarrer une session de débogage

### Ce que permet le débogage

- **Points d’arrêt** — suspendre l’exécution à une ligne donnée
- **Exécution pas à pas** — avancer ligne par ligne (Step Over / Step In / Step Out)
- **Surveillance des variables** — inspecter les valeurs pendant l’exécution
- **Pile d’appels** — voir l’historique des appels de fonctions
- **Arbre de scène** — consulter les nœuds actifs
- **Inspecteur** — examiner ou modifier des nœuds et des valeurs depuis l’outil de débogage

---

## 3. Lier l’éditeur Godot et VS Code (éditeur externe)

Vous pouvez faire en sorte qu’un double-clic sur un fichier GDScript dans Godot ouvre **VS Code**.

1. Ouvrir l’éditeur Godot
2. **Editor Settings** → **Text Editor** → **External**
3. Cocher **Use External Editor**
4. Dans **Exec Path**, indiquer le chemin de l’exécutable de VS Code (sur Windows, par exemple celui de `Code.exe`)
5. Dans **Exec Flags**, saisir : `{project} --goto {file}:{line}:{col}`

Godot et VS Code travaillent ainsi de manière plus fluide ensemble.

---

## 4. Fichiers GDResource

- **`.tscn` (scènes)** — coloration syntaxique et aide à la prévisualisation de scène selon l’extension
- **`.tres` (ressources)** — prise en charge analogue pour l’édition

---

## 5. Paramètres côté VS Code (`settings.json`)

Indiquer le chemin vers l’exécutable Godot 4 :

```json
"godotTools.editorPath.godot4": "C:\\path\\to\\Godot.exe"
```

Pour Godot 3, utiliser la clé prévue pour **godot3** (voir la documentation de l’extension).

---

## 6. Flux de travail typique

1. Concevoir et agencer les scènes dans l’éditeur Godot
2. Écrire le GDScript dans VS Code
3. Lancer le débogage avec **`F5`**
4. Utiliser des points d’arrêt pour inspecter variables et flux d’exécution
5. Vérifier l’arbre de scène et le comportement dans Godot si besoin

Combiner éditeur et débogueur permet un développement Godot plus efficace, proche d’un environnement intégré.

---

## Références

- Documentation officielle Godot : https://docs.godotengine.org/fr/stable/
- Consulter aussi la fiche de l’extension sur le Marketplace VS Code pour les détails et mises à jour.
