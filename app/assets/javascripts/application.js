// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require select2
//= require moment
//= require bootstrap-sprockets
//= require bootstrap-datetimepicker
//= require js-routes
//= require autonumeric
//= require jquery-ui

$(function() {
  "use strict";

  // Select input value on focus

  $(".select-on-focus").focus(function() {
    $(this).select();
  }).mouseup(function() {
    return false;
  }).focus();

  // Format date-time with moments.js in "7 hour ago" fashion

  function formatTimes() {
    moment.locale('en-gb');

    $('time.ago').each(function(_, element) {
      $(element).text(moment($(element).attr('datetime')).fromNow());
    });
  }

  $(formatTimes);
  $(document).on('page:load', formatTimes);

  window.timeElementsUpdateTimer = setInterval(formatTimes, 60 * 1000);

  // Clickable table rows

  var navigateTo = function(url, remote) {
    if (!url) return;
    if (remote) {
      $.ajax({ url: url })
    } else {
      Turbolinks.visit(url)
    }
  };

  $(".clickable-rows tr").click(function(event) {
    if ($(event.target).closest("a").length == 0) {
      navigateTo($(this).data("href"), $(this).data("remote"));
    }
  });

  // Clickable cells

  $(".clickable").click(function() {
    navigateTo($(this).data("href"), $(this).data("remote"));
  });

  // Focus [autofocus] input in Bootstrap modals

  $('.modal').on('shown.bs.modal', function() {
    $(this).find('[autofocus]').focus();
  });
});
