import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["brand", "price", "color"];

  filter() {
    const url = `${window.location.pathname}?${this.params}`;

    Turbolinks.clearCache();
    Turbolinks.visit(url);
  }

  get params() {
    return [this.brand, this.price, this.color].join("&");
  }

  get brand() {
    return `brand=${this.brandTarget.value}`;
  }

  get price() {
    return `price=${this.priceTarget.value}`;
  }

  get color() {
    return `color=${this.colorTarget.value}`;
  }
}