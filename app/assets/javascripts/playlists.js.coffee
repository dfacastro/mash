# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.closeMenu = () ->
  button = $("#add_button")
  menu = $('#add_menu')
  $('#add_menu tr').removeClass("adding")
  $('#add_menu .deleted').text("")

  $('*').unbind('click', closeMenu)
  menu.removeClass('active').slideUp 100, ->
    button.removeClass('active')
  button.one('click', openMenu)

window.openMenu = () ->
  button = $(this).addClass 'active'
  menu = $('#add_menu')
  $('#add_menu *').not('img').show()
  #$('#add_menu img').hide()
  offset = button.offset()
  if button.outerHeight
    h = button.outerHeight()
  else
    h = button.height()
  menu.addClass('active').css( {
    'top': offset.top + h,
    'left': offset.left
  }).slideDown 200, ->
    $('*').not('#add_menu *').click( closeMenu)

$ ->
  $('#add_menu').hide()

  $('#add_button').click openMenu

  $('#add_menu tr').click (e) ->
    $('*').unbind('click', closeMenu)
    $('*').unbind('click', openMenu)
    $(this).addClass "adding"

    $(this).parent().children('tr').not($(this)).children('td').children().each ->
      $(this).slideUp("fast")
    $(this).parent().children('tr').not($(this)).children('td').each ->
      $(this).slideUp("fast")
    #$(this).find('img').show()
    $(this).find('td').last().html("<img class='loading' src='/assets/loading.gif'/>")
    $(this).find('img').show()







