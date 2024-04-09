import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "feeling"]

  selectEmotion(event) {
    // すべてのアイコンをfa-regularに戻す
    this.iconTargets.forEach((icon) => {
      icon.classList.remove("fa-solid");
      icon.classList.add("fa-regular");
    });

    // クリックされたアイコン要素を取得
    const iconElement = event.currentTarget;

    // アイコンのクラスをfa-regularからfa-solidに変更
    iconElement.classList.remove("fa-regular");
    iconElement.classList.add("fa-solid");

    // hiddenフィールドに選択されたfeeling値を設定
    const selectedFeeling = event.currentTarget.getAttribute("data-value")
    this.feelingTarget.value = selectedFeeling
  }
}
