OWSO.Util = {
  chartReg() {
    Chart.plugins.register({
      afterDraw: function(chart) {
        let { datasets } = chart.data

        if (datasets && datasets[0].data && datasets[0].data.length === 0) {
          var ctx = chart.chart.ctx;
          var width = chart.chart.width;
          var height = chart.chart.height
          chart.clear();
    
          ctx.save();
          ctx.textAlign = 'center';
          ctx.textBaseline = 'middle';
          ctx.font = "16px normal 'Helvetica Nueue'";
          ctx.fillText('No data to display', width / 2, height / 2);
          ctx.restore();
        }
      }
    });
  },
  dev() { return location.hostname == "localhost" },

  freshSession() {
    if ( sessionStorage.getItem('fresh') ) return false;

    return OWSO.Util.outdateFreshSession();
  },

  outdateFreshSession() {
    sessionStorage.setItem('fresh', 1);
    return true;
  },

  capitalize(value) {
    return value.replace(/(^|\s)([a-z])/g, (m, p1, p2) => p1 + p2.toUpperCase());
  },

  getCurrentPage() {
    if(!$("body").attr("id")) { return ""; }
    const bodyId = $("body").attr("id").split("-");
    const action = this.capitalize(bodyId.pop());
    const controller = bodyId;
    let i = 0;
    while (i < controller.length) {
      controller[i] = this.capitalize(controller[i]);
      i++;
    }
    const pageName = controller.join("") + action;

    return pageName;
  },

  insertToTextbox(areaId, text) {
    const txtarea = document.getElementById(areaId);
    if (!txtarea) {
      return;
    }
    const scrollPos = txtarea.scrollTop;
    let strPos = 0;
    const br = txtarea.selectionStart || (txtarea.selectionStart === '0') ? 'ff' : document.selection ? 'ie' : false;
    if (br === 'ie') {
      txtarea.focus();
      const range = document.selection.createRange();
      range.moveStart('character', -txtarea.value.length);
      strPos = range.text.length;
    } else if (br === 'ff') {
      strPos = txtarea.selectionStart;
    }
    const front = txtarea.value.substring(0, strPos);
    const back = txtarea.value.substring(strPos, txtarea.value.length);
    txtarea.value = front + text + back;
    strPos = strPos + text.length;
    if (br === 'ie') {
      txtarea.focus();
      const ieRange = document.selection.createRange();
      ieRange.moveStart('character', -txtarea.value.length);
      ieRange.moveStart('character', strPos);
      ieRange.moveEnd('character', 0);
      ieRange.select();
    } else if (br === 'ff') {
      txtarea.selectionStart = strPos;
      txtarea.selectionEnd = strPos;
      txtarea.focus();
    }
    txtarea.scrollTop = scrollPos;
  }
};