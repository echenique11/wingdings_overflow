$( document ).ready(function() {
  $('.toggle-comment-form').on('click', toggleComment);
  $('.vote-button').on('submit', createVote);
  $('.comment-form').on('submit', createComment);
});

var toggleComment = function(event) {
  event.preventDefault();
  $('.comment-form').toggle();
};

var createVote = function(event){
  event.preventDefault();
  $.ajax({
    url: event.target.action,
    method: event.target.method,
    data: $(event.target).serialize(),
  }).done(function(response){
    $(event.target).parent().find('.karma').text(response);
  }).fail(function(error){
    console.log(error);
  });
};

var createComment = function(event){
  event.preventDefault();
  $.ajax({
    url: event.target.action,
    method: event.target.method,
    data: $(event.target).serialize(),
  }).done(function(response){
    $('.comments').append(response);
    $('#comment_body').val("");
  }).fail(function(error){
    console.log(error);
  });
};