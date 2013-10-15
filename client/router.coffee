Meteor.Router.add
  '/': ()->
    console.log "User ", Meteor.user()
    if Meteor.user() then 'user' else 'home'
  '*': '404'