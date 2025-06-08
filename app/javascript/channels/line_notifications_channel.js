import consumer from "channels/consumer"

consumer.subscriptions.create("LineNotificationsChannel", {
  connected() {
    console.log("Connected to the LineNotificationsChannel");
  },

  disconnected() {
    console.log("Disconnected from the LineNotificationsChannel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const loadingElement = document.getElementById("loading-animation");
    if (loadingElement) {
      loadingElement.remove();
    }
  
    if (data.status === 'success') {
      window.location.href = "/tops/home";
      alert("送信完了しました");
    } else if (data.status === 'error') {
      window.location.href = "/tops/home"; //
      alert("送信できませんでした");
    }
  }
});
