import * as htmlToImage from "html-to-image";
import download from "downloadjs";
window.moment = require("moment/moment");

OWSO.Provincial_usagesIndex = (() => {
  function init() {
    downloadImage();
  }

  function downloadImage() {
    $("#downloadImage").click(function (e) {
      e.preventDefault();
      htmlToImage
        .toPng(document.getElementById("table"), {
          preferredFontFormat: "Nunito",
          backgroundColor: "white",
          style: { color: "black" },
        })
        .then(function (dataUrl) {
          download(
            dataUrl,
            `provincial_usages-${moment().format("YMMDDHmmss")}.png`
          );
        })
        .catch(function (err) {
          console.log(err.message);
        });
    });
  }
  return { init };
})();
