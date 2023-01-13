import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="page-navigation"
export default class extends Controller {
  static targets = ['prevPage', 'nextPage']

  connect () {
    document.addEventListener('keydown', this.handleArrowNavigation.bind(this))
  }

  disconnect () {
    document.addEventListener('keydown', this.handleArrowNavigation.bind(this))
  }

  handleArrowNavigation (event) {
    if (event.key === 'ArrowLeft') {
      this.prevPage()
    } else if (event.key === 'ArrowRight') {
      this.nextPage()
    }
  }

  prevPage () {
    this.prevPageTarget.click()
  }

  nextPage () {
    this.nextPageTarget.click()
  }
}
