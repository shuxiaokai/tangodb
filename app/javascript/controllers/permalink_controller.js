import { camelize } from 'inflected'

import ApplicationController from './application_controller'


export default class extends ApplicationController {
  filter (e) {
    this.stimulate('PermalinkReflex#filter', e.target)
    console.log(e)
  }

  beforeReflex (element) {
    switch(element.type) {
      case 'checkbox':
        this.data.set(
          element.name,
          Array.from(document.querySelectorAll(`input[name=${element.name}]`))
            .filter(e => e.checked)
            .map(e => e.value)
            .join(',')
        )
        break
      case 'select-multiple':
        this.data.set(
          element.name,
          Array.from(element.querySelectorAll('option:checked'))
            .map(e => e.value)
            .join(',')
        )
        break
      default:
        this.data.set(element.name, element.value)
    }
    console.log(element.name, element.value)
  }

  afterReflex (element, reflex, error) {
    if (!error) {
      const camelizedIdentifier = camelize(this.identifier, false)
      const params = new URLSearchParams(window.location.search.slice(1))
      Object.keys(Object.assign({}, this.element.dataset))
        .filter(attr => attr.startsWith(camelizedIdentifier))
        .forEach(attr => {
          const paramName = attr.slice(camelizedIdentifier.length).toLowerCase()
          const paramValue = this.data.get(paramName)
          paramValue.length
            ? params.set(paramName, paramValue)
            : params.delete(paramName)
        })
      const qs = params
        .toString()
        .replace(/%28/g, '(')
        .replace(/%29/g, ')')
        .replace(/%2C/g, ',')
      const query = qs.length ? '?' : ''
      history.pushState({}, '', `${window.location.pathname}${query}${qs}`)
    }
  }
}