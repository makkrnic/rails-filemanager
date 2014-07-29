$(document).ready(function() {
});

window.fileManager = {

  filesContainer: undefined, 

  initialize: function() {
    var that = this;
    this.filesContainer = $('.files');
    this.filesContainer.data('parents', []);
    this.vivifyFiles();

    $('#up-dir').on('click', function() {
      that.dirUp();
    });
  
    // $.contextMenu('html5');

    // $.contextMenu({
    //   selector: '.menu-active-area',
    //     items: {
    //       foo: {name: 'Show link', callback: function(key, opt) { 
    //           console.log(key);
    //           console.log(opt);
    //           console.log($(this));

    //           $(this).parent().find('.direct-link').show();
    //         } 
    //       },
    //     },
    // });
  },

  vivifyFiles: function() {

    // tree navigation down
    $('.files .file .menu-active-area').on('click', function() {
      if ($(this).parent().hasClass('directory')) {
        console.log('dir');
        fileManager.dirDown($(this).parent().data('id'));
      } 
      else {
        // file
        if (window.opener) {
          console.log($(this).parent());
          window.opener.publicPagesAdmin.bodyEditor.insert($(this).parent().data('file').url);
        }
        console.log('file');
      }
    });

    var clip = new ZeroClipboard($('.zeroclip-button'));
    
    $('.remove-file').on('click', function(e) {
      e.preventDefault();
      console.log(e);
      if (confirm($(this).data('confirmation-text'))) {
        console.log ('confirmed');
        $.ajax({
          "type": "POST",
          "url": $(this).attr('href'),
          "data": "_method=delete",
          "dataType": "json",
          "complete": function() {
            window.reloadFiles();
          }
        });
      }
      else {
        console.log ('not confirmed');
      }
    });
  },

  cd: function(newDirId) {
    this.filesContainer.data('cwd-id', newDirId);
    $('#fileupload #parent_id_input').val(newDirId);
    reloadFiles();
  },

  dirUp: function() {
    var parents = this.filesContainer.data('parents');
    var parentId = parents.pop();
    this.filesContainer.data('parents', parents);

    this.cd(parentId);
  },

  dirDown: function(dirId) {
    var parents = this.filesContainer.data('parents');
    parents.push(this.filesContainer.data('cwd-id'));
    this.filesContainer.data('parents', parents);
    fileManager.cd(dirId);
  },
};
