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
    @callCallbackWithTimeOut(email, timeTillReminder)


  callCallbackWithTimeOut: (email, timeTillReminder)->
    Meteor.setTimeout( 
      ()=>
        email.sendEmail @name
        now = next = moment()
        if process.env.EMAIL_PERIOD_IN_SECONDS
          next = now.add 's', process.env.EMAIL_PERIOD_IN_SECONDS
        else
          next.add 'd', 7

        console.log "next email reminder: ", next.toDate()
        @callCallbackWithTimeOut email, next.diff(moment())
      timeTillReminder
    )
