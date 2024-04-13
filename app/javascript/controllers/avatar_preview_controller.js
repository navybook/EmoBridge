// StimulusのControllerをimportして、このファイルで使えるようにする
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // プレビューを生成するメソッド
  preview(event) {
    // イベントから入力フィールドを取得
    const input = event.target;
    // ファイルを読み込むためのFileReaderオブジェクトを作成
    const reader = new FileReader();

    // 読み込みが完了したときの処理を定義
    reader.onload = (e) => {
      // プレビューを表示するimg要素を取得
      const previewElement = document.getElementById("avatar-preview");
      // 読み込んだファイルの内容をプレビューに設定
      previewElement.src = e.target.result;
    };

    // 選択されたファイルをDataURLとして読み込む
    reader.readAsDataURL(input.files[0]);
  }
}
