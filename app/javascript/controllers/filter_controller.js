// filters_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["filter"];

  connect() {
    console.log('Filter-Controller ON')
    console.log(this.filterTargets)
  }

  filter() {
    const url = `${window.location.pathname}?${this.params}`;
    console.log(this.params)
    Turbolinks.clearCache();
    Turbolinks.visit(url);
  }

  get params() {
    return this.filterTargets.map((t) => `${t.name}=${t.value}`).join("&");
  }
}
