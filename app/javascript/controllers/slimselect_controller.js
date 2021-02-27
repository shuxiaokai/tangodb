import { Controller } from 'stimulus'
import SlimSelect from 'slim-select'
import 'slim-select/dist/slimselect.min.css'

export default class extends Controller {
   static targets = ['field']
   static values = { data: Array }

   connect() {
      this.dataInitialize()
   }

   dataInitialize() {
      const limit = '5'
      const placeholder = false
      const searchText = this.data.get('no-results')
      const closeOnSelect = false
      const allowDeselect = !this.element.required
      const showContent = 'down'
      const searchFocus = false
      const data = this.dataValue

      this.slimselect = new SlimSelect({
        select: this.element,
        closeOnSelect,
        allowDeselect,
        limit,
        searchText,
        showContent,
        searchFocus,
        data
      })
      this.slimselect.open()
   }

  dataValueChanged() {
    if (this.slimselect) {
      const selectedValue = this.slimselect.selected()
      this.slimselect.setData(this.dataValue)
      this.slimselect.set(selectedValue)
      this.slimselect.open()
    }
  }

  open() {
    console.log('open fired')
    let select = document.querySelector('select')
    select.open()
  }
}


// const url = this.fieldTarget.dataset.slimselectUrl

// new SlimSelect({
//   select: this.element,
//   searchHighlight: true,
//   closeOnSelect: false,
//   showContent: 'down',
//   searchingText: 'Searching...', // Optional - Will show during ajax request
//   ajax: function (search, callback) {
//     // Check search value. If you dont like it callback(false) or callback('Message String')
//     if (search.length < 3) {
//       callback('Need 3 characters')
//       return
//     }

//     // Perform your own ajax request here
//     fetch(url + '?q=' + search)
//     .then(function (response) {
//       return response.json()
//     })
//     .then(function (json) {
//       let data = []
//       for (let i = 0; i < json.length; i++) {
//         data.push({ value: json[i][1], text: json[i][0] })
//       }

//       // Upon successful fetch send data to callback function.
//       // Be sure to send data back in the proper format.
//       // Refer to the method setData for examples of proper format.
//       console.log(data)
//       callback(data)
//     })
//     .catch(function(error) {
//       // If any erros happened send false back through the callback
//       callback(false)
//     })
//   }
// })
