@Status =  new Meteor.Collection 'status'

Meteor.methods
  getStatus: (date)->
    console.log 'Searching for user, ', Meteor.userId(), ', date, ', date.toDateString()
    Status.findOne
      userId: this.userId
      date: new Date(date).toDateString()

  addStatus: (statusObj)->
    console.log 'adding status for ', statusObj
    Status.insert 
      date: new Date(statusObj.date).toDateString()
      userId: Meteor.userId()
      status: statusObj.status
      editable: true
      createdAt: new Date()
      modifiedAt: new Date()

  updateStatus: (statusObj)->
    console.log 'updating status for ', statusObj
    Status.update(
      { date: new Date(statusObj.date).toDateString(), userId: Meteor.userId() },
      { $set: {status: statusObj.status, modifiedAt: new Date()} },
    )
      

