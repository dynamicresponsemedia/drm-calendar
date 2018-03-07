import $ from 'jquery'
import elrEvents from '../elr-calendar-events'
import elrMonths from '../elr-calendar-months'
import elrTimeUtlities from 'elr-time-utilities'
import fs from 'fs'
import path from 'path'

// const elrMonths = elrCalendarMonths()
const elrTime = elrTimeUtlities()
let evts
let renderDate
let $cal

const calendarHtml = path.join(__dirname, '..', 'calendar.html')
const html = fs.readFileSync(calendarHtml).toString()

beforeEach(() => {
  evts = elrTime.holidays
  renderDate = {
    month: 2,
    date: 1,
    year: 2018
  }
  document.body.innerHTML = html
  $cal = $('.elr-calendar')
})

describe('events', () => {
  it('should have a classes object', () => {
    expect(elrEvents.classes).toEqual({
      weekend: 'elr-cal-weekend',
      muted: 'elr-cal-muted',
      holiday: 'elr-cal-holiday',
      today: 'elr-cal-today',
      month: 'elr-month',
      week: 'elr-week',
      date: 'elr-date'
    })
  })
})
describe('addEvents', () => {
  it('should create an array of dates for a yearly event', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    const evt = {
      name: "St. Patrick's Day",
      month: 'March',
      eventDate: 17,
      type: 'holiday',
      recurrance: 'yearly'
    }

    const events = elrEvents.addEvents(evt, $cal, 'month')

    expect(events).toEqual([17])
  })
  it('should create an array of dates for a monthly event', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    const evt = {
      name: 'First Tuesday',
      day: ['Tuesday'],
      dayNum: 1,
      recurrance: 'monthly'
    }

    const events = elrEvents.addEvents(evt, $cal, 'month')

    expect(events).toEqual([6])
  })
  it('should create an array of dates for a monthly event with multiple days', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    const evt = {
      name: 'First Weekend',
      day: ['Friday', 'Saturday', 'Sunday'],
      dayNum: 1,
      recurrance: 'monthly'
    }

    const events = elrEvents.addEvents(evt, $cal, 'month')

    expect(events).toEqual([2, 3, 4])
  })
  it('should create an array of events that occur every 2 weeks', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    const evt = {
      name: 'Pay Day',
      day: ['Friday'],
      week: 'even',
      recurrance: 'biweekly'
    }

    const events = elrEvents.addEvents(evt, $cal, 'month')

    expect(events).toEqual([9, 23])
  })
})
