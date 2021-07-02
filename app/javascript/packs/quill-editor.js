import { DirectUpload } from "@rails/activestorage";
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min";
import Quill from "quill/quill";

Quill.register("modules/imageResize", ImageResize);

document.addEventListener("DOMContentLoaded", function (event) {
  var quill = new Quill("#editor-container", {
    modules: {
      toolbar: [
        [{ header: [1, 2, 3, 4, 5, 6, false] }],
        [{ color: [] }],
        [{ size: [] }],
        [
          "bold",
          "italic",
          "underline",
          "strike",
          { script: "super" },
          { script: "sub" },
          "code",
          "link",
        ],
        ["blockquote", "code-block", "image"],
        [{ list: "ordered" }, { list: "bullet" }],
        [{ align: ["center", "right", "justify", false] }],
        [{ indent: "-1" }, { indent: "+1" }],
      ],
    },
    placeholder: "Compose an epic...",
    theme: "snow",
  });

  document.querySelector("form").onsubmit = function () {
    var content = document.querySelector("input[class=pdf_template_content]");
    content.value = quill.root.innerHTML;
  };
});

export default Quill;
