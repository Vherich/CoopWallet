import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="expense"
export default class extends Controller {
  static values = {url: String}
  connect() {
  }

  edit(event){
    console.log(event)
    event.preventDefault()
    event.stopImmediatePropagation()

    const url = this.element.action
    fetch(url, {
      headers: {'Accept': 'text/plain'},
      method: 'PATCH',
      body: new FormData(this.element)
    })
    .then(response => response.text())
    .then(data =>
      window.location.href = this.urlValue)
  }
}
