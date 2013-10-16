getStatus = (date)->
  Session.set 'dataState', {isFetching: true}

  Meteor.call 'getStatus', date, (err, data)->
    console.log 'In respnose...', data, err
    Session.set 'dataState', if err then {isError: true} else {isFetched: true}
    Session.set 'selectedDate', date
    Session.set 'status', data?.status
    Session.set 'editable', data?.editable

Template.calendar.rendered = ()->
  $('#calendar-main').fullCalendar
    header: 
      left: 'prev,next,today'
      center: 'title'
      right: 'month,basicWeek,basicDay'
    weekends:true,
    editable:true,
    selectable: true,
    dayClick: (date, allDay, jsEvent, view)->
      Session.set 'selectedDate', date
      getStatus date

Template.calendar.created = ()->
  Session.set 'selectedDate', new Date()
  getStatus new Date()