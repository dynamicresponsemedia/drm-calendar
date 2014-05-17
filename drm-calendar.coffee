###############################################################################
# Interactive JS Calendar
###############################################################################

"use strict"

( ($) ->
    class window.DrmCalendar
        constructor: (@calendarClass = 'drm-calendar', @daysPerWeek = 7, @view = 'date', @addHolidays = yes) ->
            self = @
            self.body = $ 'body'
            self.events = []
            self.today = new Date()
            self.currentMonth = self.today.getMonth()
            self.currentYear = self.today.getFullYear()
            self.currentDate = self.today.getDate()
            self.calendarInnerClass = "drm-calendar-#{self.view}-view"
            self.calendar = $ ".#{self.calendarClass}"
            self.calendarNav = $ '.drm-calendar-nav'
            self.calendarSelect = $ '.drm-calendar-select'
            self.calendarSelectButton = self.calendarSelect.find 'button[type=submit]'
            self.addEventForm = self.calendar.find('form.drm-calendar-new-event').hide()
            self.showEventFormButton = self.calendar.find 'button.drm-show-event-form'
            self.calendarViewActiveButton = self.calendar.find(".drm-calendar-view-nav button[data-view=#{self.view}]").addClass 'active'
            self.eventClass = 'drm-events'
            self.classes =
                weekend: 'drm-cal-weekend'
                muted: 'drm-cal-muted'
                holiday: 'drm-cal-holiday'
                today: 'drm-cal-today'
                month: 'drm-month'
                week: 'drm-week'
                date: 'drm-date'

            self.months = [             
                'January'
                'February'
                'March'
                'April'
                'May'
                'June'
                'July'
                'August'
                'September'
                'October' 
                'November' 
                'December']

            self.days = [
                'Sunday'
                'Monday'
                'Tuesday'
                'Wednesday'
                'Thursday'
                'Friday'
                'Saturday']

            self.weekday = [
                $.inArray('Monday', self.days)
                $.inArray('Tuesday', self.days)
                $.inArray('Wednesday', self.days)
                $.inArray('Thursday', self.days)
                $.inArray('Friday', self.days)
            ]

            self.weekend = [
                $.inArray('Sunday', self.days)
                $.inArray('Saturday', self.days)
            ]

            self.hours = [
                {
                    name: 'All Day Event'
                    time: null
                }
                {
                    name: '12am'
                    time: 0
                }
                {
                    name: '1am'
                    time: 1
                }
                {
                    name: '2am'
                    time: 2
                }
                {
                    name: '3am'
                    time: 3
                }
                {
                    name: '4am'
                    time: 4
                }
                {
                    name: '5am'
                    time: 5
                }
                {
                    name: '6am'
                    time: 6
                }
                {
                    name: '7am'
                    time: 7
                }
                {
                    name: '8am'
                    time: 8
                }
                {
                    name: '9am'
                    time: 9
                }
                {
                    name: '10am'
                    time: 10
                }
                {
                    name: '11am'
                    time: 11
                }
                {
                    name: '12pm'
                    time: 12
                }
                {
                    name: '1pm'
                    time: 13
                }
                {
                    name: '2pm'
                    time: 14
                }
                {
                    name: '3pm'
                    time: 15
                }
                {
                    name: '4pm'
                    time: 16
                }
                {
                    name: '5pm'
                    time: 17
                }
                {
                    name: '6pm'
                    time: 18
                }
                {
                    name: '7pm'
                    time: 19
                }
                {
                    name: '8pm'
                    time: 20
                }
                {
                    name: '9pm'
                    time: 21
                }
                {
                    name: '10pm'
                    time: 22
                }
                {
                    name: '11pm'
                    time: 23
                }
            ]

            self.holidays = [
                {
                    name: "New Year's Day"
                    month: "January"
                    eventDate: 1
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Martin Luther King's Birthday"
                    month: "January"
                    day: ["Monday"]
                    dayNum: 3
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Groundhog Day"
                    month: "February"
                    eventDate: 2
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Valentine's Day"
                    month: "February"
                    eventDate: 14
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "President's Day"
                    month: "February"
                    day: ["Monday"]
                    dayNum: 3
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "St. Patrick's Day"
                    month: "March"
                    eventDate: 17
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "April Fool's Day"
                    month: "April"
                    eventDate: 1
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Earth Day"
                    month: "April"
                    eventDate: 22
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Arbor Day"
                    month: "April"
                    day: ["Friday"]
                    dayNum: "last"
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "May Day"
                    month: "May"
                    eventDate: 1
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Cinco De Mayo"
                    month: "May"
                    eventDate: 5
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Mother's Day"
                    month: "May"
                    day: ["Sunday"]
                    dayNum: 2
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Memorial Day"
                    month: "May"
                    day: ["Monday"]
                    dayNum: "last"
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Flag Day"
                    month: "June"
                    eventDate: 14
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Father's Day"
                    month: "June"
                    day: ["Sunday"]
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                    dayNum: 3
                }
                {
                    name: "Independence Day"
                    month: "July"
                    eventDate: 4
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Labor Day"
                    month: "September"
                    day: ["Monday"]
                    dayNum: 1
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Patroit Day"
                    month: "September"
                    eventDate: 11
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Columbus Day"
                    month: "October"
                    day: ["Monday"]
                    dayNum: 2
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Halloween"
                    month: "October"
                    eventDate: 31
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Veteran's Day"
                    month: "November"
                    eventDate: 11
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Thanksgiving"
                    month: "November"
                    day: ["Thursday"]
                    dayNum: 4
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Pearl Harbor Day"
                    month: "December"
                    eventDate: 7
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Festivus"
                    month: "December"
                    eventDate: 23
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Christmas Eve"
                    month: "December"
                    eventDate: 24
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Christmas"
                    month: "December"
                    eventDate: 25
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "Boxing Day"
                    month: "December"
                    eventDate: 26
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
                {
                    name: "New Year's Eve"
                    month: "December"
                    eventDate: 31
                    type: "holiday"
                    recurrance: "yearly"
                    allDayEvent: true
                }
            ]

            if self.addHolidays
                $.each self.holidays, (key, value) ->
                    self.createEvent value

            if self.calendar.length > 0
                self.createCalendar self.currentMonth, self.currentDate, self.currentYear

            self.calendar.on 'click', '.drm-calendar-date-prev, .drm-calendar-date-next', ->
                direction = $(@).data 'dir'
                self.advanceDate.call @, direction

            self.calendar.on 'click', '.drm-calendar-week-prev, .drm-calendar-week-next', ->
                direction = $(@).data 'dir'
                self.advanceWeek.call @, direction

            self.calendar.on 'click', '.drm-calendar-month-prev, .drm-calendar-month-next', ->
                direction = $(@).data 'dir'
                self.advanceMonth.call @, direction

            self.calendar.on 'click', '.drm-calendar-year-prev, .drm-calendar-year-next', ->
                direction = $(@).data 'dir'
                self.advanceYear.call @, direction

            self.calendar.on 'click', '.drm-calendar-current', ->
                self.changeCalendar.call @, self.currentMonth, self.currentDate, self.currentYear

            self.calendar.on 'click', '.drm-calendar-select button[type=submit]', (e) ->
                e.preventDefault()
                that = $ @
                month = that.parent().find('#month').val()
                date = self.currentDate
                year = that.parent().find('#year').val()

                that.parent().find('#month').val ''
                that.parent().find('#year').val ''

                month = parseInt month, 10
                year = parseInt year, 10

                self.changeCalendar.call self, month, date, year

            self.calendar.on 'click', 'button.drm-show-event-form', ->
                that = $ @
                if self.addEventForm.is(':hidden')
                    self.addEventForm.slideDown()
                    that.text 'Hide Form'
                else
                    self.addEventForm.slideUp()
                    that.text 'Add New Event'

            self.calendar.on 'click', '.drm-calendar-view-nav button', (e) ->
                e.preventDefault()
                that = $ @
                calendar = $ ".#{self.calendarInnerClass}"

                currentMonth = calendar.data 'month'
                currentYear = calendar.data 'year'
                currentDate = if currentMonth is self.currentMonth then self.currentDate else 1

                self.view = that.data 'view'
                self.calendar.find(".drm-calendar-view-nav button.active").removeClass 'active'
                that.addClass 'active'
                self.changeCalendar currentMonth, currentDate, currentYear

            self.calendar.on 'click', 'form.drm-calendar-new-event button.addEvent', (e) ->                
                e.preventDefault()
                currentMonth = $(".#{self.calendarInnerClass}").data 'month'
                newEvent =
                    name: if self.addEventForm.find('#event-name').val() is '' then null else self.addEventForm.find('#event-name').val()
                    recurrance: if self.addEventForm.find('#recurrance').val() is '' then 'none' else self.addEventForm.find('#recurrance').val()
                    month: if self.addEventForm.find('#month').val() is '' then null else self.addEventForm.find('#month').val()
                    year: if self.addEventForm.find('#year').val() is '' then null else parseInt(self.addEventForm.find('#year').val(), 10)
                    eventDate: if self.addEventForm.find('#event-date').val() is '' then null else parseInt(self.addEventForm.find('#event-date').val(), 10)
                    time: if self.addEventForm.find('#time').val() is '' then null else self.addEventForm.find('#time').val()
                    day: []
                    dayNum: if self.addEventForm.find('#day-num').val() is '' then null else self.addEventForm.find('#day-num').val()
                    allDayEvent: if self.addEventForm.find('#all-day-event').prop('checked') then true else false
                    type: if self.addEventForm.find('#event-type').val() is '' then null else self.addEventForm.find('#event-type').val()
                    notes: if self.addEventForm.find('#event-notes').val() is '' then null else self.addEventForm.find('#event-notes').val()

                self.addEventForm.find('input.day-checkbox:checked').each ->
                    newEvent.day.push $.trim($(@).val())
                if newEvent.day.length is 0
                    newEvent.day = null

                self.createEvent newEvent
                newMonth = if newEvent.month? then $.inArray newEvent.month, self.months else self.currentMonth
                if newMonth isnt currentMonth then self.changeCalendar.call @, newMonth, newEvent.eventDate, self.currentYear
                # reset form
                self.addEventForm.find(':input').val ''
                self.addEventForm.find('input:checked').prop 'checked', false

            self.calendar.on 'click', ".drm-date", ->
                that = $ @
                month = self.months[that.data('month')]
                date = that.data 'date'
                year = that.data 'year'

                if self.addEventForm.is ':hidden'
                    self.addEventForm.slideDown()
                    self.showEventFormButton.text 'Hide Form'

                month: self.addEventForm.find('#month').val month
                year: self.addEventForm.find('#year').val year
                eventDate: self.addEventForm.find('#event-date').val date

            # show event details
            self.calendar.on 'click', "ul.#{self.eventClass} a", (e) ->
                that = $ @
                day = that.closest('.drm-date')
                eventId = that.data 'event'
                fullDate =
                    month: self.months[day.data('month')]
                    date: day.data 'date'
                    year: day.data 'year'
                e.preventDefault()
                e.stopPropagation()
                self.showEventDetails eventId, fullDate

            self.body.on 'click', 'div.drm-calendar-event-details', (e) ->
                e.stopPropagation()

            self.body.on 'click', 'div.drm-calendar-event-details button.drm-event-delete', (e) ->
                e.preventDefault()
                that = $ @
                eventId = that.data 'event'
                index = self.getEventIndex eventId
                self.removeCalendarEvent eventId, index
                self.removeEventDetails(e)

            self.body.on 'click', 'div.drm-calendar-event-details button.drm-event-close', self.removeEventDetails

        getDaysInMonth: (month, year) ->
            month = month + 1
            new Date(year, month, 0).getDate()

        getDayOfWeek: (month, date, year) ->
            day = new Date year, month, date
            day.getDay()

        getWeeksInMonth: (numberDays, dayShift) =>
            Math.ceil (numberDays + dayShift) / @daysPerWeek

        highlightCurrentDay: =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            month = calendarInner.data 'month'
            year = calendarInner.data 'year'

            if month is @currentMonth and year is @currentYear
                calendarInner.find(".drm-date[data-date=#{@currentDate}]").addClass @classes.today

        createEvent: (newEvent) =>
            id = @events.length
            obj =
                id: id
                name: if newEvent.name? then newEvent.name else null
                recurrance: if newEvent.recurrance? then newEvent.recurrance.toLowerCase() else 'none'
                month: if newEvent.month? then newEvent.month else null
                year: if newEvent.year? then newEvent.year else null
                eventDate: if newEvent.eventDate? then newEvent.eventDate else null
                time: if newEvent.time? then newEvent.time else null
                day: if newEvent.day? then newEvent.day else null
                dayNum: if newEvent.dayNum? then newEvent.dayNum else null
                allDayEvent: if newEvent.allDayEvent? then newEvent.allDayEvent else false
                type: if newEvent.type? then newEvent.type.toLowerCase() else null
                notes: if newEvent.notes? then newEvent.notes else null
            @events.push obj
            @addEventsToCalendar @events[obj.id]

        addNewCalendarEvent: (events, dates) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"

            if @view is 'month'
                calendarItem = calendarInner.find ".drm-date[data-date=#{dates}]"
            else if (events.allDayEvent or !events.time?)
                calendarItem = calendarInner.find ".drm-date[data-date=#{dates}][data-hour='All Day Event']"
            else if !events.allDayEvent
                # find hour td element
                re = new RegExp '^0?','gi'
                re2 = new RegExp ':[0-9]{2}', 'gi'
                hour = events.time.replace re, ''
                hour = hour.replace re2, ''
                calendarItem = calendarInner.find ".drm-date[data-date=#{dates}][data-hour=#{hour}]"

            eventList = calendarItem.find "ul.#{@eventClass}"
            length = eventList.length
            eventHtml = if events.time? then "<a href='#' data-event='#{events.id}'><span class='drm-time'>#{events.time}:</span><span class='drm-event'>#{events.name}</span></a>" else "<a href='#' data-event='#{events.id}'><span class='drm-event drm-all-day-event'>#{events.name}</span></a>"

            if length is 0
                eventList = $ '<ul></ul>',
                    class: @eventClass

                eventList.appendTo calendarItem
            
            item = $ '<li></li>',
                html: eventHtml
            
            item.appendTo eventList

            if events.type is 'holiday' then eventList.find("a:contains(#{events.name})").addClass @classes.holiday

        removeCalendarEvent: (eventId, index) =>
            events = @calendar.find "ul.#{@eventClass} a[data-event=#{eventId}]"
            events.remove()
            @events.splice index, 1

        getEventIndex: (eventId) =>
            index = null
            $.each @events, (key, value) ->
                if value.id is eventId
                    index = key
            index

        showEventDetails: (eventId, fullDate) =>
            index = @getEventIndex eventId
            events = @events[index]
            eventDate = "#{fullDate.month} #{fullDate.date}, #{fullDate.year}"
            eventFrequency =
                if events.recurrance is 'yearly' and events.dayNum?
                    "Every #{events.dayNum} #{events.day} of #{events.month}"
                else if events.recurrance is 'monthly'
                    "Every #{events.dayNum} #{events.day} of the month"
                else if events.recurrance is 'biweekly'
                    "Every other #{events.day}"
                else if events.recurrance is 'weekly'
                    "Every #{events.day}"
                else if events.recurrance is 'daily'
                    "Every Day"
                else if events.recurrance is 'none'
                    "One Time Event"

            eventHolder = $ '<div></div>',
                class: 'drm-calendar-event-details'
                html: "<h1 class='drm-calendar-header'>#{events.name}</h1>"
            date = $ '<li></li>',
                html: "<span class='drm-bold'>Date: </span><span class='drm-event-detail'>#{eventDate}</span>"
            type = $ '<li></li>',
                html: "<span class='drm-bold'>Type: </span><span class='drm-event-detail'>#{events.type}</span>"
            frequency = $ '<li></li>',
                html: "<span class='drm-bold'>Frequency: </span><span class='drm-event-detail'>#{eventFrequency}</span>"
            recurrance = $ '<li></li>',
                html: "<span class='drm-bold'>Repeat: </span><span class='drm-event-detail'>#{events.recurrance}</span>"
            notes = $ '<li></li>',
                html: "<span class='drm-bold'>Notes: </span><span class='drm-event-detail'>#{events.notes}</span>"
            closeButton = $ '<button></button>',
                class: 'drm-event-close'
                text: 'Close'
                type: 'button'
            editButton = $ "<button></button>",
                class: 'drm-event-edit'
                'data-event': events.id
                text: 'Edit'
                type: 'button'
            deleteButton = $ "<button></button>",
                class: 'drm-event-delete'
                'data-event': events.id
                text: 'Delete'
                type: 'button'
            eventDetails = $ '<ul></ul>',
                class: 'drm-event-detail-list'
            close = $ '<button></button>',
                class: 'close'
                text: 'x'
            lightboxHtml = $ '<div></div>',
                class: 'drm-blackout'
                html: close + eventHolder

            lightboxHtml.hide().appendTo('body').fadeIn 300, ->
                eventHolder.appendTo lightboxHtml
                eventDetails.appendTo eventHolder
                date.appendTo eventDetails
                if eventFrequency? then frequency.appendTo eventDetails
                if events.recurrance? then recurrance.appendTo eventDetails
                if events.type? then type.appendTo eventDetails
                if events.notes? then notes.appendTo eventDetails
                closeButton.appendTo eventDetails
                editButton.appendTo eventDetails
                deleteButton.appendTo eventDetails

        removeEventDetails: (e) ->
            $('div.drm-blackout').fadeOut 300, ->
                $(@).remove()

            e.preventDefault()

        getDatesInWeek: (currentMonth, currentDate, currentYear) =>
            self = @
            firstDay = self.getDayOfWeek currentMonth, 1, currentYear
            numberDays = self.getDaysInMonth currentMonth, currentYear
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
            currentDay = self.getDayOfWeek currentMonth, currentDate, currentYear
            numberWeeks = self.getWeeksInMonth numberDays, dayShift
            weekInfo = {}
            weekInfo.datesInWeek = []

            firstWeek = []
            lastWeek = []

            daysInFirstWeek = self.daysPerWeek - dayShift

            i = 1
            while i <= numberWeeks
                dates = []

                if i is 1
                    j = 0
                    while j < daysInFirstWeek
                        j = j + 1
                        dates.push j
                else if i < numberWeeks
                    if i is 2 then date = daysInFirstWeek
                    $.each self.days, (key, value) ->
                        date = date + 1
                        dates.push date
                else if i is numberWeeks
                    # last week in month
                    while date < numberDays
                        date = date + 1
                        dates.push date

                if $.inArray(currentDate, dates) isnt -1
                    weekInfo.weekNum = i - 1
                    weekInfo.datesInWeek = dates

                i = i + 1
            weekInfo

        getEventWeekNum: (dayNum, day, numberDays, dayShift) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            weeks = calendarInner.find '.drm-week'
            numberWeeks = self.getWeeksInMonth numberDays, dayShift
            lastWeekLength = weeks.eq(numberWeeks).length

            if dayNum is 'last' and dayShift <= day
                eventWeekNum = if lastWeekLength < day then (numberWeeks - 2) else numberWeeks - 1
            else if dayNum is 'last' and dayShift > day
                eventWeekNum = numberWeeks - 2
            else
                eventWeekNum = parseInt(dayNum, 10) - 1

            eventWeekNum = if dayShift <= day then eventWeekNum else eventWeekNum + 1

        addYearlyEvents: (events, eventDates) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            weeks = calendarInner.find '.drm-week'
            firstDay = self.getDayOfWeek currentMonth, 1, currentYear
            numberDays = self.getDaysInMonth currentMonth, currentYear
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
            month = $.inArray events.month, self.months

            # add yearly events
            if events.day
                $.each events.day, (key, value) ->
                    day = $.inArray value, self.days
                    eventWeekNum = self.getEventWeekNum events.dayNum, day, numberDays, dayShift

                    if currentMonth is month
                        weeks.each ->
                            that = $ @
                            firstDay = that.find(".#{self.classes.date}").first().data 'date'
                            weekInfo = self.getDatesInWeek currentMonth, firstDay, currentYear
                            if eventWeekNum is weekInfo.weekNum
                                eventDates.push that.find(".#{self.classes.date}[data-day=#{day}]").data 'date'
            else
                eventDates.push parseInt(events.eventDate, 10)
                
        addMonthlyEvents: (events, eventDates) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            weeks = calendarInner.find '.drm-week'
            firstDay = self.getDayOfWeek currentMonth, 1, currentYear
            numberDays = self.getDaysInMonth currentMonth, currentYear
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay

            # add monthly events
            if events.day
                $.each events.day, (key, value) ->
                    day = $.inArray value, self.days
                    eventWeekNum = self.getEventWeekNum events.dayNum, day, numberDays, dayShift
                    eventWeek = if dayShift <= day then eventWeek = weeks.eq eventWeekNum else eventWeek = weeks.eq eventWeekNum + 1
                    eventDates.push eventWeek.find(".#{self.classes.date}[data-day=#{day}]").data 'date'
            else
                eventDates.push parseInt(events.eventDate, 10)

        addBiWeeklyEvents: (events, eventDates) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            weeks = calendarInner.find '.drm-week'

            # events that occur every 2 weeks
            if events.day
                weekInfo = self.getDatesInWeek currentMonth, events.eventDate, currentYear
                $.each events.day, (key, value) ->
                    day = $.inArray value, self.days
                    length = weeks.length
                    weekPattern = if weekInfo.weekNum % 2 is 0 then 'even' else 'odd'
                    eventWeeks = calendarInner.find ".#{weekPattern}-week"

                    $.each eventWeeks, (key, value) ->
                        that = $ value
                        weekLength = that.find(".drm-date").length
                        eventDates.push that.find(".#{self.classes.date}[data-day=#{day}]").data('date')

        addWeeklyEvents: (events, eventDates) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            firstDay = self.getDayOfWeek currentMonth, 1, currentYear
            numberDays = self.getDaysInMonth currentMonth, currentYear
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
            weeks = calendarInner.find '.drm-week'

            # weekly events
            if events.day
                $.each events.day, (key, value) ->
                    day = $.inArray value, self.days
                    length = weeks.length
                    $.each weeks, (key, value) ->
                        that = $ value
                        days = if self.view is 'month' then that.find ".#{self.classes.date}" else that.find ".#{self.classes.date}[data-hour='All Day Event']"
                        weekLength = days.length
                        if key is 0 and length isnt 1
                            if dayShift <= day then eventDates.push that.find(".#{self.classes.date}[data-day=#{day}]").data('date')
                        else if key is (length - 1) and length isnt 1
                            if day < weekLength then eventDates.push that.find(".#{self.classes.date}[data-day=#{day}]").data('date')
                        else
                            eventDates.push that.find(".#{self.classes.date}[data-day=#{day}]").data('date')

            eventDates

        addDailyEvents: (events, eventDates) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            days = if self.view is 'month' then calendarInner.find ".#{self.classes.date}" else calendarInner.find ".#{self.classes.date}[data-hour='All Day Event']"
            days.each ->
                eventDates.push $(@).data 'date'

        addOneTimeEvents: (events, eventDates) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            eventDates.push parseInt(events.eventDate, 10)
            eventDates

        addEventsToCalendar: (events) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            month = $.inArray events.month, self.months
            eventDates = []

            # add yearly events
            if events.recurrance is 'yearly' and currentMonth is month
                self.addYearlyEvents events, eventDates
            else if events.recurrance is 'monthly'
                self.addMonthlyEvents events, eventDates
            else if events.recurrance is 'biweekly'
                self.addBiWeeklyEvents events, eventDates
            else if events.recurrance is 'weekly'
                self.addWeeklyEvents events, eventDates
            else if events.recurrance is 'daily'
                self.addDailyEvents events, eventDates
            else if events.recurrance is 'none' and currentMonth is month and currentYear is parseInt(events.year, 10)                                         
                self.addOneTimeEvents events, eventDates
            if eventDates.length > 0
                $.each eventDates, (key, date) ->
                    # add css classes here
                    self.addNewCalendarEvent events, date

        highlightWeekends: =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            weeks = calendarInner.find '.drm-week'

            $.each weeks, ->
                that = $ @
                $.each self.weekend, (key, value) ->
                    weekend = that.find(".#{self.classes.date}[data-day=#{value}]").not ".#{self.classes.muted}, .#{self.classes.today}, .#{self.classes.holiday}"
                    weekend.addClass self.classes.weekend

        addWeekNumbers: =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            month = calendarInner.data 'month'
            year = calendarInner.data 'year'
            weekNum = 1
            weeks = calendarInner.find '.drm-week'
            weekNums = []

            $.each self.months, (key, value) ->
                numberDays = self.getDaysInMonth key, year
                firstDay = self.getDayOfWeek key, 1, year
                dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
                numberWeeks = self.getWeeksInMonth numberDays, dayShift
                week = 1
                if $.isNumeric numberWeeks
                    until week > numberWeeks
                        if week is 1 and firstDay isnt 0
                            weekNum = weekNum
                        else
                            weekNum = weekNum + 1
                        week = week + 1

                        if month is key
                            weekNums.push weekNum

            if self.view is 'month'
                $.each weekNums, (key, value) ->
                    week = weeks.eq key
                    if value % 2 is 0 then week.addClass('even-week') else week.addClass('odd-week')
                    week.attr 'data-week', value
            else if self.view is 'week'
                weekNum = weekNums[0] + weeks.data('month-week-num')
                if weekNum % 2 is 0 then weeks.addClass('even-week') else weeks.addClass('odd-week')
                weeks.attr 'data-week', weekNum

        getWeekNumber: (currentMonth, currentDate, currentYear) =>
            self = @
            weekNum = 1
            weekNums = []
            weekInfo = self.getDatesInWeek currentMonth, currentDate, currentYear

            $.each self.months, (key, value) ->
                numberDays = self.getDaysInMonth key, currentYear
                firstDay = self.getDayOfWeek key, 1, currentYear
                dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
                numberWeeks = self.getWeeksInMonth numberDays, dayShift
                week = 1
                if $.isNumeric numberWeeks
                    until week > numberWeeks
                        if week is 1 and firstDay isnt 0
                            weekNum = weekNum
                        else
                            weekNum = weekNum + 1
                        week = week + 1
                        if currentMonth is key
                            weekNums.push weekNum
            weekNumber = weekNums[weekInfo.weekNum]

        advanceDate: (direction) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            nextYear = currentYear + 1
            lastYear = currentYear - 1
            nextMonth = if currentMonth is 11 then 0 else currentMonth + 1
            lastMonth = if currentMonth is 0 then 11 else currentMonth - 1
            currentDate = calendarInner.find(".#{@classes.date}").data 'date'
            
            if direction is 'prev'
                lastDayOfPrevMonth = @getDaysInMonth lastMonth, currentYear

                if currentDate is 1
                    currentDate = lastDayOfPrevMonth
                    currentYear = if currentMonth is 0 then lastYear else currentYear
                    currentMonth = lastMonth
                else
                    currentDate = currentDate - 1

            else if direction is 'next'
                lastDayOfMonth = @getDaysInMonth currentMonth, currentYear

                if currentDate is lastDayOfMonth
                    currentDate = 1
                    currentYear = if currentMonth is 11 then nextYear else currentYear
                    currentMonth = nextMonth
                else
                    currentDate = currentDate + 1

            if @view is 'date' then @changeCalendar currentMonth, currentDate, currentYear

        advanceWeek: (direction) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            nextYear = currentYear + 1
            lastYear = currentYear - 1
            nextMonth = if currentMonth is 11 then 0 else currentMonth + 1
            lastMonth = if currentMonth is 0 then 11 else currentMonth - 1
            
            if direction is 'prev'
                firstDay = calendarInner.find(".#{@classes.date}").first().data 'date'
                lastDayOfPrevMonth = @getDaysInMonth lastMonth, currentYear

                if firstDay is 1 and @view is 'week'
                    currentDate = lastDayOfPrevMonth
                    currentYear = if currentMonth is 0 then lastYear else currentYear
                    currentMonth = lastMonth
                else if firstDay < 7 and @view is 'week'
                    currentDate = firstDay - 1
                else if firstDay is 1 and @view is 'date'
                    currentDate = lastDayOfPrevMonth - 6 # 30 - 6 1 24
                    currentYear = if currentMonth is 0 then lastYear else currentYear
                    currentMonth = lastMonth
                else if firstDay < 7 and @view is 'date'
                    currentDate = lastDayOfPrevMonth - (7 - firstDay) # 31 - (7 - 3) = 27 27  28 - (7 - 6) = 27 6 27
                    currentYear = if currentMonth is 0 then lastYear else currentYear
                    currentMonth = lastMonth
                else
                    currentDate = firstDay - 7

            else if direction is 'next'
                lastDay = calendarInner.find(".#{@classes.date}").last().data 'date'
                lastDayOfMonth = @getDaysInMonth currentMonth, currentYear

                if lastDay is lastDayOfMonth and @view is 'week'
                    currentDate = 1
                    currentYear = if currentMonth is 11 then nextYear else currentYear
                    currentMonth = nextMonth
                else if (lastDay + 7 > lastDayOfMonth) and @view is 'week'
                    currentDate = lastDayOfMonth
                else if (lastDay + 7 > lastDayOfMonth) and @view is 'date'
                    currentDate = 7 - (lastDayOfMonth - lastDay) # 31 - 29 = 2 then 7 - 2 = 5
                    currentYear = if currentMonth is 11 then nextYear else currentYear
                    currentMonth = nextMonth
                else
                    currentDate = lastDay + 7

            if @view is 'date' or @view is 'week' then @changeCalendar currentMonth, currentDate, currentYear

        advanceMonth: (direction) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            currentDate = if currentMonth is self.currentMonth then self.currentDate else 1
            
            if direction is 'prev'
                currentMonth = if currentMonth is 0 then 11 else currentMonth - 1
                currentYear = if currentMonth is 11 then currentYear - 1 else currentYear
            else if direction is 'next'
                currentMonth = if currentMonth is 11 then 0 else currentMonth + 1
                currentYear = if currentMonth is 0 then currentYear + 1 else currentYear
            @changeCalendar currentMonth, currentDate, currentYear

        advanceYear: (direction) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            currentDate = if currentMonth is self.currentMonth then self.currentDate else 1
            
            if direction is 'prev' then currentYear = currentYear - 1 else currentYear = currentYear + 1
            
            @changeCalendar currentMonth, currentDate, currentYear

        changeCalendar: (month, date, year) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            calendarInner.fadeOut(300).queue (next) ->
                $.when(calendarInner.remove()).then(self.createCalendar(month, date, year))
                next()

        createMonthView: (currentMonth, currentYear) =>
            self = @
            self.calendarInnerClass = "drm-calendar-#{self.view}-view"
            numberDays = self.getDaysInMonth currentMonth, currentYear
            firstDay = self.getDayOfWeek currentMonth, 1, currentYear
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
            numberWeeks = self.getWeeksInMonth numberDays, dayShift
            nextYear = currentYear + 1
            lastYear = currentYear - 1
            nextMonth = if currentMonth is 11 then 0 else currentMonth + 1
            lastMonth = if currentMonth is 0 then 11 else currentMonth - 1
            prevMonthNumberDays = self.getDaysInMonth lastMonth, currentYear
            calendar = null
            heading = null
            weekdays = null
            weeks = null

            weekdays = '<table><thead><tr>'
            $.each self.days, (key, value) ->
                weekdays += "<th>#{value}</th>"
            weekdays += '</tr></thead>'

            weeks = "<tbody class='#{self.classes.month}'>"
            i = 1
            currentDate = 1
            l = 1
            prevDays = (prevMonthNumberDays - dayShift) + 1
            nextDates = 1

            while i <= numberWeeks
                j = 1
                weeks += "<tr class='#{self.classes.week}'>"
                # if we are in week 1 we need to shift to the correct day of the week
                if i is 1 and firstDay isnt 0
                    # add cells for the previous month until we get to the first day
                    while l <= dayShift
                        weeks += "<td class='#{self.classes.muted}' data-day='#{j}'>#{prevDays}</td>"
                        prevDays += 1
                        l += 1
                        j += 1
                    # start adding cells for the current month
                    while j <= self.daysPerWeek
                        weeks += "<td class='#{self.classes.date}' data-month='#{currentMonth}' data-date='#{currentDate}' data-year='#{currentYear}' data-day='#{j - 1}'>#{currentDate}</td>"
                        j += 1
                        currentDate += 1
                # if we are in the last week of the month we need to add blank cells for next month
                else if i is numberWeeks
                    while j <= self.daysPerWeek
                        # finish adding cells for the current month
                        if currentDate <= numberDays
                            weeks += "<td class='#{self.classes.date}' data-month='#{currentMonth}' data-date='#{currentDate}' data-year='#{currentYear}' data-day='#{j - 1}'>#{currentDate}</td>"
                        # start adding cells for next month
                        else
                            weeks += "<td class='#{self.classes.muted}' data-day='#{j}'>#{nextDates}</td>"
                            nextDates += 1
                        j += 1
                        currentDate += 1
                else
                    # if we are in the middle of the month add cells for the current month
                    while j <= self.daysPerWeek
                        weeks += "<td class='#{self.classes.date}' data-month='#{currentMonth}' data-date='#{currentDate}' data-year='#{currentYear}' data-day='#{j - 1}'>#{currentDate}</td>"
                        j += 1
                        currentDate += 1
                weeks += '</tr>'
                i += 1
            weeks += '</tbody></table>'

            calendar = $ '<div></div>',
                class: self.calendarInnerClass
                html: weekdays + weeks
                'data-month': currentMonth
                'data-year': currentYear

            heading = $ '<h1></h1>',
                class: 'drm-calendar-header'
                text: "#{@months[currentMonth]} #{currentYear}"
            
            calendar.appendTo ".#{self.calendarClass}"
            heading.prependTo ".#{self.calendarInnerClass}"

            self.highlightCurrentDay()
            self.highlightWeekends()
            self.addWeekNumbers()

            $.each self.events, (key, value) ->
                self.addEventsToCalendar value

            $('.drm-calendar-year-prev').text lastYear
            $('.drm-calendar-year-next').text nextYear

            $('.drm-calendar-month-prev').text self.months[lastMonth]
            $('.drm-calendar-month-next').text self.months[nextMonth]

            $('.drm-calendar-week-prev, .drm-calendar-week-next').hide()
            $('.drm-calendar-date-prev, .drm-calendar-date-next').hide()

        createWeekView: (currentMonth, currentDate, currentYear) =>
            self = @
            self.calendarInnerClass = "drm-calendar-#{self.view}-view"
            numberDays = self.getDaysInMonth currentMonth, currentYear
            firstDay = self.getDayOfWeek currentMonth, 1, currentYear
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
            numberWeeks = self.getWeeksInMonth numberDays, dayShift
            nextYear = currentYear + 1
            lastYear = currentYear - 1
            nextMonth = if currentMonth is 11 then 0 else currentMonth + 1
            lastMonth = if currentMonth is 0 then 11 else currentMonth - 1
            prevMonthNumberDays = self.getDaysInMonth lastMonth, currentYear
            calendar = null
            heading = null
            weekdays = null
            weekInfo = self.getDatesInWeek currentMonth, currentDate, currentYear
            datesInWeek = weekInfo.datesInWeek
            weekNumber = self.getWeekNumber currentMonth, currentDate, currentYear
            weekClass = if weekNumber % 2 is 0 then 'even-week' else 'odd-week'

            getDates = (datesInWeek, key) ->
                dates = {}
                # if its the first week of the month
                if datesInWeek.length < self.daysPerWeek and datesInWeek[0] is 1
                    if key is firstDay
                        dates.date = 1
                        dates.month = currentMonth
                    else if key > firstDay
                        dates.date = (key - firstDay) + 1
                        dates.month = currentMonth
                    else
                        dates.date = prevMonthNumberDays - (firstDay - (key + 1))
                        dates.month = lastMonth
                else if datesInWeek.length is self.daysPerWeek
                    dates.date = datesInWeek[key]
                    dates.month = currentMonth
                # if its the last week of the month
                else if datesInWeek.length < self.daysPerWeek and datesInWeek[0] isnt 1
                    if key < datesInWeek.length
                        dates.date = datesInWeek[key]
                        dates.month = currentMonth
                    else
                        dates.date = Math.abs (datesInWeek.length - (key + 1))
                        dates.month = nextMonth
                dates

            weekdaysHtml = "<thead><tr><th></th>"
            $.each self.days, (key, value) ->
                dates = getDates datesInWeek, key
                weekdaysHtml += "<th>#{value}<br>#{self.months[dates.month]} #{dates.date}</th>"
            weekdaysHtml += '</tr></thead>'

            weekHtml = "<tbody class='#{self.classes.week} #{weekClass}' data-week='#{weekNumber}'>"
            $.each self.hours, (key, value) ->
                hour = value.name
                weekHtml += "<tr><td><span class='hour'>#{hour}</span></td>"
                $.each self.days, (key, value) ->
                    dates = getDates datesInWeek, key
                    weekHtml += "<td class='#{self.classes.date}' data-month='#{dates.month}' data-date='#{dates.date}' data-year='#{currentYear}' data-day='#{key}' data-hour='#{hour}'></td>"
                weekHtml += '</tr>'
            weekHtml += '</tbody>'

            weekView = $ '<table></table>',
                html: weekdaysHtml + weekHtml

            calendar = $ '<div></div>',
                class: self.calendarInnerClass
                html: weekView
                'data-month': currentMonth
                'data-year': currentYear

            weekDates = if datesInWeek.length > 1 then "#{datesInWeek[0]} - #{datesInWeek[datesInWeek.length - 1]}" else "#{datesInWeek[0]}"

            heading = $ '<h1></h1>',
                class: 'drm-calendar-header'
                text: "#{@months[currentMonth]} #{weekDates}: Week #{weekNumber} of #{currentYear}"
            
            calendar.appendTo ".#{self.calendarClass}"
            heading.prependTo "div.#{self.calendarInnerClass}"

            $("div.#{self.calendarInnerClass}").find("tbody td[data-month=#{lastMonth}]").addClass(self.classes.muted).removeClass 'drm-date'
            $("div.#{self.calendarInnerClass}").find("tbody td[data-month=#{nextMonth}]").addClass(self.classes.muted).removeClass 'drm-date'
            self.highlightCurrentDay()
            self.highlightWeekends()

            $.each self.events, (key, value) ->
                self.addEventsToCalendar value

            $('.drm-calendar-year-prev').text lastYear
            $('.drm-calendar-year-next').text nextYear

            $('.drm-calendar-month-prev').text self.months[lastMonth]
            $('.drm-calendar-month-next').text self.months[nextMonth]

            $('.drm-calendar-week-prev, .drm-calendar-week-next').show()
            $('.drm-calendar-date-prev, .drm-calendar-date-next').hide()

        createDateView: (currentMonth, currentDate, currentYear) =>
            self = @
            self.calendarInnerClass = "drm-calendar-#{self.view}-view"
            day = self.getDayOfWeek currentMonth, currentDate, currentYear
            weekNumber = self.getWeekNumber currentMonth, currentDate, currentYear
            weekClass = if weekNumber % 2 is 0 then 'even-week' else 'odd-week'
            nextYear = currentYear + 1
            lastYear = currentYear - 1
            nextMonth = if currentMonth is 11 then 0 else currentMonth + 1
            lastMonth = if currentMonth is 0 then 11 else currentMonth - 1

            dayListHtml = "<ul class='drm-week drm-day #{weekClass}' data-week='#{weekNumber}'>"
            $.each self.hours, (key, value) ->
                hour = value.name
                dayListHtml += "<li class='#{self.classes.date}' data-month='#{currentMonth}' data-date='#{currentDate}' data-year='#{currentYear}' data-day='#{day}' data-hour='#{hour}'><span class='hour'>#{hour}</span></li>"
            dayListHtml += '</ul>'

            calendar = $ '<div></div>',
                class: self.calendarInnerClass
                'data-month': currentMonth
                'data-year': currentYear
                html: dayListHtml

            headingText = 
                if currentMonth is self.currentMonth and currentDate is self.currentDate and currentYear is self.currentYear
                    "Today, #{self.days[day]}, #{self.months[currentMonth]} #{currentDate} #{currentYear}"
                else
                    "#{self.days[day]}, #{self.months[currentMonth]} #{currentDate} #{currentYear}"

            heading = $ '<h1></h1>',
                class: 'drm-calendar-header'
                text: headingText
            
            calendar.appendTo ".#{self.calendarClass}"
            heading.prependTo ".#{self.calendarInnerClass}"

            $.each self.events, (key, value) ->
                self.addEventsToCalendar value

            $('.drm-calendar-year-prev').text lastYear
            $('.drm-calendar-year-next').text nextYear

            $('.drm-calendar-month-prev').text self.months[lastMonth]
            $('.drm-calendar-month-next').text self.months[nextMonth]

            $('.drm-calendar-week-prev, .drm-calendar-week-next').show()
            $('.drm-calendar-date-prev, .drm-calendar-date-next').show()

        createCalendar: (month, date, year) =>
            self = @

            switch self.view
                when 'month' then self.createMonthView month, year
                when 'week' then self.createWeekView month, date, year
                when 'date' then self.createDateView month, date, year

    drmCalendar = new DrmCalendar()
    drmCalendar.createEvent
        name: "Rabbit Rabbit Day"
        eventDate: 1
        type: "fun day"
        recurrance: "monthly"
        notes: "Say Rabbit Rabbit for good luck this month"
    drmCalendar.createEvent
        name: "First Monday"
        day: ["Monday"]
        dayNum : 1
        type: "test"
        recurrance: "monthly"
        notes: "This is the first Monday of the month"
        allDayEvent: true
    drmCalendar.createEvent
        name: "Lawn Day"
        month: "April"
        eventDate: 24
        day: ["Thursday"]
        type: "test"
        recurrance: "biweekly"
        notes: "Every other Thursday"
        allDayEvent: true
    drmCalendar.createEvent
        name: "Not Lawn Day"
        month: "April"
        eventDate: 17
        day: ["Thursday"]
        type: "test"
        recurrance: "biweekly"
        notes: "Every other Thursday"
        allDayEvent: true
    drmCalendar.createEvent
        name: "Wake Up"
        day: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        type: "test"
        recurrance: "weekly"
        note: "Wake Up Every Day"
        allDayEvent: true
    drmCalendar.createEvent
        name: "Sleep In!"
        day: ["Saturday", "Sunday"]
        type: "test"
        recurrance: "weekly"
        allDayEvent: true
    drmCalendar.createEvent
        name: "Every Day Event"
        type: "test"
        recurrance: "daily"
        allDayEvent: true
    drmCalendar.createEvent
        name: "One Time Event"
        month: "May"
        year: 2014
        time: '1:00pm'
        eventDate: 4
        type: "test"
        recurrance: "none"
        allDayEvent: false
        note: "do this once"
    drmCalendar.createEvent
        name: "Later That Day"
        month: "May"
        year: 2014
        time: '1:30pm'
        eventDate: 4
        type: "test"
        recurrance: "none"
        allDayEvent: false
        note: "do this once"
    drmCalendar.createEvent
        name: "Another One Time Event"
        month: "May"
        year: 2014
        time: '2:30pm'
        eventDate: 4
        type: "test"
        recurrance: "none"
        allDayEvent: false
        note: "do this once"

) jQuery