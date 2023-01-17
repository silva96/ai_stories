import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="flashes"
export default class extends Controller {
  close (event) {
    event.currentTarget.closest('.flash').remove()
  }
}
