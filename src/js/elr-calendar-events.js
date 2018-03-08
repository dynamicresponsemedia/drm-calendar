import $ from 'jquery'
import elrTimeUtlities from 'elr-time-utilities'
import elrCreate from './elr-calendar-create'

let elrTime = elrTimeUtlities()

const $calendar = $(`.elr-calendar`)
const evtClass = 'elr-event-list'
const classes = {
  weekend: 'elr-cal-weekend',
  muted: 'elr-cal-muted',
  holiday: 'elr-cal-holiday',
  today: 'elr-cal-today',
  month: 'elr-month',
  week: 'elr-week',
  date: 'elr-date'
}

const getFirstDate = $week => {
  return $week
    .find(`.${classes.date}`)
    .first()
    .data('date')
}

//gets the week of the month when an event occurs
const getEventWeekNum = (evt, year, evtDay) => {
  // gets the week of the month which an event occurs
  // TODO: add 'second', 'third', 'fourth' keywords
  const dateObj = {
    month: elrTime.months.indexOf(evt.month),
    date: 1,
    year: year
  }

  const firstDay = elrTime.getFirstDayOfMonth(dateObj)
  const numberWeeks = elrTime.getWeeksInMonth(dateObj)
  const lastWeekLength = elrTime.getLastWeekLength(dateObj)
  const day = elrTime.days.indexOf(evtDay)

  if (evt.dayNum === 'last' || evt.dayNum === numberWeeks) {
    // check if last week in month contains day
    if (lastWeekLength >= day) {
      return numberWeeks
    }

    return numberWeeks - 1
  } else if (evt.dayNum === 'first' || evt.dayNum === 1) {
    // check if first week in month contains day
    if (firstDay <= day) {
      return 1
    }

    return 2
  }

  // check if you should count from 1st or 2nd week of month
  if (elrTime.getFirstDayOfMonth(dateObj) > day) {
    return evt.dayNum + 1
  }

  return evt.dayNum
}

const getDates = function(month, year, eventWeekNum, day) {
  const dates = []
  const $week = $(this)
  const weekNum = elrTime.getDatesInWeek({
    month,
    date: getFirstDate($week),
    year
  }).weekNum

  if (eventWeekNum && eventWeekNum === weekNum) {
    const evtDate = $week.find(`.${classes.date}[data-day="${day}"]`)

    if (evtDate.length) {
      dates.push(evtDate.data('date'))
    }
  }

  return dates
}

// these events occur once per year
const addYearlyEvents = (evt, $calendarInner) => {
  // need to add support for multi-day events
  const evtDates = []
  if (evt.day) {
    evt.day.map(o => {
      const day = elrTime.days.indexOf(o)
      const month = $calendarInner.data('month')
      const year = $calendarInner.data('year')
      const weeks = $calendarInner.find('.elr-week')
      const eventWeekNum = getEventWeekNum(evt, year, o)

      weeks.each(function() {
        const dates = getDates.call($(this), month, year, eventWeekNum, day)
        if (dates.length) {
          evtDates.push(dates)
        }
      })
    })
  } else {
    evtDates.push(+evt.eventDate)
  }

  return evtDates.reduce((a, b) => {
    return a.concat(b)
  }, [])
}

// these events occur once per month
const addMonthlyEvents = (evt, $calendarInner) => {
  const $weeks = $calendarInner.find('.elr-week')
  const evtDates = []
  let eventWeekNum = 0

  // events that occur on a specific day of the week
  // eg. event occurs on the first Tuesday of every month
  if (evt.day) {
    evt.day.map(o => {
      const month = $calendarInner.data('month')
      const year = $calendarInner.data('year')
      const day = elrTime.days.indexOf(o)

      // evt.month = elrTime.months[month]
      eventWeekNum = getEventWeekNum(evt, year, o)

      $weeks.each(function() {
        const $week = $(this)
        const dates = getDates.call($week, month, year, eventWeekNum, day)

        if (dates.length) {
          evtDates.push(dates)
        }
      })
    })
  } else {
    evtDates.push(+evt.eventDate)
  }

  return evtDates.reduce((a, b) => {
    return a.concat(b)
  }, [])
}

// these events occur every 2 weeks
// they occur on odd or even weeks
const addBiWeeklyEvents = (evt, $calendarInner) => {
  const $weeks = $calendarInner.find('.elr-week')
  const evtDates = []

  evt.day.map(o => {
    const day = elrTime.days.indexOf(o)

    $weeks.each(function() {
      const $week = $(this)
      const type = $week.hasClass('even-week') ? 'even' : 'odd'

      if (type === evt.week) {
        const evtDate = $week.find(`.${classes.date}[data-day="${day}"]`)

        if (evtDate.length) {
          const date = evtDate.data('date')
          evtDates.push(date)
        }
      }
    })
  })

  return evtDates
}

