# SPRG_Com (sprg_demo1)

Godot 4.6 project for a planned **strategic / tactical RPG** (SPRG). The repository currently contains **project configuration**, a **minimal 2D scene**, and **design & help documentation** in multiple languages. Gameplay systems are defined in planning documents; the playable build is not implemented yet.

---

## English

### Overview

| Item | Detail |
|------|--------|
| Engine | [Godot](https://godotengine.org/) **4.6** (`Forward Plus`) |
| Project name | `SPRG_Com` (see `project.godot`) |
| Main scene | `node_2d.tscn` — root `Node2D` only (placeholder) |
| Icon | `icon.svg` (default Godot-style project icon) |
| Physics | Jolt (3D engine setting in `project.godot`) |
| Windows rendering | Direct3D 12 (`d3d12`) |

### Repository layout

```
sprg_demo1/
├── project.godot          # Godot project settings
├── node_2d.tscn           # Minimal scene (Node2D root)
├── icon.svg               # Application icon
├── icon.svg.import        # Godot import metadata (tracked)
├── .gitignore             # Ignores .godot/, android/
├── .gitattributes         # text=auto, eol=lf
├── .editorconfig          # UTF-8 charset
├── help/
│   ├── ja/godot_basic.md  # Godot basics (Japanese)
│   └── fr/godot_basic.md  # Godot basics (French)
└── plan/
    └── plan001/
        ├── initial_game_plan.md              # Core design notes (EN)
        ├── ja/
        │   ├── architecture_decisions_ja.md  # Architecture decision table (JA)
        │   └── game_format_ux_design_ja.md     # Format & UX design (JA)
        └── fr/
            ├── architecture_decisions_fr.md  # Architecture decision table (FR)
            └── game_format_ux_design_fr.md     # Format & UX design (FR)
```

### Design intent (from `plan/`)

High-level ideas documented include: **two kings** (game over if one dies), **two knights per king**, five stats (vitality, power, guard, luck, speed), buffs/debuffs per stat, **tile terrain** (plains, mountain, forest, desert, river) with movement weights, leveling and **class change at level 11**. Many mechanics are still marked open in the architecture tables.

### Requirements & how to run

1. Install **Godot 4.6** (or compatible 4.x matching `config/features` in `project.godot`).
2. In Godot: **Import** → select this folder (`project.godot`).
3. Open `node_2d.tscn` or set a main scene in **Project → Project Settings → Application → Run**.

Local Godot cache (`.godot/`) is gitignored; it is created when you open the project.

---

## 日本語

### 概要

| 項目 | 内容 |
|------|------|
| エンジン | **Godot 4.6**（`Forward Plus`） |
| プロジェクト名 | `SPRG_Com`（`project.godot` の `config/name`） |
| メイン相当のシーン | `node_2d.tscn` — ルート `Node2D` のみ（プレースホルダー） |
| アイコン | `icon.svg` |
| 備考 | `project.godot` に Jolt（3D 物理）および Windows の `d3d12` 設定あり |

### フォルダ構成

リポジトリ直下に Godot プロジェクトファイル（`project.godot`、`node_2d.tscn`、`icon.svg` など）があり、**`help/`** に Godot の入門メモ（日本語・フランス語）、**`plan/plan001/`** にゲーム設計・UX・アーキテクチャ決定の整理（英語の初期プラン、日本語・フランス語の詳細）が置かれています。上記「English」セクションのツリーと同じ構造です。

### 設計ドキュメントについて

`plan/plan001/initial_game_plan.md` および `ja/`・`fr/` 配下のファイルに、王・騎士・タイル地形・ステータス／バフ・デバフ・レベルアップなどの**企画内容**がまとまっています。実装はまだ最小限で、ゲームループやバトルはコードベースには含まれていません。

### 動かし方

1. **Godot 4.6**（または `project.godot` の `config/features` に合う 4.x）を用意する。  
2. Godot でこのフォルダを**インポート**する。  
3. `node_2d.tscn` を開くか、**プロジェクト設定 → アプリケーション → 実行** でメインシーンを指定する。

`.godot/` は `.gitignore` で除外されており、エディタで開いたときにローカル生成されます。

---

## Français

### Aperçu

| Élément | Détail |
|---------|--------|
| Moteur | **Godot 4.6** (`Forward Plus`) |
| Nom du projet | `SPRG_Com` (fichier `project.godot`) |
| Scène principale actuelle | `node_2d.tscn` — racine `Node2D` uniquement (espace réservé) |
| Icône | `icon.svg` |
| Remarque | Physique Jolt (3D) et pilote `d3d12` sous Windows dans `project.godot` |

### Arborescence

À la racine : configuration Godot (`project.godot`, `node_2d.tscn`, `icon.svg`, fichiers d’import). Le dossier **`help/`** contient des notes d’introduction à Godot en **japonais** et **français**. Le dossier **`plan/plan001/`** regroupe la conception du jeu : plan initial en anglais, puis documents d’architecture et d’UX en japonais et en français. La structure détaillée est identique au schéma de la section **English** ci-dessus.

### État du projet

Les idées de jeu (rois, chevaliers, tuiles, stats, buffs/débuffs, montée de niveau, etc.) sont décrites dans **`plan/`**. Le dépôt ne contient pour l’instant **qu’une scène minimale** ; la boucle de jeu et les systèmes de combat ne sont pas encore implémentés dans le code.

### Lancer le projet

1. Installer **Godot 4.6** (ou une version 4.x compatible avec `config/features` dans `project.godot`).  
2. Dans Godot : **Importer** ce dossier (fichier `project.godot`).  
3. Ouvrir `node_2d.tscn` ou définir la scène principale dans **Paramètres du projet → Application → Exécuter**.

Le dossier `.godot/` est ignoré par Git et est créé localement à l’ouverture du projet dans l’éditeur.

---

## License

No `LICENSE` file is present in this repository. Add one if you intend to distribute the project.
