# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


### 
show_message = (msg) ->
	$('#message').hide().text(msg).fadeIn(2222,
		-> $('#message').append('!')
	)
 
$ -> show_message "world"
$('#message').click -> show_message "you"
###