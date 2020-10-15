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

// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = [ "videos" ]
  
//   connect() {
//     console.log(this.videosTarget)
//     this.filters =  { genres: [] } 
//   }

//   genreChange(event) {
//     console.log(getSelectedValues(event))
//     this.filters.genres = getSelectedValues(event)
//     this.change()
//   }

//   change() {
//     fetch(this.data.get("url"), { 
//       method: 'POST', 
//       body: JSON.stringify(this.filters),
//       credentials: "include",
//       dataType: 'script',
//       headers: {
//         "X-CSRF-Token": getMetaValue("csrf-token"),
//         "Content-Type": "application/json"
//       },
//     })
//       .then(response => response.text())
//       .then(html => {
//         this.videosTarget.innerHTML = html
//       })
//   }
// }

// function getMetaValue(name) {
//   const element = document.head.querySelector(`meta[name="${name}"]`)
//   return element.getAttribute("content")
// }

// function getSelectedValues(event) {
//   return [...event.target.selectedOptions].map(option => option.value)
// }

