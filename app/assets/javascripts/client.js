$(document).ready(function(){
 var refreshPosts = function(){
   $.get('/clients', function(data){

     $('#post-list').html('')
     for (var i = 0; i < data.length; i++){
      $('#post-list').prepend("<li data-id=" + data[i].id + ">" + "<a class='link'>"+ data[i].title + "</a> </li><hr>")
     }
   })
 }

$('#post-list').on('click', '.link', function(){

    var commentForm = "<form data-id=" + postId + " ><input name='body' id='body'><span class='btn comment-submit'>Post Comment</span></form><br>"

  var postId = $(this).parent().data('id');
  $.get('/clients/' + postId, function(data){
    var comments = data.comments
    var commentString = ''

    for (var i = 0; i < comments.length; i++){
      commentString += comments[i].body + '<hr>'
    }

    $('#post-list').html("<div data-id=" + postId + " ><h1>" + data.title + "</h1> <hr>" + data.body + "<br><a class='back'>Back to Posts</a> <h3>Comments</h3>" + commentForm + commentString + "</div>"  );
    $('.back').click(refreshPosts)
  });
});


  $('#post-list').on('click', '.comment-submit', function(){
    console.log("clicked")
    var body = $('#body').val();
    $('#body').val('');
    var postId = $(this).parent().parent().data('id');
    $.post('/posts/' + postId + '/comments', { comment: { body: body} });
  })
  refreshPosts();
})