// these events occur every week
// can be multiple days eg. Monday, Wendesday, Friday or Weekends
const addWeeklyEvents = (evt, $calendarInner) => {
  const $weeks = $calendarInner.find('.elr-week')
  const evtDates = []

  evt.day.map(o => {
    const day = elrTime.days.indexOf(o)

    $weeks.each(function() {
      const $week = $(this)

      const evtDate = $week.find(`.${classes.date}[data-day="${day}"]`)

      if (evtDate.length) {
        const date = evtDate.data('date')
        evtDates.push(date)
      }
    })
  })

  return evtDates
}

// these events occur every day
// can be all day events or can occur at a set time
const addDailyEvents = (evts, eventDates) => {}

// these events occur once
// can be all day events or can occur at a set time
const addOneTimeEvents = (evts, eventDates) => {}

// gets the index of an evt so we can keep track after evts are removed
const getEventIndex = evtId => {
  let index = null

  $.each(evts, function(k, v) {
    if (value.id === evtId) {
      index = key
    }

    return index
  })

  return index
}
// }

export default {
  classes,
  init(evt, $calendar, view) {
    const calendarInnerClass = `elr-calendar-${view}-view`
    const $calendarInner = $calendar.find(`div.${calendarInnerClass}`)
    const that = this
    const evtDates = that.addEvents(evt, $calendar, view)

    $.each(evtDates, function(key, date) {
      that.addEventsToCalendar(evt, date, $calendarInner, view)
    })
  },
  addEvents(evt, $calendar, view) {
    const calendarInnerClass = `elr-calendar-${view}-view`
    const $calendarInner = $calendar.find(`div.${calendarInnerClass}`)
    const evtMonth = $calendarInner.data('month')
    const month = elrTime.months.indexOf(evt.month)
    // let evtDates = []

    if (evt.recurrance === 'yearly' && evtMonth === month) {
      return addYearlyEvents(evt, $calendarInner)
    } else if (evt.recurrance === 'monthly') {
      return addMonthlyEvents(evt, $calendarInner)
    } else if (evt.recurrance === 'biweekly') {
      return addBiWeeklyEvents(evt, $calendarInner)
    } else if (evt.recurrance === 'weekly') {
      return addWeeklyEvents(evt, $calendarInner)
    } else if (evt.recurrance === 'daily') {
      return addDailyEvents(evt, $calendarInner)
    } else if (evt.recurrance === 'one-time') {
      return addOneTimeEvents(evt, $calendarInner)
    } else if (evt.recurrance === 'yearly') {
      // console.log(`event does not occur in this month: ${evt.name}`);
      return
    } else {
      console.log(`invalid event recurrance: ${evt.recurrance}`)
      return
    }

    // return evtDates
  },
  addEventsToCalendar(evt, date, $calendarInner, view) {
    const itemClass = `.${classes.date}[data-date="${date}"]`
    const $calendarItem = $calendarInner.find(itemClass)
    const eventContent = `<span class='elr-event elr-all-day-event'>${
      evt.name
    }</span>`

    const eventHtml = $('<a></a>', {
      href: `#`,
      'data-event': evt.id,
      html: eventContent
    })

    const $eventList = $calendarItem.find(`ul.${evtClass}`)

    if (!$eventList.length) {
      const $list = $('<ul></ul>', {
        class: evtClass
      }).appendTo($calendarItem)

      const $item = $('<li></li>', {
        html: eventHtml
      })

      $item.appendTo($list)

      if (evt.type === 'holiday') {
        $list.find(`a:contains(${evt.name})`).addClass(classes.holiday)
      }
    } else {
      const $item = $('<li></li>', {
        html: eventHtml
      })

      $item.appendTo($eventList)

      if (evt.type === 'holiday') {
        $eventList.find(`a:contains(${evt.name})`).addClass(classes.holiday)
      }
    }
  },
  closeEvent: e => {
    e.prevtDefault()

    $('div.elr-blackout').fadeOut(300, function() {
      $(this).remove()
    })
  },
  createEvent: (newEvent, evts, calendar) => {
    if (evts) {
      const id = evts.length
      let name
      const obj = {
        id,
        name,
        recurrance,
        month,
        year,
        evtDate,
        time,
        day,
        dayNum,
        type,
        notes
      }

      evts.push(obj)

      this.addEvents(evts[obj.id], calendar)
    }
  },
  destroyEvent: (evtId, index) => {
    const $evt = $calendar.find(`ul.${evtClass} a[data-evt=${evtId}]`)

    $evt.remove()

    return evts.splice(index, 1)
  },
  editEvent: () => {
    console.log(`${evtId} ${index}`)
  },
  updateEvent: () => {
    console.log(`${evtId} ${index}`)
  },
  readEvent: () => {
    console.log(`${evtId} ${index}`)
  }
}
