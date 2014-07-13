# This is the manifest for `de.js`.

#= require jquery/plugins/validate/localization/messages/de.min

#= require_self

@locale = 'de'

dictionary =
  'some text': 'some text (de)'
  'some more text': 'some more text (de)'

$.i18n.load dictionary