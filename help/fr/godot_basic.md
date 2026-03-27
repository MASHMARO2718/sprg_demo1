# Présentation de base de Godot

## Qu'est-ce que Godot ?
Godot est un moteur de jeu open source permettant de créer des jeux 2D et 3D.

## Création d'une scène de base
1. Lancez Godot et créez un nouveau projet.
2. Dans le menu [Scène], sélectionnez "Nouvelle scène".
3. Ajoutez un nœud racine (par exemple : Node2D ou Control).
4. Ajoutez les nœuds enfants nécessaires (par exemple : Sprite, Button, etc.).
5. Enregistrez la scène (Ctrl+S).

## Comment attacher un script
1. Sélectionnez un nœud, puis cliquez sur le bouton [Script] dans l'inspecteur à droite.
2. Créez un nouveau fichier de script et écrivez le code nécessaire.
3. Le script est maintenant attaché au nœud.

## Langages utilisables
- GDScript (recommandé) : langage intégré, simple et rapide pour Godot.
- C# (Mono) : pour les développeurs .NET et les projets plus grands.
- VisualScript : scripts visuels (nodes / graphiques).
- C++ (GDNative) : pour les modules performants natifs.

## Syntaxe GDScript de base
- Variable : `var x = 10`
- Constante : `const SPEED = 200`
- Fonction : `func _process(delta):`
- Condition : `if x < 5: ... elif ... else ...`
- Tableau/Dictionnaire : `var list = [1,2,3]`, `var dict = {"key": "value"}`

### Création de scène 2D (exemple)
1. Créez une scène avec un nœud racine `Node2D`.
2. Ajoutez `Sprite`, `CollisionShape2D`, `Area2D` comme enfants.
3. Assignez `texture` à `Sprite`.
4. Ajoutez `AnimationPlayer` ou `Tween` pour l’animation.
5. Sauvegardez sous `Main.tscn` et utilisez `Project Settings > AutoLoad` pour le charger automatiquement.

### Écran de menu
1. Nouvelle scène avec racine `Control`.
2. Ajoutez `VBoxContainer`, `Button`, `Label`.
3. Connectez le signal `pressed` du bouton à `_on_Button_pressed`.
4. Ajoutez `OptionButton`, `CheckBox`, `Slider` si nécessaire.

### Exemple : script de menu
```gdscript
extends Control

func _ready():
    $StartButton.connect("pressed", self, "_on_start_pressed")
    $QuitButton.connect("pressed", self, "_on_quit_pressed")

func _on_start_pressed():
    get_tree().change_scene("res://scenes/gameplay.tscn")

func _on_quit_pressed():
    get_tree().quit()
```

---

### Exemple : GDScript simple
```gdscript
extends Sprite

func _ready():
    print("Hello, Godot!")
```

## Référence
- Documentation officielle : https://docs.godotengine.org/fr/stable/
