$(document).ready(function () {
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.action == "open") {
      $('#title').html(item.title);
      $('#desc').html(item.desc);
      $("#in").attr('callback', item.callback);
      open();
    };
    if (item.action == "close") {
      close();
    };

    document.onkeyup = function (data) {
      if (data.which == 27  || data.which == 8 ) {
        $.post('http://vrp_jobcheckin/close', JSON.stringify({}));
      };
      if (data.which == 13) {
        var callback = $('#in').attr('callback');
        $.post('http://vrp_jobcheckin/checkin', JSON.stringify({ callback: callback }) );
      };
    };
  });

  function open(){
    $("body").show(100);
  };
  function close(){
    $("body").hide(100);
  };

  $("#in").click(function() {
    var callback = $(this).attr('callback');
    $.post('http://vrp_jobcheckin/checkin', JSON.stringify({ callback: callback }) );
  });

  $("#out").click(function() {
    $.post('http://vrp_jobcheckin/close', JSON.stringify({}) );
  });

});
