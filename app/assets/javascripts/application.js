// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
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
//= require epiceditor
//= require_tree .

var editor;
$(function() {
  var opts = {
    container: 'epiceditor',
    textarea: 'epictextarea',
    clientSideStorage: false,
    file: {
      defaultContent: $('#epictextarea').val()
    },
    autogrow: true
  };
  editor = new EpicEditor(opts);

  // When it loads put the exiting content in there
  editor.on('load', function (file) {
    //file.defaultContent = $('#epictextarea').val();
  });

  //Everytime it's updated, update the textarea
  editor.on('update', function (file) {
    $("#spictextarea").val(file.content);
  });
  if( $("#epiceditor").length > 0 ) {
    editor.load();
  }
});