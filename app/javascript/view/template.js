// document.addEventListener('turbolinks:load', function() {
//   var input = document.getElementById('template_content'),
//       tagify = new Tagify(input, {
//       mode: 'mix',
//       pattern: /{{/,
//       mixTagsInterpolator: ['{{', '}}'],
//       maxTags: 10,
//       dropdown: {
//         enabled: 1,
//         position: "text",
//         highlightFirst: true
//       }
//     })

//   if( tagify.on != undefined ) {
//     input.value = normalize(input)
//     tagify.on('add', (e) => {
//       input.value = normalize(input)
//     })
//     tagify.on('remove', (e) => {
//       input.value = normalize(input)
//     })
//   }

//   function normalize(input) {
//     return input.value
//               .match(/[\u1780-\u19FF]+|[a-z{:",\)\(\&\/\\\*\.]+/g)
//               .map(matched => /{{{"value":"([a-zA-Z0-9!@#\$%\\\/\^\&*\)\(\+=\._-]+)"/g.test(matched) ? `{{${RegExp.$1}}}`: matched)
//               .join(" ")
//   }
// })
