
SVG Suite v1.1 for CotEditor
================================================

SVG編集のためのCotEditor用のスクリプトセットです。

SVGの *カラーリング定義ファイル* 、*svgz形式への書き出し* 、W3Cでの *バリテーション* 、base64エンコードをした *画像の挿入* 、 *テンプレート*、*プレビュー* など
CotEditorでSVGを編集する際にたいへん便利なスクリプトが詰まっています。

CotEditorをSVGエディタとして使う、そんなクリエティブ・ライフを応援するスクリプト・スイートです。

![スクリーンショット](https://github.com/1024jp/svg-coteditor/raw/master/screenshot.png)


内容物
----------------------------------------------------
- hallo.svg        —— お試し用のSVGデータ
- README.md        —— 説明書（この書類）
- screenshot.png   —— スクリーンショット
- SVG/             —— スクリプトセット
- SVG.plist        —— カラーリング・シンタックス定義（作者サイトにて単独で配布しているものと同一）
- legacy previwer/ —— SVG Suite v0.6までで使われていた、SVGをSafariでプレビューするスクリプト（詳しくは中のREADMEを参照）


インストール
----------------------------------------------------
### インストール
#### SVG/ (スクリプトセット)
CotEditorのスクリプトメニューから「スクリプトフォルダを開く」を選択するとFinderでScriptMenuフォルダが開きます。
そのScriptMenuにSVGフォルダをまるごと移動させた後「スクリプトメニューを更新」を実行してください。
以降はスクリプトメニューから、もしくはお好みのキーアサインを割り当ててご利用ください。

#### SVG.plist (カラーリング・シンタックス定義)
CotEditorの環境設定から
	シンタックス > シンタックススタイル > 読み込み
で、SVG.plistを読み込んでください。

#### Gapplin (SVGプレビューア)
Mac App Store から別途インストールして下さい。

- [Gapplin -Mac App Store](http://appstore.com/mac/Gapplin)

### アンインストール
ScriptMenuからSVGフォルダを取り除いてください。
シンタックス定義は環境設定から削除できます。


使い方・各機能説明
----------------------------------------------------
基本的にはCotEditorでSVGを編集しながらGapplinで随時変更を確認する、という使い方を想定しています。そのままSVGZ形式に出力できるためInkscapeやIllustratorが出力したSVGファイルの最後のクリーンナップにも最適です。

### Gapplinについて
本スクリプト・スイートではSVGのプレビューにSVGビューア Gapplinを用いています。このアプリケーションはSVGをWebKitレンダリングで表示する専用のプレビューアとして、本スイートと同じ作者によって開発されました。現時点でいまだSVG(Z)を開けないPreview.appに代わって、編集中のSVG画像のプレビューをサポートします。

GappinはそもそもテキストエディタでのSVG編集と併用することを目的に開発されており、CotEditorでファイルを保存すれば、自動的にビューも更新されるように設計されています。

### New Document
既にテンプレートが挿入されている新しいSVGドキュメントを開きます。

### Preview
編集中のSVGファイルをGapplinで開きます。 
Command + Shift + R がショートカットキーとして割り振られています。

カラーリング・シンタックスがSVGのときのみ有効です（変更可）。

### Validate on W3C
[W3C Markup Validation Service](http://validator.w3.org/)を用いて編集中のファイルをバリデート(検証)し結果をダイアログで返します。
さらに Show Details で詳細結果をウェブブラウザで表示します。

インターネットに接続している必要があります。

このスクリプトはHTMLなどのSVG以外のファイルにも使えます（CSS検証サービスはカバーしていません）。

### Export to/
編集中のSVGファイルを別のフォーマットで書き出します。

### Open in Inkscape
編集中のSVGファイルをInkscapeで開きます。

### Open in Firefox / Chrome
編集中のファイルをそれぞれFirefox, Chromeで開きます。

このスクリプトはHTMLなどのSVG以外のファイルにも使えます。

### Embed Image...
任意の画像ファイルをbase64エンコードし、imageタグとしてキャレット位置に挿入します。

### Templates/
それぞれ便利な定型句のテンプレートを挿入します。

### Toggle Dark Mode
Gapplinで最前面のウインドウのダークモードを切り替えます。


カスタマイズ
----------------------------------------------------
いくつかのスクリプトではファイル内の値を書き換えることで挙動のカスタマイズが可能です。

###スクリプト全般
#### ショートカットキー
CotEditorスクリプトのショートカットキーはファイル名を変更することで設定可能です。
デフォルトではPreviewにのみ Command + Shift + R がショートカットキーとして割り振られています。
詳しくはCotEditor本体のヘルプを参照してください。

#### スクリプト名
スクリプトのファイル名を変更することでスクリプトメニューでの表記を変えることができます。
*現時点では* ファイルに依存関係はないので、お好みでわかりやすい名前に書き換えてください。

いらないスクリプトを削除したりディレクトリを移動させる（例えばValidate on W3C を ScriptMenuの最上階層に）のも問題ないです。

### New Document で設定可能な値
- `insertTitleTag`,`insertStyleTag`,`insertDefsTag`

	それぞれタグをテンプレートとして新規書類に挿入するかを決定します。

- `syntaxName`

	書類を作成した際に自動的にセットするカラーリングモードを設定します。

- `width`,`height`

	SVGドキュメントのサイズを決定します。

### Validate on W3C, Open in..., Export to... で設定可能な値
- `showAlertDialog`
	デフォルト値：true (アラートを出す)
	
	セーブをせずに実行した際やファイルがSVGでなかった際に実行できない旨を知らせるアラートを表示するかを決定します。
	falseにした場合は、何も表示せずにスクリプトを中断します。
	


### Embed Image... で設定可能な値
- `maxFileSize`

	容量の大きな画像を埋め込もうしたときの確認ダイアログを出すしきい値を変更できます。


ロードマップ
----------------------------------------------------
やりたいなと思ってること。気が向いたものから実装されます。されないかもしれません。

- 英語版README
- テンプレートをもう少し増やす
- アラートをもう少し推敲する
- バリテーション詳細結果の出力先としてCotEdiorのスクリプトエラーウィンドウを選べるようにする
- ダイアログ等の日本語ローカライズ


開発環境
----------------------------------------------------
- OS X Maverics 10.9
- CotEditor 1.3.1


作者
----------------------------------------------------
1024jp

- website: [ヴォルフロッシュ](http://wolfrosch.com/)
- twitter: @[1024jp](https://twitter.com/1024jp)
- github : [1024jp](https://github.com/1024jp)


フィードバック
----------------------------------------------------
不具合や要望などありましたら、GitHub上や作者のTwitter等で気軽にご連絡下さい。
かならず対応することを保証はしませんが、前向きに検討させていただきます。
「便利に使ってるよ」というただの利用報告でもモチベーションが上がります。

また、Gapplinへのフィードバックがありましたら、[BitBucket Issues][]の方にお願いします。

[BitBucket Issues]: https://bitbucket.org/1024jp/gapplin/issues


ライセンス
----------------------------------------------------
本スクリプト・スイートは [クリエイティブ・コモンズ 表示 - 非営利 3.0 非移植 ライセンス](cc) の下に提供されています。

[cc]: http://creativecommons.org/licenses/by-nc/3.0/deed.ja
