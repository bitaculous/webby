# This is the manifest for `de.js`.

#= require jquery/plugins/validate/localization/messages/de.min

#= require_self

@locale = 'de'

$ ->
  dictionary =
    'can\'t not be blank': 'darf nicht leer sein.'
    'email': 'E-Mail'
    'message': 'Nachricht'
    'name': 'Name'

  $.i18n.load dictionary

  return