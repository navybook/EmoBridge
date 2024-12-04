import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["container", "badge"]

  connect() {
    console.log("Notifications controller connected")
    this.checkUnreadNotifications()  // ページロード時に未読通知を確認
    this.badgeTarget.addEventListener('click', this.toggleBadge.bind(this))  // badgeにクリックイベントを追加
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
    this.badgeTarget.classList.toggle("hidden")  // badgeのhiddenクラスをトグル
  }

  isContainerHidden(container) {
    return container.classList.contains("hidden")
  }

  hideNotifications(container) {
    container.classList.add("hidden")
  }

  loadNotifications() {
    fetch('/notifications')
      .then(response => response.json())  // JSONレスポンスをパース
      .then(data => {
        this.updateContainer(data.notifications)  // 通知リストを表示
        this.updateBadge(data.unread_count > 0)   // 未読があるかチェック
      })
      .catch(this.handleError)
  }

  updateContainer(html) {
    this.containerTarget.innerHTML = html
    this.containerTarget.classList.remove("hidden")
  }

  updateBadge(hasUnreadNotifications) {
    if (hasUnreadNotifications) {
      this.badgeTarget.classList.remove("hidden")  // 未読があればバッジを表示
    } else {
      this.badgeTarget.classList.add("hidden")    // なければ非表示
    }
  }

  checkUnreadNotifications() {
    fetch('/notifications/unread_count')  // サーバーから未読通知数を取得
      .then(response => response.json())
      .then(data => {
        this.updateBadge(data.unread_count > 0)  // 未読数があればバッジを表示
      })
      .catch(this.handleError)
  }

  handleError(error) {
    console.error('Error loading notifications:', error)
  }
}
