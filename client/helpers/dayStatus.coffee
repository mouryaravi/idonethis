Template.dayStatus.helpers 
  status: ()->
    st = Session.get 'status'
    console.log 'Status:', st
    if st then st else 'Ravi is not ehre...'
