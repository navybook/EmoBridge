import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "messageForm"]

  connect() {
    this.toggleForm() // コントローラーが接続されたときにフォームの状態を切り替える
  }

  toggleForm() {
    const selectedText = this.selectTarget.options[this.selectTarget.selectedIndex].text
    const isOtherSelected = selectedText === 'その他'; // 選択されたオプションのテキストが「その他」かどうかをチェック
    this.messageFormTarget.classList.toggle('hidden', !isOtherSelected) // 「その他」が選択された場合のみメッセージフォームを表示
  }

  confirmSubmission(event) {
    event.preventDefault(); // フォームの通常の送信を防止
    if (confirm("パートナーへLINEメッセージを送信しますか？")) {
      // 「はい」が選択された場合の処理
      this.sendLineMessage = true;
    } else {
      // 「いいえ」が選択された場合の処理
      this.sendLineMessage = false;
    }
    this.submitForm();
  }

  submitForm() {
    // ここでフォームをプログラム的に送信する
    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "send_line_message";
    hiddenInput.value = this.sendLineMessage;
    this.element.appendChild(hiddenInput); // this.elementはコントローラーが対象とする要素、ここではformを想定

    this.element.submit(); // formをsubmitする
  }
}