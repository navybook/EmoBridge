import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const images = [
      'image1.jpg',
      'image2.jpg',
      'image3.jpg',
      'image4.jpg',
      'image5.jpg'
    ];

    const randomImage = images[Math.floor(Math.random() * images.length)];
    this.element.style.backgroundImage = `url('/assets/${randomImage}')`;
  }
}
