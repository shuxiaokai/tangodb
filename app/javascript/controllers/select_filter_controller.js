import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "videos"]

  connect() {
    this.filters =  { videotype: [] , leaders: [], followers: [], event: [], channels: [] } 
}



videotypeChange(event) {
  this.filters.videotypes = getSelectedValues(event)
  console.log(this.filters.videotypes)
  this.change()
}

genreChange(event) {
  this.filters.genres = getSelectedValues(event)
  console.log(this.filters.genres)
  this.change()
}

leaderChange(event) {
  this.filters.leaders = getSelectedValues(event)
  console.log(this.filters.leaders)
  this.change()
}

followerChange(event) {
  this.filters.followers = getSelectedValues(event)
  console.log(this.filters.followers)
  this.change()
}

eventChange(event) {
  this.filters.events = getSelectedValues(event)
  console.log(this.filters.events)
  this.change()
}

channelChange(event) {
  this.filters.channels = getSelectedValues(event)
  console.log(this.filters.channels)
  this.change()
}

change() {
  fetch(this.data.get("url"), { 
    method: 'POST', 
    body: JSON.stringify( this.filters ),
    credentials: "include",
    dataType: 'script',
    headers: {
      "X-CSRF-Token": getMetaValue("csrf-token"),
      "Content-Type": "application/json"
    },
  })
    .then(response => response.text())
    .then(html => {
      this.videosTarget.innerHTML = html
    }).catch(error => {console.log(error)} )
  }
}

function getSelectedValues(event) {
  return [...event.target.selectedOptions].map(option => option.value)
}

function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute("content")
}
