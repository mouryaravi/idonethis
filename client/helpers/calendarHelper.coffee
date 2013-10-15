Template.calendar.rendered = ()->
  $('#calendar-main').fullCalendar
    header: 
      left: 'prev,next,today'
      center: 'title'
      right: 'month,basicWeek,basicDay'
    weekends:true,
    editable:true,
    dayClick: (date, allDay, jsEvent, view)->
      console.log("Clicked on date:", date)
      alert('View: ' + view.name)
      $(this).css('border-color', 'red');

