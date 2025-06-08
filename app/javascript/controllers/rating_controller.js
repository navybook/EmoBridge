import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"];

  updateRating(event) {
    const rating = parseInt(event.currentTarget.getAttribute('data-value'), 10);
    this.starTargets.forEach((star, index) => {
    if (index < rating) {
      star.classList.remove('far');
      star.classList.add('fa-solid');
    } else {
      star.classList.add('far');
      star.classList.remove('fa-solid');
    }
    });
    this.element.querySelector("#rating_value").value = rating;
  }
}
