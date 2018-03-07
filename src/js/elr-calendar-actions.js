import $ from 'jquery'
import elrTimeUtlities from 'elr-time-utilities'
import elrCreate from './elr-calendar-create'

const elrTime = elrTimeUtlities()

const setMonth = (dir, month) => {
  if (dir === 'prev') {
    return month === 0 ? 11 : month - 1
  } else if (dir === 'next') {
    return month === 11 ? 0 : month + 1
  }
}

const setDate = () => {
  return elrTime.today.month ? elrTime.today.date : 1
}

const setYear = (dir, year, month = null) => {
  if (month) {
    if (dir === 'prev') {
      return month === 11 ? year - 1 : year
    } else if (dir === 'next') {
      return month === 0 ? year + 1 : year
    }
  }

  return dir === 'prev' ? year - 1 : year + 1
}

export default {
  advanceDate: (dir, evts, $cal) => {
    const view = 'date'
    const $calendarInner = $cal.find(`.elr-calendar-${view}-view`)
    const month = $calendarInner.data('month')
    const date = $calendarInner.find(`.${elrCreate.classes.date}`).data('date')
    const year = $calendarInner.data('year')
    const dateObj = {
      month: month,
      date: 1,
      year: year
    }
  },
  advanceWeek: (dir, evts, $cal) => {
    const view = 'week'
    const $calendarInner = $cal.find(`.elr-calendar-${view}-view`)
    const month = $calendarInner.data('month')
    const year = $calendarInner.data('year')
    const dateObj = {
      month: month,
      date: 1,
      year: year
    }
    const nextYear = dateObj.year + 1
    const lastYear = dateObj.year - 1
    const nextMonth = dateObj.month === 11 ? 0 : dateObj.month + 1
    const lastMonth = dateObj.month === 0 ? 11 : dateObj.month - 1
    let firstDay
    let lastDayOfPrevMonth
    let lastDay
    let lastDayOfMonth

    if (dir === 'prev') {
      firstDay = $calendarInner
        .find(`.${classes.date}`)
        .first()
        .data('date')
      lastDayOfPrevMonth = elrTime.getDaysInMonth({
        month: lastMonth,
        date: dateObj.date,
        year: dateObj.year
      })

      if (firstDay === 1 && view === 'week') {
        dateObj.date = lastDayOfPrevMonth
        dateObj.year = dateObj.month === 0 ? lastYear : dateObj.year
        dateObj.month = lastMonth
      } else if (firstDay < 7 && view === 'week') {
        dateObj.date = firstDay - 1
      } else if (firstDay === 1 && view === 'date') {
        dateObj.date = lastDayOfPrevMonth - 6 // 30 - 6 1 24
        dateObj.year = dateObj.month === 0 ? lastYear : dateObj.year
        dateObj.month = lastMonth
      } else if (firstDay < 7 && view === 'date') {
        dateObj.date = lastDayOfPrevMonth - (7 - firstDay)
        dateObj.year = dateObj.month === 0 ? lastYear : dateObj.year
        dateObj.month = lastMonth
      } else {
        dateObj.date = firstDay - 7
      }
    } else if (dir === 'next') {
      lastDay = $calendarInner
        .find(`.${classes.date}`)
        .last()
        .data('date')
      lastDayOfMonth = elrTime.getDaysInMonth(dateObj)

      if (lastDay === lastDayOfMonth && view === 'week') {
        dateObj.date = 1
        dateObj.year = dateObj.month === 11 ? nextYear : dateObj.year
        dateObj.month = nextMonth
      } else if (lastDay + 7 > lastDayOfMonth && view === 'week') {
        dateObj.date = lastDayOfMonth
      } else if (lastDay + 7 > lastDayOfMonth && view === 'date') {
        dateObj.date = 7 - (lastDayOfMonth - lastDay) // 31 - 29 = 2 ? 7 - 2 = 5
        dateObj.year = dateObj.month === 11 ? nextYear : dateObj.year
        dateObj.month = nextMonth
      } else {
        dateObj.date = lastDay + 7
      }
    }
  },
  advanceYear: (dir, evts, $cal, view) => {
    const $calInner = $cal.find(`.elr-calendar-${view}-view`)
    const dateObj = {
      month: $calInner.data('month'),
      date: setDate(),
      year: setYear(dir, $calInner.data('year'))
    }

    elrCreate.changeCalendar(view, dateObj, $cal, evts)
  },
  advanceMonth: (dir, evts, $cal, view) => {
    const $calInner = $cal.find(`.elr-calendar-${view}-view`)
    const month = $calInner.data('month')
    const dateObj = {
      month: setMonth(dir, month),
      date: setDate(),
      year: setYear(dir, $calInner.data('year'), setMonth(dir, month))
    }

    elrCreate.changeCalendar(view, dateObj, $cal, evts)
  }
}
