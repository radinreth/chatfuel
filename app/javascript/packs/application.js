require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

window.$ = require("jquery")
require("bootstrap")
require("moment")
require("chartkick")
require("chart.js")
require("daterangepicker")
require("startbootstrap-sb-admin-2/js/sb-admin-2.min")

require("toastr")
// Tagify = require("@yaireo/tagify")

require('application/pumi')

import "bootstrap-toggle/js/bootstrap-toggle"

require("application/namespace")
require("application/util")
require("application/loader")

require("sites/settings/setting")
require("sites/api_keys/show")
require("sites/index")
require("templates/index")
require("dashboard/show")

require("shared/sidebar")
require("shared/set_language")
require("view/dictionary")
require("view/ticket")
require("view/chart")
require("view/sidebar_toggle")
require("view/users")
