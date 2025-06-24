import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    disableOnSubmit() {
        const button = this.element.querySelector("input[type=submit], button[type=submit]");
        if (button) {
            button.classList.add("disable");
            button.value = "Processing...";
            button.disabled = true;
        }
    }
}
