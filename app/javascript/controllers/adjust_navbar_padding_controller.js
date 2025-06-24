import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbar", "content"];

  connect() {
    this.adjustPadding();
    this._resizeHandler = this.adjustPadding.bind(this);
    window.addEventListener("resize", this._resizeHandler);
  }

  disconnect() {
    window.removeEventListener("resize", this._resizeHandler);
    if (this.hasContentTarget) {
      this.contentTarget.style.paddingTop = null;
    }
  }

  adjustPadding() {
    if (this.hasNavbarTarget && this.hasContentTarget) {
      const navbarHeight = this.navbarTarget.offsetHeight;
      this.contentTarget.style.paddingTop = `${navbarHeight}px`;
    }
  }
}
