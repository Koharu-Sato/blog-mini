// modal の初期化
  
 // 注意点１ イベントの着火をDOMContentLoaded => turbolinks:loadに変える
 document.addEventListener('turbolinks:load', function() {
  // 注意点2 countを0にセットする
    M.Modal._count = 0;
    var elems = document.querySelectorAll('.modal');
    // optionsで公式docsを参考にカスタマイズ
    var options = {
      opacity: 0.8,
      inDuration: 100  
    };
    M.Modal.init(elems, options);
  });