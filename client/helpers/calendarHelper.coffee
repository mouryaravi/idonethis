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
      console.log "Clicked on date:", date
      Meteor.call 'clickCalendarDay', date, (err, data)->
        console.log 'In respnose...', data, err
        Session.set 'status', data
