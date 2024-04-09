// StimulusのControllerをimportして、このファイルで使えるようにする
import { Controller } from "@hotwired/stimulus"

// Controllerクラスを継承して、新しいクラスを定義する
export default class extends Controller {
  // static targetsを使って、操作するDOM要素の名前を指定する
  // この場合、data-star-target属性を持つ要素が対象になる
  static targets = ["star"];

  // updateRatingメソッドが定義されている
  // このメソッドはイベントが発生した時に呼び出される
  updateRating(event) {
    // クリックされた星のdata-value属性から数値を取得する
    const rating = parseInt(event.currentTarget.getAttribute('data-value'), 10);
    // starTargetsに含まれる要素（星）全てに対して処理を行う
    this.starTargets.forEach((star, index) => {
      // indexがrating未満の場合、星を塗りつぶし状態にする
    if (index < rating) {
      star.classList.remove('far'); // 空の星のクラスを削除
      star.classList.add('fa-solid'); // 塗りつぶしの星のクラスを追加
    } else {
      star.classList.add('far'); // 空の星のクラスを追加
      star.classList.remove('fa-solid'); // 塗りつぶしの星のクラスを削除
    }
    });
    // form内のhiddenフィールドの値を更新する
    // これにより選択されたratingの値がフォーム送信時にサーバーに送られる
    this.element.querySelector("#rating_value").value = rating;
  }
}
