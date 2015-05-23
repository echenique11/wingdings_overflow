$( document ).ready(function() {
  $('.toggle-comment-form').on('click', toggleComment);
  $('.vote-button').on('submit', createVote);
  $('.comment-form').on('submit', createComment);
  $('#answer-form').on('submit', createAnswer);

});

var toggleComment = function(event) {
  event.preventDefault();
  $(event.target).closest('.comment-section').find('.comment-form').toggle();
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
    $(event.target).closest('.comment-section').find('.comments').append(response);
    $('.comment-body').val("");
  }).fail(function(error){
    console.log(error);
  });
};

var createAnswer = function(event){
  event.preventDefault();
  $.ajax({
    url: event.target.action,
    method: event.target.method,
    data: $(event.target).serialize(),
  }).done(function(response){
    $('.answer-section').append(response);
    $('.answer-body').val("");
  }).fail(function(error){
    console.log(error);
  });
};
