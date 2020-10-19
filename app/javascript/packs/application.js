// This file is automatically compiled by Webpack, along with any other files
 // present in this directory. You're encouraged to place your actual application logic in
 // a relevant structure within app/javascript and only use these pack files to reference
 // that code so it'll be compiled.
 //= require select2


 require("@rails/ujs").start()
 require("turbolinks").start()
 require("@rails/activestorage").start()
 require("channels")
 require("select2")

 import "@fortawesome/fontawesome-free/js/all";
 import "controllers";
 import $ from 'jquery'
 import "select2";
 import "select2/dist/css/select2.css"; 

// Import css from js for webpack to process it correctly
import '../css/application.css'

// Add Choices Dropdown
const Choices = require('choices.js')
document.addEventListener("turbolinks:load", function() {
    var dropDownSelects = new Choices('#dropdown-choice-select')
})