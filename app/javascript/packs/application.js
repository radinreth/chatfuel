require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("moment")
require("chartkick")
require("chart.js")
require("daterangepicker")
require("startbootstrap-sb-admin-2/js/sb-admin-2.min")

require("toastr")
// Tagify = require("@yaireo/tagify")

// require("bootstrap-select")
import "bootstrap-select/js/bootstrap-select"
import "bootstrap-toggle/js/bootstrap-toggle"

import "bootstrap/js/dist/modal"

require("shared/sidebar")
require("view/dictionary")
require("view/ticket")
require("view/template")
require("view/chart")
require("view/daterangepicker")
require("view/sidebar_toggle")
require("application/namespace")
require("application/util")
require("application/loader")

require("sites/settings/setting")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "../stylesheets/application"
