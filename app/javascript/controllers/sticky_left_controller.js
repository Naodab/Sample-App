import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "footer"]

  connect() {
    this.handleScroll = this.handleScroll.bind(this)
    window.addEventListener("scroll", this.handleScroll)
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll)
  }

  handleScroll() {
    if (!this.sidebarTarget)
      return

    if (window.innerWidth < 768) {
      this.sidebarTarget.style.position = "static"
      return
    }

    const sidebar = this.sidebarTarget
    const footer = this.footerTarget
    const sidebarHeight = sidebar.offsetHeight
    const footerTop = footer.getBoundingClientRect().top
    const marginTop = 20

    if (footerTop <= sidebarHeight + marginTop) {
      sidebar.style.position = "absolute"
      sidebar.style.top = "auto"
      sidebar.style.bottom = "0"
    } else {
      sidebar.style.position = "fixed"
      sidebar.style.bottom = "auto"
    }
  }
}
