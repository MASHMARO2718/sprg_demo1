# Conception du Jeu SPRG - Format et UX

## 📋 Structure Fondamentale du Jeu (Confirmé)

### Composition des Personnages
- **Équipe Joueur**: 1 Roi + 2 Chevaliers = 3 Unités
- **Équipe Ennemie**: 1 Roi + 2 Chevaliers = 3 Unités
- **Total**: Maximum 6 unités placées sur la carte tactique

### Conditions de Victoire/Défaite
```
Victoire: Vaincre le Roi ennemi
Défaite: La mort du Roi allié
```
- La mort d'un chevalier n'est pas une défaite (affecte la tactique mais le jeu continue)
- **Mort Permanente**: Tout unité mort ne ressuscite pas

### Environnement Cartographique (Coûts de Mouvement par Tuile)
| Type | Coût de Mouvement | Caractéristique |
|--------|----------|------|
| Plaines (plains) | 0 | Mouvement le plus facile |
| Montagnes (mountain) | 2 | Mouvement difficile, bon pour la défense |
| Forêt (forest) | 1 | Mouvement modéré |
| Désert (desert) | 0 | Même que les plaines |
| Rivière (river) | 1 | Mouvement modéré |

**Tactique**: Les tuiles à coût élevé deviennent des goulots d'étranglement, rendant le choix du chemin critique.

---

## 🎮 Système de Jeu (Plan de Conception)

### Système de Statistiques (Confirmé)
```
5 Statistiques Primaires:
- vitality (Vitalité): Valeur de base des PV, réduction des dégâts
- power (Puissance): Puissance d'attaque, puissance des compétences
- guard (Garde): Taux de réduction des dégâts
- luck (Chance): Taux de coup critique, taux de précision, taux d'activation d'effets spéciaux
- speed (Vitesse): Détermination de l'ordre des tours, taux d'esquive

Chaque statistique a des buffs/debuffs:
- b.vitality, b.power, b.guard, b.luck, b.speed (BUFF)
- d.vitality, d.power, d.guard, d.luck, d.speed (DEBUFF)
```

### Système de Montée en Niveau (Confirmé)

**Calcul de l'Expérience**:
```
EXP Gagné = (EXP Ennemi de Base × Niveau Ennemi) / Niveau du Personnage
```

**Changement de Classe**:
```
Atteindre le Niveau 11 → Changement de Classe
(Les classes spécifiques ne sont pas encore définies)
```

**Caractéristiques de la Courbe de Croissance**:
- Tuer des ennemis de bas niveau = peu d'expérience (fonction d'ajustement)
- Ennemis du même niveau: Expérience standard
- Ennemis de haut niveau: Beaucoup d'expérience

---

## 🎯 Boucle de Jeu Recommandée

### 1. Phase d'Affichage de la Carte
```
┌─ Début du Jeu
├─ Affichage de la carte et de tous les unités
│  ├─ 3 Unités alliés: Visibles
│  ├─ 3 Unités ennemis: Visibles (FOW possible ultérieurement)
│  └─ Affichage des tuiles: Guide de coûts de mouvement
└─ Début du Tour
```

