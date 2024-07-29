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
      this.showLoadingAnimation(); // ローディングアニメーションを表示
    } else {
      // 「いいえ」が選択された場合の処理
      this.sendLineMessage = false;
    }
    // フォームの送信をプログラム的に実行
    this.submitForm();
  }

  showLoadingAnimation() {
    // ローディングアニメーションの表示
    const loadingElement = document.createElement("div");
    loadingElement.id = "loading-animation";
    loadingElement.className = "fixed inset-0 bg-gray-200 bg-opacity-75 flex items-center justify-center z-50 flex-col";
    loadingElement.innerHTML = `
      <div class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-blue-500"></div>
      <p class="mt-2 text-blue-700"><span class="text-green-500">LINE</span>へ送信中...</p>
    `;
    document.body.appendChild(loadingElement);
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
