console.log ("Adding file: reminder.js")

class @Reminder
  constructor: (reminder)->
    @name = reminder.name
    @options = dateTime: reminder.getReminderTime

  scheduleWithCallback: (email)->
    @addRepeatedReminder(email)

  addRepeatedReminder: (email)->
    timeTillReminder = moment(@options.dateTime).diff(moment());
    if timeTillReminder < 0
      throw new Error('Invalid reminder: Reminder must be set in future time')
    Meteor.setTimeout( 
      ()=>
        email.sendEmail @reminder
      timeTillReminder
    )
