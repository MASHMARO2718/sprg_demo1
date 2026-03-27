# LLM セッション用プロンプト（固定部・日本語／フランス語併記）

## 運用（日本語）

- **初回**のチャット、または**方針・決定事項を変えたとき**: 下の「貼り付け用・固定部」**全体**（日本語＋フランス語）をコピーして送る。
- **通常**: 同じチャット内では「変動部」だけ更新して送るか、新規チャットなら固定部＋変動部をセットで送る。
- 短くしたい場合は、固定部を Cursor の Project Rules などに保存し、チャットでは変動部＋「ルール参照」とだけ書いてもよい。

## Utilisation (français)

- **Premier message** ou **changement de règles** : coller tout le bloc **fixe** ci-dessous (JA + FR).
- **Ensuite** : n’actualiser que la section **variable**, ou renvoyer fixe + variable dans un nouveau fil.
- Tu peux aussi stocker le bloc fixe dans les règles du projet et ne coller que la partie variable.

---

## 貼り付け用・固定部（コピー開始）

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【固定コンテキスト / Contexte fixe — 日本語】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【プロジェクト事実】
- 名前: SPRG_Com（Godot の config/name）。リポジトリは sprg_demo1。
- エンジン: Godot 4.6、レンダラー Forward Plus。Windows では rendering_device d3d12。3D 物理エンジンは Jolt（project.godot の設定）。
- 現状: メイン相当のシーンは node_2d.tscn（ルート Node2D のプレースホルダー）。ゲームループは未実装に近い。
- 設計・ドキュメント: plan/plan001/initial_game_plan.md、plan/plan001/ja/、plan/plan001/fr/。ヘルプ: help/ja/、help/fr/。プロンプト類: plan/prompts/。

【このリポジトリでの作業ルール（決定事項）】
1. 言語: ユーザーはセッションごとに指示言語・返答言語を変えてよい。矛盾があれば都度ユーザーに確認。
2. 実装言語: 既定は GDScript。C# はそのセッションの依頼で明示された場合に限り使用してよい。
3. 設計ドキュメント: 日本語・フランス語・英語の資料は同等に参照する。内容が矛盾する場合は実装前にユーザーへ確認する。
4. 編集範囲: 依頼の範囲に沿う限り README を含めリポジトリ内を編集してよい。依頼と無関係な変更はしない。
5. 変更の広がり: 関連箇所は積極的に整理・改善してよい（理由は簡潔に説明）。
6. 検証: ビルドや実行（Godot でプロジェクトを開く・実行相当）を可能な限り試み、失敗時はログやエラーを報告する。
7. コミット案: 提案する場合は、そのセッションでユーザーが使っている指示文と同じ言語で書く。

【役割】
このリポジトリで Godot（および関連ツール）を用いたゲーム開発を支援する。推測だけで大きく外さず、必要ならファイルを読み・コマンドを実行して確認する。

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【Contexte fixe — Français】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【Faits projet】
- Nom : SPRG_Com (config/name Godot). Dépôt : sprg_demo1.
- Moteur : Godot 4.6, rendu Forward Plus. Sous Windows : pilote d3d12. Physique 3D : Jolt (réglages dans project.godot).
- État : scène principale actuelle node_2d.tscn (racine Node2D, placeholder). Peu ou pas de boucle de jeu implémentée.
- Docs : plan/plan001/initial_game_plan.md, plan/plan001/ja/, plan/plan001/fr/. Aide : help/ja/, help/fr/. Prompts : plan/prompts/.

【Règles de travail (décisions)】
1. Langues : l’utilisateur peut changer langue d’instruction et de réponse selon la session. En cas d’ambiguïté, demander confirmation.
2. Langage d’implémentation : par défaut GDScript. C# uniquement si la demande de la session l’indique explicitement.
3. Documents de conception : le japonais, le français et l’anglais ont le même poids. En cas de contradiction, demander à l’utilisateur avant d’implémenter.
4. Périmètre d’édition : tant que c’est aligné sur la demande, README inclus, le dépôt peut être modifié. Pas de changements sans lien avec la demande.
5. Portée des changements : refactoriser ou harmoniser les zones liées de manière proactive (expliquer brièvement pourquoi).
6. Vérification : tenter build / exécution (équivalent lancer le projet Godot) ; en échec, reporter journaux et messages d’erreur.
7. Messages de commit : s’ils sont proposés, utiliser la même langue que celle des instructions utilisateur dans cette session.

【Rôle】
Assister au développement jeu avec Godot dans ce dépôt. S’appuyer sur les fichiers et l’exécution quand c’est nécessaire, éviter les grandes suppositions sans vérification.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
【変動部 / Partie variable — 毎回記入】
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

【このセッションの言語 / Langues pour cette session】
- 指示（ユーザー）: <例: 日本語 / français / English>
- 返答（アシスタント）: <例: 日本語 / français>

【現在の進捗 / Avancement】
- 完了: <…>
- 進行中・次: <…>
- ブロッカー: <… / rien>

【今回の依頼 / Demande】
<具体的なタスク。期待するファイル・挙動>

【参照してほしいパス（任意）/ Fichiers à privilégier (optionnel)】
<…>
```

---

## 変動部だけ使うとき（日本語）

固定部をルールや前メッセージで既に渡している場合:

```
【言語】指示: … / 返答: …
【進捗】…
【依頼】…
【参照】…
```

## Partie variable seule (français)

Si le contexte fixe est déjà dans les règles ou le fil précédent :

```
【Langues】instruction : … / réponse : …
【Avancement】…
【Demande】…
【Fichiers】…
```
