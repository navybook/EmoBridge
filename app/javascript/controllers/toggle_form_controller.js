import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "messageForm"]

  connect() {
    this.toggleForm()
  }

  toggleForm() {
    const selectedText = this.selectTarget.options[this.selectTarget.selectedIndex].text
    const isOtherSelected = selectedText === 'その他';
    this.messageFormTarget.classList.toggle('hidden', !isOtherSelected)
  }

  confirmSubmission(event) {
    event.preventDefault();

    if (confirm("パートナーへLINEメッセージを送信しますか？")) {
      this.sendLineMessage = true;
      this.showLoadingAnimation();
    } else {
      this.sendLineMessage = false;
    }
    this.submitForm();
  }

  showLoadingAnimation() {
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
    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "send_line_message";
    hiddenInput.value = this.sendLineMessage;
    this.element.appendChild(hiddenInput);

    this.element.submit();
  }
}
