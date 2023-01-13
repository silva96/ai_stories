import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['target']
  toggle () {
    this.targetTarget.classList.toggle('hidden')
  }
}
