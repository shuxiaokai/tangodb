// filters_controller.js
import { Controller } from "stimulus"
import Rails from "@rails/ujs"
import * as Turbo from '@hotwired/turbo'

export default class extends Controller {
  static targets = ["filter"]

  connect() {
    console.log("Filter-Controller ON")
  }

  // filter() {
  //   console.log(window.location.pathname);
  //   const url = `${window.location.pathname}?${this.params}`;
  //   Turbo.clearCache();
  //   Turbo.visit(url);
  // }

  filter() {
    const filterData = this.filterTargets.map( (select) => { return [ select.name, [...select.selectedOptions].map( option => option.value ) ] } )

    const url = `/videos/filter?${this.params}`

    Rails.ajax({
     type: "post",
     url: url,
     success: (data) => {
     console.log(data)
          const newContainerGenreFilters = document.getElementById('genre').setAttribute('data-slimselect-data-value', JSON.stringify(data.genre))
          const newContainerLeaderFilters = document.getElementById('leader').setAttribute('data-slimselect-data-value', JSON.stringify(data.leader))
          const newContainerFollowerFilters = document.getElementById('follower').setAttribute('data-slimselect-data-value', JSON.stringify(data.follower))
          const newContainerOrchestraFilters = document.getElementById('orchestra').setAttribute('data-slimselect-data-value', JSON.stringify(data.orchestra))
          const containerVideos = (document.getElementById('videos').innerHTML = data.video)

    //  const newContainerLoadmore = data.getElementById('load-more-container')
    //  const containerLoadmore = document.getElementById('load-more-container')
    //  const newContainerFilterresults = data.getElementById('filter_results')
    //  const containerFilterresults = document.getElementById('filter_results')
    //  containerVideos.innerHTML = newContainerVideos.innerHTML
    //    containerLoadmore.innerHTML = newContainerLoadmore.innerHTML
    //    containerFilterresults.innerHTML = newContainerFilterresults.innerHTML

    //    history.pushState({}, '', `${window.location.pathname}?${this.params}`)
     },
     error: (data) => {
       console.log(data)
     }
   })
  }

  get params() {
    console.log(this.filterTargets);
    let params = this.filterTargets
      .filter((t) => t.value !== "all")
      .map((t) => `${t.name}=${t.value}`)

    let search = document.querySelector("#query")

    if (search.value) {
      params.push(`${search.name}=${search.value}`)
    }

    const queryString = window.location.search;

    const urlParams = new URLSearchParams(queryString)

    let songID = urlParams.getAll('song_id')

    let eventID = urlParams.getAll('event_id')

    let hd = urlParams.getAll('hd')

    if (songID.length > 0 ) {
      params.push(`song_id=${songID}`)
    }

    if (eventID.length > 0) {
      params.push(`event_id=${eventID}`)
    }

    if (hd.length > 0) {
      params.push(`hd=${hd}`)
    }

    return params.join("&")

  }
}
