import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  preview(event) {
    const input = event.target;
    const reader = new FileReader();

    reader.onload = (e) => {
      const previewElement = document.getElementById("avatar-preview");
      previewElement.src = e.target.result;
    };

    reader.readAsDataURL(input.files[0]);
  }
}
