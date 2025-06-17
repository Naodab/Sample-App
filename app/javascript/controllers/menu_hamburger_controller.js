import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.handleResize()
    this._handleResize = this.handleResize.bind(this)

    window.addEventListener("DOMContentLoaded", this._handleResize)
    window.addEventListener("resize", this._handleResize)
  }

  disconnect() {
    window.removeEventListener("DOMContentLoaded", this._handleResize)
    window.removeEventListener("resize", this._handleResize)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  handleResize() {
    if (window.matchMedia("(min-width: 768px)").matches) {
      this.menuTarget.classList.remove("main-dropdown-menu")
    } else {
      this.menuTarget.classList.add("main-dropdown-menu")
    }
  }
}
