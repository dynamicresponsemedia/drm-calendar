import $ from 'jquery'
import calendar from '../elr-calendar'
import fs from 'fs'
import path from 'path'
import time from 'elr-time-utilities'

jest.dontMock('fs').dontMock('jquery')

const calendarHtml = path.join(__dirname, '..', 'calendar.html')
const html = fs.readFileSync(calendarHtml).toString()

beforeEach(() => {
  document.body.innerHTML = html
})

describe('init', () => {
  it('should render a calendar', () => {
    calendar.init()
    expect($('.elr-calendar-month-view').length).toBe(1)
  })
  it('should take parameters', () => {
    calendar.init({
      view: 'week'
    })
    expect($('.elr-calendar-week-view').length).toBe(1)
  })
  it('should render a provided day', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 3,
        date: 1,
        year: 2014
      }
    })
    expect($('.elr-calendar-month-view').data('month')).toBe(3)
    expect($('.elr-calendar-month-view').data('year')).toBe(2014)
  })
  it('should show holidays', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 2,
        date: 1,
        year: 2018
      }
    })
    expect($('.elr-cal-holiday').length).toBe(1)
    expect($('.elr-cal-holiday').html()).toMatchSnapshot()
  })
  it('should show floating holidays', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 0,
        date: 1,
        year: 2018
      }
    })
    expect($('#date0152018').find('.elr-cal-holiday').length).toBe(1)
    expect(
      $('#date0152018')
        .find('.elr-cal-holiday')
        .html()
    ).toMatchSnapshot()
  })
  it('should advance year', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 3,
        date: 1,
        year: 2014
      }
    })

    $('.elr-calendar-year-next').click()

    expect($('.elr-calendar-month-view').data('year')).toBe(2015)

    $('.elr-calendar-year-next').click()

    expect($('.elr-calendar-month-view').data('year')).toBe(2016)

    $('.elr-calendar-year-prev').click()

    expect($('.elr-calendar-month-view').data('year')).toBe(2015)

    $('.elr-calendar-year-prev').click()

    expect($('.elr-calendar-month-view').data('year')).toBe(2014)

    $('.elr-calendar-year-prev').click()

    expect($('.elr-calendar-month-view').data('year')).toBe(2013)
  })
  it('should advance month', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2014
      }
    })

    $('.elr-calendar-month-next').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(2)

    $('.elr-calendar-month-next').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(3)

    $('.elr-calendar-month-prev').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(2)
  })
  it('should show current date', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2014
      }
    })

    $('.elr-calendar-month-next').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(2)

    $('.elr-calendar-year-next').click()

    expect($('.elr-calendar-month-view').data('year')).toBe(2015)

    $('.elr-calendar-current').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(1)
    expect($('.elr-calendar-month-view').data('year')).toBe(2014)
  })
  it('should go to december on prev month click if its january', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 0,
        date: 1,
        year: 2014
      }
    })

    $('.elr-calendar-month-prev').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(11)
    expect($('.elr-calendar-month-view').data('year')).toBe(2013)
  })
  it('should go to january on next month click if its december', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 11,
        date: 1,
        year: 2014
      }
    })

    $('.elr-calendar-month-next').click()

    expect($('.elr-calendar-month-view').data('month')).toBe(0)
    expect($('.elr-calendar-month-view').data('year')).toBe(2015)
  })
  it('should display events that occur on a monthly basis', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      },
      newEvents: [
        {
          name: 'First Tuesday',
          recurrance: 'monthly',
          day: ['Tuesday'],
          dayNum: 1
        }
      ]
    })
    expect($('#date162018').find('ul.elr-event-list').length).toBe(1)
    expect(
      $('#date162018')
        .find('ul.elr-event-list')
        .html()
    ).toMatchSnapshot()
  })
  it('should add a class to weekends', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect($('#date142018').hasClass('elr-cal-weekend')).toBe(true)
  })
  xit('should add class to current date', () => {
    const today = time().today()
    const id = `#date${today.month}${today.date}${today.year}`
    calendar.init({
      view: 'month',
      currentDate: today
    })

    expect($(id).hasClass('elr-cal-today')).toBe(true)
  })
  it('should add week numbers', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect(
      $('.elr-week')
        .eq(1)
        .data('week')
    ).toBe(6)
  })
  it('should add odd/even week classes', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect(
      $('.elr-week')
        .eq(1)
        .hasClass('even-week')
    ).toBeTruthy()
    expect(
      $('.elr-week')
        .eq(2)
        .hasClass('odd-week')
    ).toBeTruthy()
  })
  it('should show days of the week', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect($('.elr-calendar .elr-calendar-heading').length).toBe(1)
    expect($('.elr-calendar .elr-calendar-heading').html()).toMatchSnapshot()
  })
  it('should create a date element', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect(
      $('.elr-calendar .elr-week:nth-child(2) > div:first-child').html()
    ).toMatchSnapshot()
  })
  it('should create the first week of a month', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect($('.elr-calendar .elr-week:nth-child(1)').html()).toMatchSnapshot()
  })
  it('should create the last week of a month', () => {
    calendar.init({
      view: 'month',
      currentDate: {
        month: 1,
        date: 1,
        year: 2018
      }
    })
    expect($('.elr-calendar .elr-week:last-of-type').html()).toMatchSnapshot()
  })
})
