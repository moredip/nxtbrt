window.NxtBrt ?= {}

window.NxtBrt.hideToast = ()->
  $('#toast-notice').removeClass('show')

window.NxtBrt.showToast = (message)->
  $('#toast-notice').text(message).addClass('show')
