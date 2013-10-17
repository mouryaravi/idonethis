Meteor.startup () ->
  reminders = Reminders.find {"end": {"$gte": new Date()}}
  unless reminders.count() > 0
    end = moment()
    end.set 'y', 2020
    Reminders.insert 
      'name': 'qa-status'
      'time': '19:00:00'
      'end': end.toDate()
      createdAt: new Date()
      modifiedAt: new Date()
    reminders = Reminders.find {"end": {"$gte": new Date()}}

    
  _.each reminders.fetch(), (reminder)->
    console.log "------ Reminder ------", reminder
    new Reminder(reminder).scheduleWithCallback(new StatusEmail())


