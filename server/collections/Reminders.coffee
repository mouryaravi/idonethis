@Reminders = new Meteor.Collection2 'reminders', {
    schema: 
      name: 
        type: String
        label: 'Name'
        max: 200
      time:
        type: String
        label: 'Time'
        max: 10
      end:
        type: Date
        label: 'Last date of the reminder'
      createdAt:
        type: Date
        label: 'The created date'
      modifiedAt:
        type: Date
        label: 'The modified date'

    virtualFields:
      getReminderTime: (reminder)->
        arr = reminder.time.split ":"
        arr = _.map arr, (elem)->
          return parseInt elem
        scheduledTime = moment()
        if process.env.EMAIL_PERIOD_IN_SECONDS
          scheduledTime.add('s', 10)
        else
          scheduledTime.set('hour', arr[0])
          scheduledTime.set('minute', arr[1])
          scheduledTime.set('second', arr[2])
        console.log "Next email schedule time: ", scheduledTime.toDate()
        if moment().isAfter scheduledTime
          scheduledTime = scheduledTime.add 'd', 1
        scheduledTime

  }
