$(document).on 'turbolinks:load', ->
  $ ->
    unless typeof gon is 'undefined'
      braintree.setup(gon.client_token, 'dropin', { container: 'dropin' });
    return
  return
