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
}
