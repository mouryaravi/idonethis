console.log "Loading main.js..."

Meteor.startup () ->
  reminders = Reminders.find {"end": {"$gte": new Date()}}
  _.each reminders.fetch(), (reminder)->
    console.log reminder
    new Reminder(reminder).scheduleWithCallback(new StatusEmail())



