import calendar from './js/elr-calendar'
import './css/main.css'
import './css/calendar.css'

calendar.init({
  view: 'month',
  newEvents: [
    {
      name: 'First Tuesday',
      recurrance: 'monthly',
      day: ['Tuesday'],
      dayNum: 1
    },
    {
      name: 'Pay Day',
      day: ['Friday'],
      week: 'even',
      recurrance: 'biweekly'
    }
  ]
})
