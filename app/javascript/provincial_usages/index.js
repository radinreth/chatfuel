import * as htmlToImage from "html-to-image";
import download from "downloadjs";

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
        })
        .then(function (dataUrl) {
          download(dataUrl, "report.png");
        })
        .catch(function (err) {
          console.log(err.message);
        });
    });
  }
  return { init };
})();
