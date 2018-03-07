import $ from 'jquery'
import elrTime from 'elr-time-utilities'
import elrCreate from './elr-calendar-create'
import elrActions from './elr-calendar-actions'

const setCalendar = function(settings) {
  const $cal = $(this)
  const $calendarNav = $cal.find('.elr-calendar-nav')
  // const $calendarSelect = $cal.find('.elr-calendar-select')
  // const $calendarSelectButton = $calendarSelect.find('button[type=submit]')
  // const $addEventForm = $cal.find('form.elr-calendar-new-evt').hide()
  // const $showEventFormButton = $cal.find('button.elr-show-evt-form')
  const $calendarViewActiveButton = $cal
    .find(`.elr-calendar-view-nav button[data-view=${settings.view}]`)
    .addClass('active')
  const evts = settings.newEvents.concat(elrTime().holidays)

  elrCreate.buildCalendar(
    settings.view,
    settings.currentDate,
    settings.$calendar,
    evts
  )

  $cal.on(
    'click',
    '.elr-calendar-year-prev, .elr-calendar-year-next',
    function() {
      const dir = $(this).data('dir')

      elrActions.advanceYear(dir, evts, $cal, settings.view)
    }
  )

  $cal.on(
    'click',
    '.elr-calendar-month-prev, .elr-calendar-month-next',
    function() {
      const dir = $(this).data('dir')

      elrActions.advanceMonth(dir, evts, $cal, settings.view)
    }
  )

  $cal.on('click', '.elr-calendar-current', function() {
    elrCreate.changeCalendar(settings.view, settings.currentDate, $cal, evts)
  })

  $cal.on('click', 'button.elr-calendar-view', function() {
    const $calendarInner = $cal.find('.calendar-inner')
    const dateObj = {
      month: $calendarInner.data('month'),
      date: $calendarInner
        .find(`.${settings.classes.date}`)
        .first()
        .data('date'),
      year: $calendarInner.data('year')
    }

    $('button.elr-calendar-view.active').removeClass('active')
    $(this).addClass('active')

    elrCreate.changeCalendar($(this).data('view'), dateObj, $cal, evts)
  })
}

export default {
  init({
    calendarClass = 'elr-calendar',
    view = 'month',
    addHolidays = true,
    currentDate = elrTime().today(),
    newEvents = []
  } = {}) {
    const settings = {
      calendarClass,
      view,
      addHolidays,
      currentDate,
      newEvents,
      $calendar: $(`.${calendarClass}`)
    }

    // const newDate = currentDate
    const $calendar = $(`.${calendarClass}`)

    if ($calendar.length) {
      settings.$body = $('body')
      settings.classes = {
        weekend: 'elr-cal-weekend',
        muted: 'elr-cal-muted',
        holiday: 'elr-cal-holiday',
        today: 'elr-cal-today',
        month: 'elr-month',
        week: 'elr-week',
        date: 'elr-date'
      }

      // set up each calendar
      $calendar.each(function() {
        setCalendar.call($(this), settings)
      })
    }
  }
}
