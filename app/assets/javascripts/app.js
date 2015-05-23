$( document ).ready(function() {
  $('.toggle-comment-form').on('click', toggleComment);
});

var toggleComment = function(event) {
  event.preventDefault();
  $('.comment-form').toggle();
};