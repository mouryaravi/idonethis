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
      createdAt: new Date()
      modifiedAt: new Date()
