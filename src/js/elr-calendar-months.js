import $ from 'jquery'
import elrTimeUtlities from 'elr-time-utilities'
import elrEvents from './elr-calendar-events'

const elrTime = elrTimeUtlities()

const calendarInnerClass = `elr-calendar-month-view`

const findWeekend = ($this, day) => {
  return $this
    .find(`.${elrEvents.classes.date}[data-day=${day}]`)
    .not(`.${elrEvents.classes.muted}`, `.${elrEvents.classes.today}`, `.${elrEvents.classes.holiday}`)
}

const highlightWeekends = $cal => {
  const $weeks = $cal.find(`.elr-calendar-month-view`).find('.elr-week')
  const weekends = [0, 6]

  $weeks.map(function() {
    const $that = $(this)

    weekends.map(day => findWeekend($that, day).addClass(elrEvents.classes.weekend))
  })
}

const highlightToday = ($calendarInner, renderDate) => {
  const month = $calendarInner.data('month')
  const year = $calendarInner.data('year')

  if (month === renderDate.month && year === renderDate.year) {
    $calendarInner.find(`.elr-date[data-date=${renderDate.date}]`).addClass(elrEvents.classes.today)
  }
}

const addWeekNumbers = ($cal, { month, date, year }) => {
  const $weeks = $cal.find(`.elr-calendar-month-view`).find('.elr-week')
  const tmpDate = {
    month,
    date,
    year
  }

  $weeks.map(function() {
    const $week = $(this)
    const firstDateInWeek = $week
      .find('.elr-date')
      .first()
      .data('date')
    const dateObj = {
      month: tmpDate.month,
      date: firstDateInWeek,
      year: tmpDate.year
    }
    const weekNumber = elrTime.getWeekNumber(dateObj)

    addWeekClasses($week, weekNumber)
    $week.attr('data-week', weekNumber)
  })
}

const addWeekClasses = ($week, weekNumber) => {
  if (weekNumber === 53) {
    $week.addClass('even-week')
  } else if (weekNumber % 2 === 0) {
    $week.addClass('even-week')
  } else {
    $week.addClass('odd-week')
  }
}

const createMonthHeading = () => {
  let days = ''
  elrTime.days.map(day => (days += `<div class="elr-calendar-heading-day">${day}</div>`))

  return `<div class="elr-calendar-heading">${days}</div>`
}

const createDate = ({ month, date, year }, className, dayOfWeek) => {
  return `<div id="date${month}${date}${year}" class='${className}' data-month='${month}' data-date='${date}' data-year='${year}' data-day='${dayOfWeek}'>${date}</div>`
}

const createFirstWeek = renderDate => {
  const dates = elrTime.getDatesInFirstWeek(renderDate)
  let html = ''

  dates.map((o, index) => {
    if (o.month < renderDate.month) {
      html += createDate(o, elrEvents.classes.muted, index)
    } else {
      html += createDate(o, elrEvents.classes.date, index)
      renderDate.date++
    }
  })

  return html
}

const createMiddleWeeks = renderDate => {
  const dates = elrTime.getDatesInMiddleWeek(renderDate)
  let html = ''

  dates.map((o, index) => {
    html += createDate(o, elrEvents.classes.date, index)
    renderDate.date++
  })

  return html
}

const createLastWeek = renderDate => {
  const dates = elrTime.getDatesInLastWeek(renderDate)
  let html = ''

  dates.map((o, index) => {
    if (o.month > renderDate.month) {
      html += createDate(o, elrEvents.classes.muted, index)
    } else {
      html += createDate(o, elrEvents.classes.date, index)
      renderDate.date++
    }
  })

  return html
}

const createWeeks = renderDate => {
  const tempDate = {
    month: renderDate.month,
    date: 1,
    year: renderDate.year
  }

  let html = `<div class="${elrEvents.classes.month}">`
  const numberWeeks = elrTime.getWeeksInMonth(tempDate)
  const weeks = []

  for (var i = 1; i <= numberWeeks; i++) {
    weeks.push(i)
  }

  weeks.map(o => {
    html += `<div class="${elrEvents.classes.week}">`

    if (o === 1) {
      html += createFirstWeek(tempDate)
    } else if (o === numberWeeks) {
      html += createLastWeek(tempDate)
    } else {
      html += createMiddleWeeks(tempDate)
    }

    html += `</div>`
  })

  html += `</div>`

  return html
}

const createMonth = renderDate => {
  const html = `<div>${createMonthHeading()}${createWeeks(renderDate)}</div>`

  return $('<div></div>', {
    class: `calendar-inner elr-calendar-month-view`,
    'data-month': renderDate.month,
    'data-year': renderDate.year,
    html
  })
}

const createHeading = ({ month, year }) => {
  return $('<h1></h1>', {
    class: 'elr-calendar-header',
    text: `${elrTime.months[month]} ${year}`
  })
}

const setNavigation = (renderDate) => {
    const lastYear = elrTime.getPrevYear(renderDate)
    const nextYear = elrTime.getNextYear(renderDate)
    const lastMonth = elrTime.getPrevMonth(renderDate)
    const nextMonth = elrTime.getNextMonth(renderDate)

    $('.elr-calendar-year-prev').text(lastYear)
    $('.elr-calendar-year-next').text(nextYear)

    $('.elr-calendar-month-prev').text(elrTime.months[lastMonth])
    $('.elr-calendar-month-next').text(elrTime.months[nextMonth])

    $('.elr-calendar-week-prev, .elr-calendar-week-next').hide()
    $('.elr-calendar-date-prev, .elr-calendar-date-next').hide()
}

export default {
  renderMonth: ({ month, date, year }, $cal, evts, currentDate) => {
    const renderDate = {
      month,
      date,
      year
    }

    $cal.append(createMonth(renderDate))

    createHeading(renderDate).prependTo($cal.find(`.elr-calendar-month-view`))

    highlightWeekends($cal)
    // highlightToday($cal.find(`.elr-calendar-month-view`), currentDate)
    addWeekNumbers($cal, renderDate)

    evts.map(evt => elrEvents.init(evt, $cal, 'month'))

    // add and remove navigation buttons
    setNavigation(renderDate)
  }
}
