class @StatusEmail
  
  userIdMap = {}

  prepareStatus: (statusList)->
    console.log statusList
    _.map statusList, (status)->
      return status: status.status, user: userIdMap[status.userId]

  buildStatusText: (userStatusList)->
    statusText = ''
    _.each userStatusList, (userStatus)->
      statusText += '\n\n'
      statusText += userStatus.user.name + ':\n\n'
      statusText += userStatus.status

    statusText

  buildHtmlStatusList: (statusList)->
    _.map statusList, (userStatus)->
      user: userStatus.user
      status: userStatus.status.replace(/\n/g, '<br />')

  sendEmail: ()->
    users = Meteor.users.find({'group': 'qa'})
    userIds = _.map users.fetch(), (user)=>
      console.log  'user: ', user
      userIdMap[user._id + ''] = user.profile
      user._id

    statusList = Status.find({'date': new Date().toDateString(), userId: {'$in': userIds}})
    status = @prepareStatus statusList.fetch()

    textStatus = @buildStatusText status
    console.log '-----STATUS ----', textStatus
    htmlStatusList = @buildHtmlStatusList status

    Email.send
      to: 'xxxx@gmail.com',
      from: 'xxx@gmail.com',
      subject: 'QA: Status for ' + new Date().toDateString()
      html: Handlebars.templates['status-email']({date: new Date().toDateString(), statusList: htmlStatusList})
      text: textStatus

