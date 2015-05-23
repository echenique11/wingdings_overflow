$( document ).ready(function() {
  $('.toggle-comment-form').on('click', toggleComment);
  $('.vote-button').on('submit', createVote);
});

var toggleComment = function(event) {
  event.preventDefault();
  $('.comment-form').toggle();
};

var createVote = function(event){

  event.preventDefault();

  var formUrl = event.target.action;
  var formMethod = event.target.method;
  var formParams = $(event.target).serialize();

  $.ajax({
    url: formUrl,
    method: formMethod,
    data: formParams,
  }).done(function(response){
    $(event.target).parent().find('.karma').text(response);
  }).fail(function(error){
    console.log(error);
  });
};