import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.inputTarget.addEventListener("input", () => {
      this.previewTarget.innerHTML = this.inputTarget.value
    })
  }
}
