if(typeof(CKEDITOR) != 'undefined')
{
 CKEDITOR.editorConfig = function(config) {
   config.uiColor = "#F1F1F1";
   config.toolbar = [
    [ 'Bold', 'Italic', 'Underline', 'Strike' ],
    [ 'NumberedList', 'BulletedList', 'HorizontalRule' ],
    [ 'Blockquote' ],
    [ 'Undo', 'Redo' ],
    [ 'insertResolved' ],
    [ 'Source' ]
 ];
}
} else{
  console.log("ckeditor not loaded")
}