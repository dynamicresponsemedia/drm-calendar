###############################################################################
# Interactive JS Calendar
###############################################################################

"use strict"

( ($) ->
    class window.DrmCalendar
        constructor: (@calendarClass = 'drm-calendar', @daysPerWeek = 7, @view = 'month') ->
            self = @
            self.today = new Date()
            self.currentMonth = self.today.getMonth()
            self.currentYear = self.today.getFullYear()
            self.currentDay = self.today.getDate()
            self.calendarInnerClass = "drm-calendar-#{self.view}-view"
            self.calendar = $ ".#{self.calendarClass}"
            self.calendarNav = $ '.drm-calendar-nav'
            self.calendarSelect = $ '.drm-calendar-select'
            self.calendarSelectButton = self.calendarSelect.find 'button[type=submit]'
            self.addEventForm = self.calendar.find('form.drm-calendar-new-event').hide()
            self.showEventFormButton = self.calendar.find 'button.drm-show-event-form'
            self.classes =
                weekend: 'drm-cal-weekend'
                muted: 'drm-cal-muted'
                holiday: 'drm-cal-holiday'
                today: 'drm-cal-today'

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

            self.events =
                newYearsDay:
                    name: "New Year's Day"
                    month: "January"
                    year: null
                    eventDate: 1
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                mlkBirthday:
                    name: "Martin Luther King's Birthday"
                    month: "January"
                    year: null
                    eventDate: null
                    day: ["Monday"]
                    time: null
                    dayNum: 3
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                groundhogDay:
                    name: "Groundhog Day"
                    month: "February"
                    year: null
                    eventDate: 2
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                valentinesDay:
                    name: "Valentine's Day"
                    month: "February"
                    year: null
                    eventDate: 14
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                presidentsDay:
                    name: "President's Day"
                    month: "February"
                    year: null
                    eventDate: null
                    day: ["Monday"]
                    time: null
                    dayNum: 3
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                stPatricksDay:
                    name: "St. Patrick's Day"
                    month: "March"
                    year: null
                    eventDate: 17
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                aprilFools:
                    name: "April Fool's Day"
                    month: "April"
                    year: null
                    eventDate: 1
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                earthDay:
                    name: "Earth Day"
                    month: "April"
                    year: null
                    eventDate: 22
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                arborDay:
                    name: "Arbor Day"
                    month: "April"
                    year: null
                    eventDate: null
                    day: ["Friday"]
                    time: null
                    dayNum: "last"
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                mayDay:
                    name: "May Day"
                    month: "May"
                    year: null
                    eventDate: 1
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                cincoDeMayo:
                    name: "Cinco De Mayo"
                    month: "May"
                    year: null
                    eventDate: 5
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                mothersDay:
                    name: "Mother's Day"
                    month: "May"
                    year: null
                    eventDate: null
                    day: ["Sunday"]
                    time: null
                    dayNum: 2
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                memorialDay:
                    name: "Memorial Day"
                    month: "May"
                    year: null
                    eventDate: null
                    day: ["Monday"]
                    time: null
                    dayNum: "last"
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                flagDay:
                    name: "Flag Day"
                    month: "June"
                    year: null
                    eventDate: 14
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                fathersDay:
                    name: "Father's Day"
                    month: "June"
                    year: null
                    eventDate: null
                    time: null
                    day: ["Sunday"]
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                    dayNum: 3
                independenceDay:
                    name: "Independence Day"
                    month: "July"
                    year: null
                    eventDate: 4
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                laborDay:
                    name: "Labor Day"
                    month: "September"
                    year: null
                    eventDate: null
                    day: ["Monday"]
                    time: null
                    dayNum: 1
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                patroitDay:
                    name: "Patroit Day"
                    month: "September"
                    year: null
                    eventDate: 11
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                columbusDay:
                    name: "Columbus Day"
                    month: "October"
                    year: null
                    eventDate: null
                    day: ["Monday"]
                    time: null
                    dayNum: 2
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                halloween:
                    name: "Halloween"
                    month: "October"
                    year: null
                    eventDate: 31
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                veteransDay:
                    name: "Veteran's Day"
                    month: "November"
                    year: null
                    eventDate: 11
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                thanksgiving:
                    name: "Thanksgiving"
                    month: "November"
                    year: null
                    eventDate: null
                    day: ["Thursday"]
                    time: null
                    dayNum: 4
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                pearlHarborDay:
                    name: "Pearl Harbor Day"
                    month: "December"
                    year: null
                    eventDate: 7
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                festivus:
                    name: "Festivus"
                    month: "December"
                    year: null
                    eventDate: 23
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                christmasEve:
                    name: "Christmas Eve"
                    month: "December"
                    year: null
                    eventDate: 24
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                christmas:
                    name: "Christmas"
                    month: "December"
                    year: null
                    eventDate: 25
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                boxingDay:
                    name: "Boxing Day"
                    month: "December"
                    year: null
                    eventDate: 26
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                newYearsEve:
                    name: "New Year's Eve"
                    month: "December"
                    year: null
                    eventDate: 31
                    day: null
                    time: null
                    dayNum: null
                    type: "holiday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: null
                mybirthday:
                    name: "My Birthday"
                    month: "March"
                    year: null
                    eventDate: 24
                    day: null
                    time: null
                    dayNum: null
                    type: "birthday"
                    recurrance: "yearly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: "Here are some notes"
                rabbitRabbitDay:
                    name: "Rabbit Rabbit Day"
                    month: null
                    year: null
                    eventDate: 1
                    day: null
                    time: null
                    dayNum: null
                    type: "fun day"
                    recurrance: "monthly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: "Say Rabbit Rabbit for good luck this month"
                firstMonday:
                    name: "First Monday"
                    month: null
                    year: null
                    eventDate: null
                    day: ["Monday"]
                    time: null
                    dayNum : 1
                    type: "test"
                    recurrance: "monthly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: "This is the first Monday of the month"
                lawnDay:
                    name: "Lawn Day"
                    month: "April"
                    year: null
                    eventDate: 24
                    day: ["Thursday"]
                    time: null
                    dayNum: null
                    type: "test"
                    recurrance: "biweekly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: "Every other Thursday"
                notLawnDay:
                    name: "Not Lawn Day"
                    month: "April"
                    year: null
                    eventDate: 17
                    day: ["Thursday"]
                    time: null
                    dayNum: null
                    type: "test"
                    recurrance: "biweekly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: "Every other Thursday"
                wednesdays:
                    name: "Wednesdays"
                    month: null
                    year: null
                    eventDate: null
                    day: ["Wednesday"]
                    time: null
                    dayNum: null
                    type: "test"
                    recurrance: "weekly"
                    endRecurrance: "never"
                    allDayEvent: true
                    notes: "Every single Wednesday"
                wakeup:
                    name: "Wake Up"
                    month: null
                    year: null
                    eventDate: null
                    day: null
                    time: null
                    dayNum: null
                    type: "test"
                    recurrance: "daily"
                    endRecurrance: "never"
                    allDayEvent: true
                    note: "Wake Up Every Day"
                mondayWednesdayFridayEvent:
                    name: "MWF"
                    month: null
                    year: null
                    eventDate: null
                    day: ["Monday", "Wednesday", "Friday"]
                    time: null
                    dayNum: null
                    type: "test"
                    recurrance: "weekly"
                    endRecurrance: "never"
                    allDayEvent: true
                    note: "Monday Wednesday Friday"
                oneTimeEvent:
                    name: "One Time Event"
                    month: "April"
                    year: 2014
                    eventDate: 21
                    day: null
                    time: null
                    dayNum: null
                    type: "test"
                    recurrance: "none"
                    endRecurrance: null
                    allDayEvent: true
                    note: "do this once"

            self.createCalendar self.currentMonth, self.currentYear

            self.calendar.on 'click', '.drm-calendar-month-prev, .drm-calendar-month-next', ->
                direction = $(@).data 'dir'
                self.advanceMonth.call @, direction

            self.calendar.on 'click', '.drm-calendar-year-prev, .drm-calendar-year-next', ->
                direction = $(@).data 'dir'
                self.advanceYear.call @, direction

            self.calendar.on 'click', '.drm-calendar-current', ->
                self.changeCalendar.call @, self.currentMonth, self.currentYear

            self.calendar.on 'click', '.drm-calendar-select button[type=submit]', (e) ->
                e.preventDefault()
                that = $ @
                month = that.parent().find('#month').val()
                year = that.parent().find('#year').val()

                that.parent().find('#month').val ''
                that.parent().find('#year').val ''

                month = parseInt month, 10
                year = parseInt year, 10

                self.changeCalendar.call self, month, year

            self.calendar.on 'click', 'button.drm-show-event-form', ->
                that = $ @
                if self.addEventForm.is(':hidden')
                    self.addEventForm.slideDown()
                    that.text 'Hide Form'
                else
                    self.addEventForm.slideUp()
                    that.text 'Add New Event'

            self.calendar.on 'click', 'form.drm-calendar-new-event button.addEvent', (e) ->                
                e.preventDefault()
                newEvent =
                    name: if self.addEventForm.find('#event-name').val() is '' then null else self.addEventForm.find('#event-name').val()
                    recurrance: if self.addEventForm.find('#recurrance').val() is '' then null else self.addEventForm.find('#recurrance').val()
                    month: if self.addEventForm.find('#month').val() is '' then null else self.addEventForm.find('#month').val()
                    year: if self.addEventForm.find('#year').val() is '' then null else parseInt(self.addEventForm.find('#year').val(), 10)
                    eventDate: if self.addEventForm.find('#event-date').val() is '' then null else parseInt(self.addEventForm.find('#event-date').val(), 10)
                    day: []
                    dayNum: if self.addEventForm.find('#day-num').val() is '' then null else self.addEventForm.find('#day-num').val()
                    type: if self.addEventForm.find('#event-type').val() is '' then null else self.addEventForm.find('#event-type').val()
                    notes: if self.addEventForm.find('#event-notes').val() is '' then null else self.addEventForm.find('#event-notes').val()
                
                self.addEventForm.find('input.day-checkbox:checked').each ->
                    newEvent.day.push $.trim($(@).val())
                if newEvent.day.length is 0
                    newEvent.day = null

                self.createEvent newEvent
                newMonth = if newEvent.month? then $.inArray newEvent.month, self.months else self.currentMonth
                self.changeCalendar.call @, newMonth, self.currentYear
                # reset form
                self.addEventForm.find(':input').val ''
                self.addEventForm.find('input.day-checkbox:checked').prop 'checked', false

            self.calendar.on 'click', "td:not(.#{self.classes.muted})", ->
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

        getDaysInMonth: (month, year) ->
            new Date(year, month, 0).getDate()

        getDayOfWeek: (month, year, day) ->
            day = new Date year, month, day
            day.getDay()

        getWeeksInMonth: (numberDays, dayShift) =>
            Math.ceil (numberDays + dayShift) / @daysPerWeek

        createDaysInMonth: =>
            self = @
            numberDays = []
            $.each @months, (key, value) ->
                numberDays.push self.getDaysInMonth (key + 1), self.currentYear

        highlightCurrentDay: =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            month = calendarInner.data 'month'
            year = calendarInner.data 'year'

            if month is @currentMonth and year is @currentYear
                calendarInner.find("[data-date=#{@currentDay}]").addClass @classes.today

        createEvent: (newEvent) =>
            obj = @events

            eventName = do ->
                key = $.trim(newEvent.name).toLowerCase()
                key.replace /\W+/g, ''
            obj[eventName] =
                name: if newEvent.name? then newEvent.name else null
                recurrance: if newEvent.recurrance? then newEvent.recurrance.toLowerCase() else null
                month: if newEvent.month? then newEvent.month else null
                year: if newEvent.year? then newEvent.year else null
                eventDate: if newEvent.eventDate? then newEvent.eventDate else null
                day: if newEvent.day? then newEvent.day else null
                dayNum: if newEvent.dayNum? then newEvent.dayNum else null
                type: if newEvent.type? then newEvent.type.toLowerCase() else null
                notes: if newEvent.notes? then newEvent.notes else null
            $(@events).add obj[eventName]

        addNewCalendarEvent: (eventName, calendarItem, type) =>
            eventClass = 'events'
            eventList = calendarItem.find "ul.#{eventClass}"
            length = eventList.length

            if length > 0
                item = $ '<li></li>',
                    html: "<a href='#'>#{eventName}</a>"

                item.appendTo eventList

            else if length is 0
                eventList = $ '<ul></ul>',
                    class: eventClass
                    html: "<li><a href='#'>#{eventName}</a></li>"

                eventList.appendTo calendarItem

            if type is 'holiday' then eventList.find('a').addClass @classes.holiday

        addEventsToCalendar: (numberDays, dayShift) =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            currentMonth = calendarInner.data 'month'
            currentYear = calendarInner.data 'year'
            weeks = calendarInner.find('tbody').find 'tr'

            getEventWeekNum = (dayNum, day, numberDays, dayShift) ->
                numberWeeks = self.getWeeksInMonth numberDays, dayShift
                lastWeekLength = weeks.eq(numberWeeks).length

                if dayNum is 'last' and dayShift <= day
                    if lastWeekLength < day then (numberWeeks - 2) else numberWeeks - 1
                else if dayNum is 'last' and dayShift > day
                    numberWeeks - 2
                else
                    parseInt(dayNum, 10) - 1

            $.each self.events, (key, events) ->                
                eventDays = []
                month = $.inArray events.month, self.months
                eventDate = []
                # add yearly events
                if events.recurrance is 'yearly' and currentMonth is month
                    if events.day
                        $.each events.day, (key, value) ->
                            day = $.inArray value, self.days
                            eventWeekNum = getEventWeekNum events.dayNum, day, numberDays, dayShift

                            if currentMonth is month
                                eventWeek = if dayShift <= day then eventWeek = weeks.eq eventWeekNum else eventWeek = weeks.eq eventWeekNum + 1
                                eventDate.push eventWeek.find('td').eq(day).data 'date'
                    else
                        eventDate.push parseInt(events.eventDate, 10)
                    
                    $.each eventDate, (key, value) ->
                        eventDays.push calendarInner.find "[data-date=#{value}]"
                
                else if events.recurrance is 'monthly'
                    # add monthly events
                    if events.day
                        $.each events.day, (key, value) ->
                            day = $.inArray value, self.days
                            eventWeekNum = getEventWeekNum events.dayNum, day, numberDays, dayShift
                            eventWeek = if dayShift <= day then eventWeek = weeks.eq eventWeekNum else eventWeek = weeks.eq eventWeekNum + 1
                            eventDate.push eventWeek.find('td').eq(day).data 'date'
                    else
                        eventDate.push parseInt(events.eventDate, 10)

                    $.each eventDate, (key, value) ->
                        eventDays.push calendarInner.find "[data-date=#{value}]"

                else if events.recurrance is 'biweekly'
                    # events that occur every 2 weeks
                    if events.day
                        $.each events.day, (key, value) ->
                            day = $.inArray value, self.days
                            length = weeks.length
                            startWeekNum = weeks.has("td[data-date=#{events.eventDate}]").data 'week'
                            weekPattern = if startWeekNum % 2 is 0 then 'even' else 'odd'
                            eventWeeks = calendarInner.find('tbody').find "tr.#{weekPattern}-week"

                            $.each eventWeeks, (key, value) ->
                                that = $ value
                                weekLength = that.find("td:not(.#{self.classes.muted})").length
                                eventDate.push that.find('td').eq(day).data('date')

                    $.each eventDate, (key, value) ->
                        eventDays.push calendarInner.find "[data-date=#{value}]"

                else if events.recurrance is 'weekly'
                    # weekly events
                    if events.day
                        $.each events.day, (key, value) ->
                            day = $.inArray value, self.days
                            length = weeks.length
                            $.each weeks, (key, value) ->
                                that = $ value
                                weekLength = that.find("td:not(.#{self.classes.muted})").length
                                if key is 0
                                    if dayShift <= day then eventDate.push that.find('td').eq(day).data('date')
                                else if key is (length - 1)
                                    if day < weekLength then eventDate.push that.find('td').eq(day).data('date')
                                else
                                    eventDate.push that.find('td').eq(day).data('date')

                    $.each eventDate, (key, value) ->
                        eventDays.push calendarInner.find "[data-date=#{value}]"

                else if events.recurrance is 'daily'
                    days = calendarInner.find('tbody').find "td:not(.#{self.classes.muted})"
                    days.each ->
                        eventDays.push $(@)

                else if events.recurrance is 'none' and currentMonth is month and currentYear is parseInt(events.year, 10)
                
                    eventDate = parseInt(events.eventDate, 10)

                    eventDays.push calendarInner.find "[data-date=#{eventDate}]"                                           
                
                if eventDays.length > 0
                    $.each eventDays, (key, day) ->
                        # add css classes here
                        self.addNewCalendarEvent events.name, day, events.type

        highlightWeekends: =>
            self = @
            weeks = self.calendar.find("div.#{@calendarInnerClass} tbody").find 'tr'

            $.each weeks, ->
                dates = $(@).find "td"
                $.each self.weekend, (key, value) ->
                    dates.eq(value).not(".#{self.classes.muted}, .#{self.classes.today}, .#{self.classes.holiday}").addClass self.classes.weekend

        addWeekNumbers: =>
            self = @
            calendarInner = self.calendar.find "div.#{@calendarInnerClass}"
            month = calendarInner.data 'month'
            year = calendarInner.data 'year'
            weekNum = 1
            weeks = self.calendar.find("div.#{@calendarInnerClass} tbody").find 'tr'
            weekNums = []

            $.each self.months, (key, value) ->
                numberDays = self.getDaysInMonth (key + 1), year
                firstDay = self.getDayOfWeek key, year, 1
                dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
                numberWeeks = self.getWeeksInMonth numberDays, dayShift
                week = 1
                
                until week > numberWeeks                    
                    if week is 1 and firstDay isnt 0
                        weekNum = weekNum
                    else
                        weekNum = weekNum + 1

                    if month is key
                        weekNums.push weekNum
                    week = week + 1
                weekNums

            $.each weekNums, (key, value) ->
                week = weeks.eq key
                if value % 2 is 0 then week.addClass('even-week') else week.addClass('odd-week')
                week.attr 'data-week', value

        advanceMonth: (direction) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            month = calendarInner.data 'month'
            year = calendarInner.data 'year'
            
            if direction is 'prev'
                month = if month is 0 then 11 else month - 1
                year = if month is 11 then year - 1 else year
            else if direction is 'next'
                month = if month is 11 then 0 else month + 1
                year = if month is 0 then year + 1 else year
            @changeCalendar month, year

        advanceYear: (direction) =>
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            month = calendarInner.data 'month'
            year = calendarInner.data 'year'
            
            if direction is 'prev' then year = year - 1 else year = year + 1
            
            @changeCalendar month, year

        changeCalendar: (month, year) =>
            self = @
            calendarInner = @calendar.find "div.#{@calendarInnerClass}"
            calendarInner.fadeOut 300, ->
                @remove()
                self.createCalendar month, year

        createCalendar: (month, year) =>
            self = @
            numberDays = self.getDaysInMonth (month + 1), year
            prevMonthNumberDays = self.getDaysInMonth month, year
            firstDay = self.getDayOfWeek month, year, 1
            dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
            numberWeeks = self.getWeeksInMonth numberDays, dayShift
            nextYear = year + 1
            lastYear = year - 1
            nextMonth = if month is 11 then @months[0] else @months[month + 1]
            lastMonth = if month is 0 then @months[11] else @months[month - 1]
            calendar = null
            heading = null
            weekdays = null
            weeks = null

            weekdays = '<table><thead><tr>'
            $.each @days, (key, value) ->
                weekdays += "<th>#{value}</th>"
            weekdays += '</tr></thead>'

            weeks = '<tbody>'
            i = 1
            date = 1
            l = 1
            prevDays = (prevMonthNumberDays - dayShift) + 1
            nextDates = 1

            while i <= numberWeeks
                j = 1
                weeks += '<tr>'
                # if we are in week 1 we need to shift to the correct day of the week
                if i is 1 and firstDay isnt 0
                    # add cells for the previous month until we get to the first day
                    while l <= dayShift
                        weeks += "<td class='#{self.classes.muted}'>#{prevDays}</td>"
                        prevDays += 1
                        l += 1
                        j += 1
                    # start adding cells for the current month
                    while j <= self.daysPerWeek
                        weeks += "<td data-month='#{month}' data-date='#{date}' data-year='#{year}'>#{date}</td>"
                        j += 1
                        date += 1
                # if we are in the last week of the month we need to add blank cells for next month
                else if i is numberWeeks
                    while j <= self.daysPerWeek
                        # finish adding cells for the current month
                        if date <= numberDays
                            weeks += "<td data-date=#{date}>#{date}</td>"
                        # start adding cells for next month
                        else
                            weeks += "<td class='#{self.classes.muted}'>#{nextDates}</td>"
                            nextDates += 1
                        j += 1
                        date += 1
                else
                    # if we are in the middle of the month add cells for the current month
                    while j <= self.daysPerWeek
                        weeks += "<td data-month='#{month}' data-date='#{date}' data-year='#{year}'>#{date}</td>"
                        j += 1
                        date += 1
                weeks += '</tr>'
                i += 1
            weeks += '</tbody></table>'

            calendar = $ '<div></div>',
                class: self.calendarInnerClass
                html: weekdays + weeks
                'data-month': month
                'data-year': year

            heading = $ '<h1></h1>',
                class: 'drm-calendar-header'
                text: "#{@months[month]} #{year}"
            
            calendar.appendTo ".#{self.calendarClass}"
            heading.prependTo ".#{self.calendarInnerClass}"

            self.highlightCurrentDay()
            self.highlightWeekends()
            self.addWeekNumbers()
            self.createEvent
                name : "Dad's Birthday"
                recurrance: "yearly"
                month: "April"
                year: null
                eventDate: 9
                day: null
                dayNum: null
                type: "birthday"
                notes: "some notes"
            self.createEvent
                name : "Foby's Birthday"
                recurrance: "yearly"
                month: "November"
                year: null
                eventDate: 23
                day: null
                dayNum: null
                type: "birthday"
                notes: "some notes"
            self.addEventsToCalendar numberDays, dayShift
            $('.drm-calendar-year-prev').text lastYear
            $('.drm-calendar-year-next').text nextYear

            $('.drm-calendar-month-prev').text lastMonth
            $('.drm-calendar-month-next').text nextMonth

    drmCalendar = new DrmCalendar()

) jQuery