**Proposition UX**:
- Caméra: Suivi dynamique (centré sur l'unité sélectionnée) ou défilement possible
- Au-dessus de l'unité: Affichage PV/Stats simplifiés
- À la sélection: Affichage du panneau de stats détaillés

### 2. Phase de Progression des Tours (Non défini - Proposition)

**Plan Conseillé: Ordre des Tours basé sur la Vitesse**
```
Chaque début de Round:
1. Rassembler la vitesse de tous les unités
2. Exécuter l'action des unités dans l'ordre de vitesse (égalité: équipe alliée prioritaire)
3. Après l'action de tous les unités → Tour suivant

Exemple:
Chevalier Ennemi A (speed=8) → Roi Allié (speed=6) → Roi Ennemi (speed=5) 
→ Chevalier Allié B (speed=4) → Chevalier Allié C (speed=4) 
→ Chevalier Ennemi B (speed=3)
```

**Avantages**:
- La statistique speed a une véritable signification
- Les unités lentes risquent d'être encerclées (tactique améliorée)
- La prédiction des actions ennemies est claire pour le joueur

### 3. Phase d'Action de l'Unité (Par unité)

**Choix d'Action**:
```
1. Mouvement: Se déplacer jusqu'au coût en tuiles
2. Utilisation de Compétence: Attaque/Buff/Récupération
3. Attente: Rien faire (passer au tour suivant)
4. Défense: Réduction des dégâts jusqu'au prochain tour
```

**Proposition UX**:
- Sélection du personnage → Région de mouvement en surbrillance
- Sélection de tuile → Calcul du coût de mouvement, affichage du chemin (A*)
- Sélection d'compétence → Mode de sélection de cible (plage affichée)

### 4. Calcul des Dégâts (Proposition)

```
Dégâts de Base = (Attaquant.power × Coefficient Compétence) - (Défenseur.guard × 0.5)

Dégâts Finaux = Dégâts de Base × (1 + Correction BUFF) × (1 - Réduction DEBUFF)

Jugement Coup Critique:
- Probabilité d'activation = (Attaquant.luck + Bonus Compétence) %
- En cas de coup critique: Dégâts Finaux × 1.5

Jugement de Précision:
- Taux de Précision = 100% - (Défenseur.luck × 2%)
```

---

## 🖥️ Transitions UX/UI

### Diagramme de Transition d'État Principal

```
[Début du jeu]
    ↓
[Affichage carte]← ↺ Boucle de tour
    ↓
[Sélection d'unité] ← (Tour du joueur)
    ↓
[Sélection d'action]
    ├→ [Phase de mouvement]→ [Sélection Compétence] → [Sélection Cible] → Exécution
    ├→ [Phase de Défense] → Exécution
    └→ [Attente]
    ↓
[Exécution IA Ennemi Automatique] ← (Tour de l'ennemi)
    ↓
[Progression du tour]
    ├→ [Quelqu'un est mort?]
    │   ├→ Oui: [Suppression d'unité]
    │   └→ Non: Continuer
    ├→ [Roi ennemi mort?]
    │   ├→ Oui: [Victoire du jeu]
    │   └→ Non: Continuer
    ├→ [Roi allié mort?]
    │   ├→ Oui: [Défaite du jeu]
    │   └→ Non: Continuer
    └→ [Retour à l'affichage carte]
```

### Proposition de Disposition de l'Interface (Isométrique 2D)

```
┌────────────────────────────────────────────────────────────┐
│  [Nom du jeu] - Tour 5/max                                 │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                                                      │  │
│  │           [Zone d'affichage carte isométrique]     │  │
│  │           Animations d'unités et de tuiles          │  │
│  │                                                      │  │
│  │                                                      │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
├────────────────────────────────────────────────────────────┤
│ [Sélectionné: Roi Allié]                                   │
│                                                             │
│  PV: ████████░░ 80/100                                     │
│  Statut:                                                     │
│  ├─ vitalité: 15 (Normal)                                  │
│  ├─ puissance: 12 (Normal)                                 │
│  ├─ garde: 8 (Normal)                                      │
│  ├─ chance: 10 (Normal)                                    │
│  └─ vitesse: 6 (BUFF +2)                                   │
│                                                             │
│ [Agir] [Compétence] [Défendre] [Attendre]                 │
└────────────────────────────────────────────────────────────┘
```

### Interface de Sélection de Compétence

```
[Exécuter Compétence]

Compétences d'Attaque:
├─ Attaque Normale (Coût: Mouvement possible)
└─ □ Coup de Sabre (Puissance×1.2, Cible Ennemie, Plage: Adjacente)

Compétences de Support:
├─ □ Récupération (Récupère 50% vitalité, Soi-même)
├─ □ Bénédiction de Force (puissance +30%, 3 tours)
└─ □ Renforcement de Garde (garde +20%, 3 tours)

[Décider] [Annuler]
```

### Affichage la Situation de Combat (Haut à droite)

```
┌─ Infos Équipes ─┐
│ Allié  │ Ennemi │
├────────┼────────┤
│ 👑 Roi │ 👑 Roi │ PV: ██░░ 40/100
│ PV ███░│ PV ██░░│
│        │        │
│ 🛡️ Chev│ 🛡️ Chev│ PV: ███░ 60/100
│ PV ██░░│ PV ███░│
│        │        │
│ 🛡️ Chev│ 🛡️ Chev│ PV: ████ 100/100
│ PV ████│ PV ████│
└────────┴────────┘

Ordre de Prochaine Action:
Prochain: Chevalier Ennemi B (speed 8) → Roi Allié (speed 6)
```

---

## 🎯 Système de Changement de Classe (Conception UX)

**Transition d'Écran à Lv11:**

```
[Atteint Niveau 11!]
    ↓
[Écran de Changement de Classe]
    
Classe Actuelle: Chevalier
├─ Option A: Paladin (vitalité +20%, garde +30%)
├─ Option B: Chevalier Noir (puissance +40%, vitalité -10%)
└─ Option C: Chevalier Critique (chance +50%, puissance +20%)

▶ Après sélection, l'unité change de classe (apparence/animation différente)
```

---

## 💾 Système de Sauvegarde/Chargement

**Recommandé**:
- **Format JSON**: Code lisible par l'humain, débogage facile
- **Contenu de la Sauvegarde**:
  ```json
  {
    "gameState": {
      "currentTurn": 5,
      "currentRound": 1
    },
    "map": {
      "width": 10,
      "height": 10,
      "tiles": [[0, 1, 2, ...], ...]
    },
    "units": [
      {
        "id": "player_king",
        "type": "king",
        "team": "player",
        "position": {"x": 3, "y": 3},
        "level": 5,
        "exp": 150,
        "class": "knight",
        "hp": 80,
        "maxHp": 100,
        "stats": {
          "vitality": 15,
          "power": 12,
          "guard": 8,
          "luck": 10,
          "speed": 6
        },
        "buffs": [{"type": "b.speed", "duration": 2, "value": 2}],
        "debuffs": []
      },
      ...
    ]
  }
  ```

---

## 🔴 Prochaines Étapes (À confirmer avant implémentation)

### Priorité S (Essentiel)
1. **Confirmation de la formule de dégâts** → Définir les coefficients power/guard/luck
2. **Règles de chevauchement BUFF/DEBUFF** → Addition ou multiplication?
3. **Comportement à la mort d'un chevalier** → Condition de défaite ou simple désavantage tactique?

### Priorité A (Avant implémentation)
4. Liste de type de compétence et effets spécifiques
5. Changements de stats spécifiques par changement de classe
6. Décider si implémenter FOW (vision limitée)

### Priorité B (Peut être ajouté ultérieurement)
7. Niveau de luxe des effets de particules
8. Planification des sons et BGM
9. Réglage de difficulté (intensité de l'IA ennemi)

---

## 📊 Flux de Jeu Supposé

```
1. Déploiement Initial: Roi&Chevaliers Alliés vs Roi&Chevaliers Ennemis
   Carte: Grille 10×10, tuiles aléatoires

2. Tours 1-3: Les deux côtés s'approchent, échange initial de compétences
   └─ Escarmouches: Accumulation de dégâts à faible puissance

3. Tours 4-6: Combat intense
   ├─ Chevaliers en première ligne pour intimider
   ├─ Roi en soutien avec des compétences de buff
   └─ Risque de mort de quelqu'un

4. Tours 7+: Combat final
   ├─ Un Roi est acculé
   └─ Décision (5-15 tours estimés selon niveaux)

5. Après Combat:
   ├─ Les unités survivantes gagnent de l'expérience
   ├─ Changement de classe à Lv11
   └─ Vers la prochaine carte
```

---

**→ Nous recommandons de commencer par affiner la "formule de dégâts" en détail spécifique à partir de ce document.**
