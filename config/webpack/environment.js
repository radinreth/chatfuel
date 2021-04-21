const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
const erb = require('./loaders/erb')
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    moment: 'moment/moment',
    toastr: 'toastr/toastr',
    DateRangePicker: 'daterangepicker/daterangepicker',
    Popper: ['popper.js', 'default'],
    Rails: ['@rails/ujs']
  })
)

environment.loaders.prepend('erb', erb)
environment.loaders.prepend('coffee', coffee)
module.exports = environment
