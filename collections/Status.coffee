@Status =  new Meteor.Collection 'status'

Meteor.methods
  getStatus: (date)->
    console.log 'Searching for user, ', Meteor.userId(), ', date, ', date
    Status.findOne
      userId: this.userId
      date: date

  addStatus: (statusObj)->
    console.log 'adding status for ', statusObj
    Status.insert 
      date: statusObj.date
      userId: Meteor.userId()
      status: statusObj.status
      editable: true
      createdAt: new Date()
      modifiedAt: new Date()

  updateStatus: (statusObj)->
    console.log 'updating status for ', statusObj
    Status.update(
      { date: statusObj.date, userId: Meteor.userId() },
      { $set: {status: statusObj.status, modifiedAt: new Date()} },
    )
      

