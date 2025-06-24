import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    disable(event) {
        const button = event.target;
        button.classList.add("disable");
    }
}
