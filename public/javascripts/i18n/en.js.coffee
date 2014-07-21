# This is the manifest for `en.js`.

#= require_self

@locale = 'en'

$ ->
  dictionary =
    'can\'t not be blank': 'can\'t not be blank.'
    'email': 'Email'
    'message': 'Message'
    'name': 'Name'

  $.i18n.load dictionary

  return