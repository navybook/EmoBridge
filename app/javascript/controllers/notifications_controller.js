import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["container", "badge"]

  connect() {
    console.log("Notifications controller connected")
    this.checkUnreadNotifications()
    this.badgeTarget.addEventListener('click', this.toggleBadge.bind(this))
  }

  toggle(event) {
    event.preventDefault()
    const container = this.containerTarget
    
    if (this.isContainerHidden(container)) {
      this.loadNotifications()
    } else {
      this.hideNotifications(container)
    }
  }

  toggleBadge() {
    this.badgeTarget.classList.toggle("hidden")
  }

  isContainerHidden(container) {
    return container.classList.contains("hidden")
  }

  hideNotifications(container) {
    container.classList.add("hidden")
  }

  loadNotifications() {
    fetch('/notifications')
      .then(response => response.json())
      .then(data => {
        this.updateContainer(data.notifications)
        this.updateBadge(data.unread_count > 0)
      })
      .catch(this.handleError)
  }

  updateContainer(html) {
    this.containerTarget.innerHTML = html
    this.containerTarget.classList.remove("hidden")
  }

  updateBadge(hasUnreadNotifications) {
    if (hasUnreadNotifications) {
      this.badgeTarget.classList.remove("hidden")
    } else {
      this.badgeTarget.classList.add("hidden")
    }
  }

  checkUnreadNotifications() {
    fetch('/notifications/unread_count')
      .then(response => response.json())
      .then(data => {
        this.updateBadge(data.unread_count > 0)
      })
      .catch(this.handleError)
  }

  handleError(error) {
    console.error('Error loading notifications:', error)
  }
}
