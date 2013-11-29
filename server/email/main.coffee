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

  sendEmail: (group)->
    users = Meteor.users.find({'group': group})
    userIds = _.map users.fetch(), (user)=>
      userIdMap[user._id + ''] = user.profile
      user._id

    statusList = Status.find({'date': new Date().toDateString(), userId: {'$in': userIds}})
    status = @prepareStatus statusList.fetch()

    textStatus = @buildStatusText status
    console.log '-----STATUS ----', textStatus
    htmlStatusList = @buildHtmlStatusList status
    ccUser =  if group == 'dev' then 'dev@pentaur.com' else 'qa@pentaur.com'
    subject = if group == 'dev' then 'Dev Status for ' else 'QA Status for '
    subject += new Date().toDateString()

    Email.send
      to: 'ravi@pentaur.com'
      cc: ccUser
      from: 'status-tracker@pentaur.com'
      subject: subject
      html: Handlebars.templates['status-email']({date: new Date().toDateString(), group: group, statusList: htmlStatusList})
      text: textStatus

