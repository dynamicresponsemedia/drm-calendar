import $ from 'jquery'
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

describe('renderMonth', () => {
  it('should display a month', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    expect($cal.find('.elr-calendar-month-view').html()).toMatchSnapshot()
  })
  it('should show appropriate navigation', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    expect($('.elr-calendar-year-prev').length).toBe(1)
    expect($('.elr-calendar-year-prev').text()).toBe('2017')

    expect($('.elr-calendar-year-next').length).toBe(1)
    expect($('.elr-calendar-year-next').text()).toBe('2019')

    expect($('.elr-calendar-month-prev').length).toBe(1)
    expect($('.elr-calendar-month-prev').text()).toBe('February')

    expect($('.elr-calendar-month-next').length).toBe(1)
    expect($('.elr-calendar-month-next').text()).toBe('April')

    expect($('.elr-calendar-week-prev').length).toBe(1)
    expect($('.elr-calendar-week-prev').css('display')).toBe('none')
    expect($('.elr-calendar-week-next').length).toBe(1)
    expect($('.elr-calendar-week-next').css('display')).toBe('none')

    expect($('.elr-calendar-date-prev').length).toBe(1)
    expect($('.elr-calendar-date-prev').css('display')).toBe('none')
    expect($('.elr-calendar-date-next').length).toBe(1)
    expect($('.elr-calendar-date-next').css('display')).toBe('none')
  })
  it('should create a heading', () => {
    elrMonths.renderMonth(renderDate, $cal, evts)

    expect($('.elr-calendar-header').text()).toBe('March 2018')
  })
})
