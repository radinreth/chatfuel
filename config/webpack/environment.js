const { environment } = require("@rails/webpacker");
const webpack = require("webpack");
const fileLoader = environment.loaders.get("file");
fileLoader.exclude = /node_modules[\\/]quill/;
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    moment: "moment/moment",
    toastr: "toastr/toastr",
    Popper: ["popper.js", "default"],
  })
);
const svgLoader = {
  test: /\.svg$/,
  loader: "svg-inline-loader",
};

environment.loaders.prepend("svg", svgLoader);
module.exports = environment;
