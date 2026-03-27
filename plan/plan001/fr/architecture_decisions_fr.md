# Décisions d'Architecture SPRG (Français)

## 1️⃣ Fondation Technologique

| Élément de Décision | Options | Statut | Description |
|---------|--------|--------|------|
| **Framework** | Godot / Unity / Autre | ✅ **Godot** | Confirmé par node_2d.tscn |
| **Dimension** | 2D isométrique / 3D pseudo-isométrique / 3D pur | ❓ Indéfini | L'isométrie 2D est généralement suffisante pour les SPRG |
| **Base de Rendu** | Basée sur les tuiles / Basée sur les sprites | ❓ Indéfini | Les tuiles sont recommandées avec le système de mouvement |

## 2️⃣ Système de Jeu

| Élément de Décision | Options | Statut | Description |
|---------|--------|--------|------|
| **Progression des Tours** | Tours vrais / Ordre de vitesse / Tours simultanés | ❓ Indéfini | Le rôle du stat speed n'est pas clair |
| **Nombre d'Actions par Tour** | 1 action fixe / Plusieurs actions / Système de points d'action | ❓ Indéfini | Les chevaliers « puissants » → plusieurs actions? |
| **Système de Portée de Mouvement** | Coordonnées de grille / Valeurs de distance | ✅ **Grille + Coût de Mouvement** | tiles: plains(0), mountain(2), forest(1), desert(0), river(1) |
| **Méthode de Définition des Compétences** | Paramètres fixes / Scripts / Manuel | ❓ Indéfini | La formule de dommages n'est pas définie |
| **Chevauchement des Débuff/Buff** | Addition / Multiplication / Remplacement | ❓ Indéfini | La méthode de calcul de d.Vital/b.vital n'est pas définie |
| **Mécanique de Mort** | Mort permanente / Résurrection possible / Recommencer | ✅ **Mort Permanente** | "one dies the game is over" (Roi). Chevaliers aussi? |
| **Composition des Personnages** | 2 Rois + 2 Chevaliers chacun | ✅ **Confirmé** | "2 kings, all have 2 knights" |

## 3️⃣ Structure des Données

| Élément de Décision | Options | Statut | Description |
|---------|--------|--------|------|
| **Sauvegarde des Données de Personnage** | En mémoire / JSON/CSV / Base de données | ❓ Indéfini | - |
| **Gestion des Statuts** | 5 stats | ✅ **Confirmé** | vitality, power, guard, luck, speed |
| **Buff/Débuff** | Structure de liste | ✅ **Confirmé** | Chaque stat a b.* / d.* associé |
| **Attributs de Statut** | species, alive/dead | ✅ **Confirmé** | - |
| **Données de Carte** | Tableau de tuiles | ✅ **Confirmé** | 5 types: plains, mountain, forest, desert, river |
| **Modèle de Gestion d'État** | Global / ECS | ❓ Indéfini | - |

## 4️⃣ IA et Logique

| Élément de Décision | Options | Statut | Description |
|---------|--------|--------|------|
| **Pensée de l'IA Ennemie** | Basée sur des règles / Machine d'états / Arbre comportemental / Valeur d'évaluation | ❓ Indéfini | Comment exprimer le « puissant » des chevaliers |
| **Système de Vision** | Information complète / Vision partielle / FOW | ❓ Indéfini | Connecté au stat luck? |
| **Recherche de Chemin** | A* / Largeur d'abord / Précalcul | ❓ Indéfini | Doit prendre en compte les coûts de mouvement |
| **Calcul de la Plage de Mouvement** | Calcul par tour / Cache | ❓ Indéfini | - |

## 5️⃣ Interface Utilisateur et Représentation

| Élément de Décision | Options | Statut | Description |
|---------|--------|--------|------|
| **Affichage de la Carte** | Caméra fixe / Défilement / Suivi dynamique | ❓ Indéfini | - |
| **Animation des Unités** | Frame-by-frame / Squelettique / Particules | ❓ Indéfini | - |
| **Composition de l'Interface** | Affichage constant / À la sélection / Surimpression | ❓ Indéfini | Comment afficher les 5 statuts |
| **Interface du Menu de Combat** | Sélection de commande / Menu radial / Opération intuitive | ❓ Indéfini | - |
| **Représentation des Effets** | Sprites 2D / Particules 3D | ❓ Indéfini | - |

## 6️⃣ Performance et Système de Croissance

| Élément de Décision | Options | Statut | Description |
|---------|--------|--------|------|
| **Calcul du Level Up** | Formule fixe | ✅ **Confirmé** | Exp gagné = (exp ennemi × lvl ennemi) / lvl personnage |
| **Changement de Classe** | Déclenché à Lv11 | ✅ **Confirmé** | Changement de classe à Lv11 |
| **Sauvegarde et Chargement** | Sérialisation / JSON/CSV | ❓ Indéfini | - |

---

**🔴 Éléments à décider d'urgence :**

1. **Logique de Progression des Tours** → Comment utiliser le stat speed?
2. **Formule de Dommages** → Paramétrisation spécifique de power/guard/luck
3. **Traitement de la Mort des Chevaliers** → Les rois perdent => jeu terminé, mais les chevaliers?
4. **Calcul des Buff/Débuff** → Ex: b.power +20% = power×1.2?
