import $ from 'jquery'
import elrMonths from './elr-calendar-months'
import elrCalendarWeeks from './elr-calendar-weeks'

// const elrMonths = elrCalendarMonths()
const elrWeeks = elrCalendarWeeks()

const renderDateView = (renderDate, $cal, evts) => {
  // create date view
}

const buildCalendar = (view, renderDate, $cal, evts) => {
  if (view === 'month') {
    elrMonths.renderMonth(renderDate, $cal, evts)
  } else if (view === 'week') {
    elrWeeks.renderWeek(renderDate, $cal, evts)
  } else {
    return
    // self.renderDate(renderDate, $cal, evts);
  }
}

export default {
  buildCalendar,
  changeCalendar: (view, renderDate, $cal, evts) => {
    const $inner = $cal.find('.calendar-inner')
    $.when($inner.animate({ opacity: 0 }, 300)).then(
      $.when($inner.remove()).then(buildCalendar(view, renderDate, $cal, evts))
    )
  }
}
