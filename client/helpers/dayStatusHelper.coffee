Template.dayStatus.helpers 
  statusData: ()->
    status = Session.get 'status'
    dataState = Session.get 'dataState'
    selectedDate = Session.get 'selectedDate'
    Date currentDate = new Date(selectedDate)

    console.log 'Status: ', status , "data state: ", dataState, "Date: ", selectedDate
    status: status, dataState: dataState, date: currentDate.toDateString()


Template.newStatus.events
  'click .addStatus': (event, template)->
    currentStat = template.find('.status').value
    Session.set 'status', currentStat

    Meteor.call 'addStatus', 
      date: Session.get('selectedDate')
      status: currentStat
      (err, data)->
        console.log 'In update respnose...', data, err
        if err
          Session.set 'dataState', {isError: true}
        else
          Session.set 'dataState', {isFetched: true}
