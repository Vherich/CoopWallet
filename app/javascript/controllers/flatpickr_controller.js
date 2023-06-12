import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["date"]
  connect() {
    console.log("teste")
    flatpickr(this.dateTarget, {})

  }
}
