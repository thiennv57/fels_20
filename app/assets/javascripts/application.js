// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

$(document).on("page:change", function(){
  // next button on lesson page
  var lesson_words_count = 0;
  $(".next_lesson_word_btn").on("click", function(e){
    lesson_words_count += 1;
    var progress = (lesson_words_count / 20) * 100;
    $(this).parent().hide().next().next().show();
    $(".bar").css({width: progress + "%"});
    e.preventDefault();
  });

  // show button on result page
  $(".btn_hide").on("click", function(){
    if ($(this).next().is(":visible") == true) {
      $(this).text("Show").next().slideUp();
    } else {
      $(this).text("Hide").next().slideDown();
    }
  });
});