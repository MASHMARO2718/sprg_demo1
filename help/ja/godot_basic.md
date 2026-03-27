# Godotの基本概要

## Godotとは
Godotはオープンソースのゲームエンジンで、2Dおよび3Dゲームの開発が可能です。

## 基本的なシーンの作成方法
1. Godotを起動し、新しいプロジェクトを作成します。
2. [シーン] メニューから「新しいシーン」を選択します。
3. ルートノード（例：Node2DやControlなど）を追加します。
4. 必要な子ノード（例：Sprite、Buttonなど）を追加します。
5. シーンを保存します（Ctrl+S）。

## スクリプトのアタッチ方法
1. ノードを選択し、右側の[インスペクター]で「スクリプト」ボタンをクリックします。
2. 新しいスクリプトファイルを作成し、必要なコードを記述します。
3. スクリプトがノードにアタッチされます。

## Godotで使える言語
- GDScript（推奨）: 神龍スクリプトに似た専用言語。最も統合が良い。
- C#（Mono）: 高速で.NET互換。大規模開発向け。
- VisualScript: ノードベースのビジュアルスクリプト。
- C++（GDNative）: パフォーマンス重視のネイ티ブ拡張。

## GDScriptの基本文法
- 変数宣言: `var x = 10`
- 定数: `const SPEED = 200`
- 関数: `func _process(delta):`
- if文: `if x < 5: ... elif ... else ...`
- 配列/辞書: `var list = [1,2,3]`, `var dict = {"key": "value"}`

### 2Dシーン作成の流れ（例）
1. ルートノードを `Node2D` に設定。
2. 子ノードとして `Sprite`（画像表示）、`CollisionShape2D`（物理衝突）、`Area2D`（検知）を追加。
3. `Sprite` の `texture` に画像を設定。
4. `AnimationPlayer`/`Tween` でアニメーションを追加。
5. ルートに `Main.tscn` などの名前で保存し、`Project Settings > Autoload` でシーンを自動ロード可能。

### メニュー画面の作り方
1. 新規シーンを `Control` ルートで作成（UI用）。
2. 子ノードに `VBoxContainer`、`Button`、`Label` を配置。
3. `Button` に `_on_Button_pressed` の信号を接続し、開始/終了処理を記述。
4. 必要なら `OptionButton`, `CheckBox`, `Slider` で設定項目を追加。

### 例: メニュー系GDScript
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

### 例: 簡単なGDScript
```gdscript
extends Sprite

func _ready():
    print("Hello, Godot!")
```

## 参考
- 公式ドキュメント: https://docs.godotengine.org/ja/stable/
