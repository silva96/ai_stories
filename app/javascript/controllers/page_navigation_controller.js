import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="page-navigation"
export default class extends Controller {
  static targets = ['prevPage', 'nextPage']

  connect () {
    this.listener = this.handleArrowNavigation.bind(this)
    document.addEventListener('keydown', this.listener)
  }

  disconnect () {
    document.removeEventListener('keydown', this.listener)
  }

  handleArrowNavigation (event) {
    if (event.key === 'ArrowLeft') {
      this.prevPage()
    } else if (event.key === 'ArrowRight') {
      this.nextPage()
    }
  }

  prevPage () {
    if (this.hasPrevPageTarget) { this.prevPageTarget.click() }
  }

  nextPage () {
    if (this.hasNextPageTarget) { this.nextPageTarget.click() }
  }
}
