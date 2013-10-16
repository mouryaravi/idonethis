Template.dayStatus.helpers 
  statusData: ()->
    status = Session.get 'status'
    dataState = Session.get 'dataState'
    selectedDate = Session.get 'selectedDate'
    Date currentDate = new Date(selectedDate)
    htmlStatus = status?.replace(/\n/g, '<br />')

    console.log 'Status: ', status , "data state: ", dataState, "Date: ", selectedDate
    status: status, htmlStatus: htmlStatus, dataState: dataState, date: currentDate.toDateString()


Template.newStatus.events
  'click .addStatus': (event, template)->
    currentStat = template.find('.status').value
    Session.set 'status', currentStat

    Meteor.call 'addStatus', 
      date: Session.get 'selectedDate'
      status: currentStat
      (err, data)->
        console.log 'In addstatus respnose...', data, err
        if err
          Session.set 'dataState', {isError: true}
        else
          Session.set 'dataState', {isFetched: true}

Template.editableStatus.events
  'click .editStatusBtn': (event, template)->
    console.log 'Editing status, ', template.data
    $(template.find('.statusDiv')).addClass('hide')
    $(template.find('.editedStatusArea')).removeClass('hide')
    $(template.find('.editStatusBtn')).addClass('hide')
    $(template.find('.updateStatusBtn')).removeClass('hide')
    currentStat = template.data.status

  'click .updateStatusBtn': (event, template)->
    currentStat = template.find('.editedStatusArea').value

    Session.set 'dataState', {isFetching: true}
    Session.set 'status', currentStat

    Meteor.call 'updateStatus',
      date: Session.get 'selectedDate'
      status: currentStat
      (err, data)->
        console.log 'In update response...', data, err
        if err
          Session.set 'dataState', {isError: true}
        else
          Session.set 'dataState', {isFetched: true}





