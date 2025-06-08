import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "feeling"]

  selectEmotion(event) {
    this.iconTargets.forEach((icon) => {
      icon.classList.remove("fa-solid");
      icon.classList.add("fa-regular");
    });

    const iconElement = event.currentTarget;

    iconElement.classList.remove("fa-regular");
    iconElement.classList.add("fa-solid");

    const selectedFeeling = event.currentTarget.getAttribute("data-value")
    this.feelingTarget.value = selectedFeeling
  }
}
