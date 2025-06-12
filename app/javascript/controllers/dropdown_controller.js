import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener("click", this.handleOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick)
  }

  toggle(event) {
    if (this.hasMenuTarget) {
      event.stopPropagation()
      this.menuTarget.classList.toggle("show")
    }
  }

  handleOutsideClick = (event) => {
    if (this.hasMenuTarget && !this.element.contains(event.target)) {
      this.menuTarget.classList.remove("show")
    }
  }
}
