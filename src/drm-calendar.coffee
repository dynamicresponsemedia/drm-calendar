###############################################################################
# Interactive JS Calendar
###############################################################################
# needs support for events with start and end dates and times
# needs support for events _that recur a limited number of times
# needs edit view
"use strict"

$ = jQuery

class @DrmCalendar
    constructor: (@calendarClass = 'drm-calendar', @view = 'month', @addHolidays = yes, @currentDate = 'today', @newEvents = []) ->
        self = @
        @calendar = $ ".#{@calendarClass}"
        if @calendar.length isnt 0
            @body = $ 'body'
            @daysPerWeek = 7
            @now = new Date()
            @today =
                month: @now.getMonth()
                date: @now.getDate()
                year: @now.getFullYear()
            @calendarInnerClass = "drm-calendar-#{@view}-view"
            @eventClass = 'drm-events'
            @classes =
                weekend: 'drm-cal-weekend'
                muted: 'drm-cal-muted'
                holiday: 'drm-cal-holiday'
                today: 'drm-cal-today'
                month: 'drm-month'
                week: 'drm-week'
                date: 'drm-date'
            @months = [
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

            @days = [
                'Sunday'
                'Monday'
                'Tuesday'
                'Wednesday'
                'Thursday'
                'Friday'
                'Saturday']

            @hours = [
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

            @holidays = [
                {
                    name: "New Year's Day"
                    month: "January"
                    eventDate: 1
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Martin Luther King's Birthday"
                    month: "January"
                    day: ["Monday"]
                    dayNum: 3
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Groundhog Day"
                    month: "February"
                    eventDate: 2
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Valentine's Day"
                    month: "February"
                    eventDate: 14
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "President's Day"
                    month: "February"
                    day: ["Monday"]
                    dayNum: 3
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "St. Patrick's Day"
                    month: "March"
                    eventDate: 17
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "April Fool's Day"
                    month: "April"
                    eventDate: 1
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Earth Day"
                    month: "April"
                    eventDate: 22
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Arbor Day"
                    month: "April"
                    day: ["Friday"]
                    dayNum: "last"
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "May Day"
                    month: "May"
                    eventDate: 1
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Cinco De Mayo"
                    month: "May"
                    eventDate: 5
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Mother's Day"
                    month: "May"
                    day: ["Sunday"]
                    dayNum: 2
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Memorial Day"
                    month: "May"
                    day: ["Monday"]
                    dayNum: "last"
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Flag Day"
                    month: "June"
                    eventDate: 14
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Father's Day"
                    month: "June"
                    day: ["Sunday"]
                    type: "holiday"
                    recurrance: "yearly"
                    dayNum: 3
                }
                {
                    name: "Independence Day"
                    month: "July"
                    eventDate: 4
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Labor Day"
                    month: "September"
                    day: ["Monday"]
                    dayNum: 1
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Patroit Day"
                    month: "September"
                    eventDate: 11
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Columbus Day"
                    month: "October"
                    day: ["Monday"]
                    dayNum: 2
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Halloween"
                    month: "October"
                    eventDate: 31
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Veteran's Day"
                    month: "November"
                    eventDate: 11
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Thanksgiving"
                    month: "November"
                    day: ["Thursday"]
                    dayNum: 4
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Pearl Harbor Day"
                    month: "December"
                    eventDate: 7
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Festivus"
                    month: "December"
                    eventDate: 23
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Christmas Eve"
                    month: "December"
                    eventDate: 24
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Christmas"
                    month: "December"
                    eventDate: 25
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "Boxing Day"
                    month: "December"
                    eventDate: 26
                    type: "holiday"
                    recurrance: "yearly"
                }
                {
                    name: "New Year's Eve"
                    month: "December"
                    eventDate: 31
                    type: "holiday"
                    recurrance: "yearly"
                }
            ]

            # calendar navigation
            @calendarNav = $ '.drm-calendar-nav'
            @calendarSelect = $ '.drm-calendar-select'
            @calendarSelectButton = @calendarSelect.find 'button[type=submit]'
            @addEventForm = @calendar.find('form.drm-calendar-new-event').hide()
            @showEventFormButton = @calendar.find 'button.drm-show-event-form'
            @calendarViewActiveButton = @calendar.find(".drm-calendar-view-nav button[data-view=#{@view}]").addClass 'active'

            @calendar.each ->
                that = $ @
                #extract arguments 
                _view = if !that.data('view') then self.view else that.data('view')
                _addHolidays = if that.data('holidays')? then that.data('holidays') else self.addHolidays
                _currentDate = if !that.data('month') then 'today' else {month: $.inArray(that.data('month'), self.months), date: that.data('date'), year: that.data('year')}
                events = 
                    if !that.data('event-name')
                        self.newEvents
                    else
                        [{
                            name: if that.data('event-name')? then that.data('event-name') else null
                            recurrance: if that.data('event-recurrance')? then that.data('event-recurrance').toLowerCase() else null
                            month: if that.data('event-month')? then that.data('event-month') else null
                            year: if that.data('event-year')? then that.data('event-year') else null
                            eventDate: if that.data('event-date')? then that.data('event-date') else null
                            time: if that.data('event-time')? then that.data('event-time') else null
                            day: if that.data('event-day')? then that.data('event-day') else null
                            dayNum:  if that.data('event-day-num')? then that.data('event-day-num') else null
                            type: if that.data('event-type')? then that.data('event-type').toLowerCase() else null
                            notes: if that.data('event-notes')? then that.data('event-notes') else null
                        }]

                if _addHolidays is true
                    $.each self.holidays, ->
                        self.createEvent @, events, that

                if _currentDate is 'today'
                    _currentDate = self.today
                    self.createCalendar {month: self.today.month, date: self.today.date, year: self.today.year}, that, events
                else
                    self.createCalendar {month: _currentDate.month, date: _currentDate.date, year: _currentDate.year}, that, events

            @calendar.on 'click', '.drm-calendar-date-prev, .drm-calendar-date-next', ->
                # skip date forward or backward
                direction = $(@).data 'dir'
                self.advanceDate.call @, direction

            @calendar.on 'click', '.drm-calendar-week-prev, .drm-calendar-week-next', ->
                # skip week forward or backward
                direction = $(@).data 'dir'
                self.advanceWeek.call @, direction

            @calendar.on 'click', '.drm-calendar-month-prev, .drm-calendar-month-next', ->
                # skip month forward or backward
                direction = $(@).data 'dir'
                self.advanceMonth.call @, direction

            @calendar.on 'click', '.drm-calendar-year-prev, .drm-calendar-year-next', ->
                # skip year forward or backward
                direction = $(@).data 'dir'
                self.advanceYear.call @, direction

            @calendar.on 'click', '.drm-calendar-current', ->
                # go to today's date
                self.changeCalendar.call @, {month: self.today.month, date: self.today.date, year: self.today.year}

            @calendar.on 'click', '.drm-calendar-select button[type=submit]', (e) ->
                # go to a specific date
                e.preventDefault()
                _that = $ @
                fields = _that.parent().find(':input').not 'button[type=submit]'
                newDate =
                    month: _that.parent().find('#month').val()
                    date: _that.parent().find('#date').val()
                    year: _that.parent().find('#year').val()

                # clear form
                self.clearForm fields

                # parse form data
                $.each newDate, ->
                    parseInt @, 10

                # change calendar view
                self.changeCalendar.call self, newDate

            @calendar.on 'click', 'button.drm-show-event-form', ->
                # show add event form
                _that = $ @
                if self.addEventForm.is(':hidden')
                    self.addEventForm.slideDown()
                    _that.text 'Hide Form'
                else
                    self.addEventForm.slideUp()
                    _that.text 'Add New Event'

            @calendar.on 'click', '.drm-calendar-view-nav button', (e) ->
                # change calendar view
                e.preventDefault()
                _that = $ @
                _that.addClass 'active'
                self.calendar.find(".drm-calendar-view-nav button.active").removeClass 'active'
                view = _that.data 'view'

                self.changeCalendarView view

            @calendar.on 'click', 'form.drm-calendar-new-event button.addEvent', (e) ->
                # add an new event to the events object
                # this code should be moved to its own method
                # write a method to get the form data and send the object to the createEvent method
                e.preventDefault()
                newEvent = self.getFormData self.addEventForm
                currentMonth = $(".#{self.calendarInnerClass}").data 'month'

                self.createEvent newEvent

                newMonth = if newEvent.month? then $.inArray newEvent.month, self.months else self.today.month

                if newMonth isnt currentMonth
                    newDate =
                        month: newMonth
                        date: newEvent.eventDate
                        year: self.today.year

                    self.changeCalendar.call @, newDate

                # reset form
                fields = self.addEventForm.find(':input').not('button[type=submit]').val ''
                self.clearForm fields                

            @calendar.on 'click', ".drm-date", ->
                # show event form and fill out date infomation when a date is clicked
                _that = $ @

                if self.addEventForm.is ':hidden'
                    self.addEventForm.slideDown()
                    self.showEventFormButton.text 'Hide Form'

                month: self.addEventForm.find('#month').val self.months[_that.data('month')]
                year: self.addEventForm.find('#year').val _that.data('year')
                eventDate: self.addEventForm.find('#eventDate').val _that.data('date')
                time: self.addEventForm.find('#time').val _that.data('hour')

            @calendar.on 'click', "ul.#{self.eventClass} a", (e) ->
                # show event details
                _that = $ @
                day = _that.closest '.drm-date'
                eventId = _that.data 'event'
                fullDate =
                    month: self.months[day.data('month')]
                    date: day.data 'date'
                    year: day.data 'year'
                e.preventDefault()
                e.stopPropagation()
                self.readEvent eventId, fullDate

            @body.on 'click', 'div.drm-calendar-event-details', (e) ->
                e.stopPropagation()

            @body.on 'click', 'div.drm-calendar-event-details button.drm-event-edit', (e) ->
                e.preventDefault()
                _that = $ @
                eventId = _that.data 'event'
                index = self.getEventIndex eventId
                self.editEvent()

            @body.on 'click', 'div.drm-calendar-event-details button.drm-event-delete', (e) ->
                e.preventDefault()
                _that = $ @
                eventId = _that.data 'event'
                index = self.getEventIndex eventId
                self.destroyEvent eventId, index
                self.closeEvent e

            @body.on 'click', 'div.drm-calendar-event-details button.drm-event-close', @closeEvent
    
    # utilities
    capitalize: (str) ->
        str.toLowerCase().replace /^.|\s\S/g, (a) -> a.toUpperCase()

    cleanString: (str, re) ->
        re = new RegExp "#{re}", 'i'
        return $.trim str.replace re, ''

    getFormData: (form) ->
        # get form data and return an object
        # need to remove dashes from ids
        formInput = {}
        _fields = form.find(':input').not('button').not ':checkbox'
        _checkboxes = form.find 'input:checked'

        if _checkboxes.length isnt 0
            _boxIds = []

            _checkboxes.each ->
                _boxIds.push $(@).attr 'id'

            _boxIds = $.unique boxIds

            $.each _boxIds, ->
                _checkboxValues = []
                _boxes = form.find "input:checked##{@}"

                _boxes.each ->
                    checkboxValues.push $.trim($(@).val())

                formInput["#{@}"] = checkboxValues
                return

        $.each _fields, ->
            _that = $ @
            _id = _that.attr 'id'

            _input = if $.trim(_that.val()) is '' then null else $.trim(_that.val())

            if _input? then formInput["#{_id}"] = _input
            return

        formInput

    clearForm: (fields) ->
        fields.each ->
            _that = $ @
            if _that.attr('type') is 'checkbox' then _that.prop 'checked', false else _that.val ''

    # calendar utilities
    getDaysInMonth: (month, year) ->
        # returns the number of days in a month
        _month = month + 1
        return new Date(year, _month, 0).getDate()

    getDayOfWeek: (month, date, year) ->
        # returns the day of the week for a specific date
        _day = new Date year, month, date
        return _day.getDay()

    getWeeksInMonth: (month, year) ->
        # gets the number of weeks in a month
        _firstDay = @getDayOfWeek month, 1, year
        _numberDays = @getDaysInMonth month, year
        _dayShift = if _firstDay is @daysPerWeek then 0 else _firstDay
        Math.ceil (_numberDays + _dayShift) / @daysPerWeek

    getMonthWeekNum: (dayNum, day, month, year) ->
        # gets the week of the month which an event occurs
        _weeks = @calendar.find("div.#{@calendarInnerClass}").find '.drm-week'
        _firstDay = @getDayOfWeek month, 1, year
        _dayShift = if _firstDay is @daysPerWeek then 0 else _firstDay
        _numberWeeks = @getWeeksInMonth month, year
        _lastWeekLength = _weeks.eq(_numberWeeks).length

        if dayNum is 'last' and _dayShift <= day
            eventWeekNum = if _lastWeekLength < day then (_numberWeeks - 2) else _numberWeeks - 1
        else if dayNum is 'last' and _dayShift > day
            eventWeekNum = _numberWeeks - 2
        else
            eventWeekNum = parseInt(dayNum, 10) - 1

        return if _dayShift <= day then eventWeekNum else eventWeekNum + 1

    getDatesInWeek: (month, newDate, year) ->
        _firstDay = @getDayOfWeek month, 1, year
        _numberDays = @getDaysInMonth month, year
        _dayShift = if _firstDay is @daysPerWeek then 0 else _firstDay
        _currentDay = @getDayOfWeek month, newDate, year
        _numberWeeks = @getWeeksInMonth month, year
        weekInfo = {}
        weekInfo.datesInWeek = []

        _firstWeek = []
        _lastWeek = []

        _daysInFirstWeek = @daysPerWeek - _dayShift

        _i = 1
        # get the number of dates in each week
        while _i <= _numberWeeks
            dates = []

            if _i is 1
            # first week of the month
                _j = 0
                while _j < _daysInFirstWeek
                    _j = _j + 1
                    dates.push _j
            # middle weeks
            else if _i < _numberWeeks
                if _i is 2 then _date = _daysInFirstWeek
                _j = 0
                while _j < @daysPerWeek
                    _j = _j + 1
                    _date = _date + 1
                    dates.push _date
            else if _i is _numberWeeks
            # last week in month
                while _date < _numberDays
                    _date = _date + 1
                    dates.push _date

            # get the week number
            if newDate in dates
                weekInfo.weekNum = _i - 1
                weekInfo.datesInWeek = dates

            _i = _i + 1
        weekInfo

    getWeekNumber: (month, newDate, year) ->
        self = @
        _weekNum = 1
        weekNums = []
        _weekInfo = self.getDatesInWeek month, newDate, year

        $.each self.months, (key) ->
            _numberDays = self.getDaysInMonth key, year
            _firstDay = self.getDayOfWeek key, 1, year
            _dayShift = if _firstDay is self.daysPerWeek then 0 else _firstDay
            _numberWeeks = self.getWeeksInMonth month, year
            _week = 1
            if $.isNumeric _numberWeeks
                while _week <= _numberWeeks
                    if _week is 1 and _firstDay isnt 0
                        _weekNum = _weekNum
                    else
                        _weekNum = _weekNum + 1
                    _week = _week + 1
                    if month is key
                        weekNums.push _weekNum
        
        weekNums[_weekInfo.weekNum]

    # event utilities

    getEventIndex: (eventId) ->
        # gets the index of an event so we can keep track after events are removed
        index = null
        $.each @events, (key, value) ->
            if value.id is eventId then index = key
            index
        index

    closeEvent: (e) ->
        $('div.drm-blackout').fadeOut 300, ->
            $(@).remove()

        e.preventDefault()

    createEvent: (newEvent, events, calendar) ->
        _id = events.length
        obj =
            id: _id
            name: if newEvent.name? then newEvent.name else null
            recurrance: if newEvent.recurrance? then newEvent.recurrance.toLowerCase() else 'none'
            month: if newEvent.month? then newEvent.month else null
            year: if newEvent.year? then parseInt(newEvent.year, 10) else null
            eventDate: if newEvent.eventDate? then parseInt(newEvent.eventDate, 10) else null
            time: if newEvent.time? then newEvent.time else null
            day: if newEvent.day? then newEvent.day else null
            dayNum: if newEvent.dayNum? then newEvent.dayNum else null
            type: if newEvent.type? then newEvent.type.toLowerCase() else null
            notes: if newEvent.notes? then newEvent.notes else null

        events.push obj
        @addEventsToCalendar events[obj.id], calendar

    destroyEvent: (eventId, index) ->
        events = @calendar.find "ul.#{@eventClass} a[data-event=#{eventId}]"
        events.remove()
        @events.splice index, 1

    editEvent: ->
        self = @
        eventDetailList = $('.drm-event-detail-list')
        eventDetails = eventDetailList.find 'li'

        # change event details to form fields and populate with text
        eventFormHtml = ''
        $.each eventDetails, ->
            _that = $ @
            label = $.trim(_that.find('span.drm-event-label').text()).toLowerCase()
            label = self.cleanString label, ':'
            value = $.trim _that.find('span.drm-event-detail').text()
            eventFormHtml += "<label for='#{label}'>#{self.capitalize(label)}: </label>
            <input type='text' value='#{value}' id='#{label}' name='#{label}'>"
            return eventFormHtml

        editEventForm = $ '<form></form>',
            class: 'drm-calendar-event-edit'
            html: eventFormHtml

        eventDetailList.empty().append editEventForm

        return

    updateEvent: (eventId, index) ->
        console.log "#{eventId}, #{index}"

    readEvent: (eventId, fullDate) ->
        self = @
        _index = self.getEventIndex eventId
        _events = self.events[_index]
        _eventDate = "#{fullDate.month} #{fullDate.date}, #{fullDate.year}"

        _eventFrequency = do ->
            if _events.recurrance is 'yearly' and _events.dayNum?
                "Every #{_events.dayNum} #{_events.day} of #{_events.month}"
            else if _events.recurrance is 'yearly'
                "Every #{_events.eventDate} of #{_events.month}"
            else if _events.recurrance is 'monthly' and _events.dayNum?
                "Every #{_events.dayNum} #{_events.day} of the month"
            else if _events.recurrance is 'monthly'
                "Every #{_events.eventDate} of the month"
            else if _events.recurrance is 'biweekly'
                "Every other #{_events.day}"
            else if _events.recurrance is 'weekly'
                "Every #{_events.day}"
            else if _events.recurrance is 'daily'
                "Every Day"
            else
                "One Time Event"
        
        _eventDetails =
            date: _eventDate
            time: _events.time
            type: _events.type
            frequency: _eventFrequency
            repeat: _events.recurrance
            notes: _events.notes

        _eventHolder = $ '<div></div>',
            class: 'drm-calendar-event-details'
            html: "<h1 class='drm-calendar-header'>#{_events.name}</h1>"

        _closeButton = $ '<button></button>',
            class: 'drm-event-close'
            text: 'Close'
            type: 'button'

        _editButton = $ "<button></button>",
            class: 'drm-event-edit'
            'data-event': _events.id
            text: 'Edit'
            type: 'button'

        _deleteButton = $ "<button></button>",
            class: 'drm-event-delete'
            'data-event': _events.id
            text: 'Delete'
            type: 'button'

        _eventDetailList = $ '<ul></ul>',
            class: 'drm-event-detail-list'

        _close = $ '<button></button>',
            class: 'close'
            text: 'x'

        _lightboxHtml = $ '<div></div>',
            class: 'drm-blackout'
            html: _close + _eventHolder

        _lightboxHtml.hide().appendTo('body').fadeIn 300, ->
            _eventHolder.appendTo _lightboxHtml
            _eventDetailList.appendTo _eventHolder
            $.each _eventDetails, (key, value) ->
                if value?
                    _title = self.capitalize key
                    _listItem = $ '<li></li>',
                        html: "<span class='drm-bold drm-event-label'>#{_title}: </span><span class='drm-event-detail'>#{value}</span>"
                    _listItem.appendTo _eventDetailList

            _closeButton.insertAfter _eventDetailList
            _deleteButton.insertAfter _eventDetailList
            _editButton.insertAfter _eventDetailList

        return

    # calendar creation utilities
    addEventsToCalendar: (events, calendar) ->
        self = @
        calendarInner = calendar.find "div.#{@calendarInnerClass}"
        eventMonth = calendarInner.data 'month'
        eventYear = calendarInner.data 'year'
        month = $.inArray events.month, self.months
        weeks = calendarInner.find '.drm-week'
        eventDates = []

        addEvents =
            addYearlyEvents: (events, eventDates) ->
                # add yearly events
                if events.day
                    $.each events.day, ->
                        _day = $.inArray @, self.days
                        _eventWeekNum = self.getMonthWeekNum events.dayNum, _day, eventMonth, eventYear

                        if eventMonth is month
                            weeks.each ->
                                _that = $ @
                                _firstDate = _that.find(".#{self.classes.date}").first().data 'date'
                                _weekInfo = self.getDatesInWeek eventMonth, _firstDate, eventYear
                                if _eventWeekNum is _weekInfo.weekNum
                                    eventDates.push _that.find(".#{self.classes.date}[data-day=#{_day}]").data 'date'
                else
                    eventDates.push parseInt(events.eventDate, 10)
                    
            addMonthlyEvents: (events, eventDates) ->
                # add monthly events
                if events.day
                    $.each events.day, ->
                        day = $.inArray @, self.days
                        _eventWeekNum = self.getMonthWeekNum events.dayNum, day, eventMonth, eventYear
                        weeks.each ->
                            _that = $ @
                            _firstDate = _that.find(".#{self.classes.date}").first().data 'date'
                            _weekInfo = self.getDatesInWeek eventMonth, _firstDate, eventYear
                            if _eventWeekNum is _weekInfo.weekNum
                                eventDates.push _that.find(".#{self.classes.date}[data-day=#{day}]").data 'date'
                else
                    eventDates.push parseInt(events.eventDate, 10)

            addBiWeeklyEvents: (events, eventDates) ->
                # events _that occur every 2 weeks
                if events.day
                    _weekInfo = self.getDatesInWeek eventMonth, events.eventDate, eventYear
                    $.each events.day, ->
                        _day = $.inArray @, self.days
                        _length = weeks.length
                        _weekPattern = if _weekInfo.weekNum % 2 is 0 then 'even' else 'odd'
                        _eventWeeks = calendarInner.find ".#{_weekPattern}-week"

                        $.each _eventWeeks, ->
                            _that = $ @
                            _weekLength = _that.find(".drm-date").length
                            eventDates.push _that.find(".#{self.classes.date}[data-day=#{_day}]").data('date')

            addWeeklyEvents: (events, eventDates) ->
                # weekly events
                _firstDay = self.getDayOfWeek eventMonth, 1, eventYear
                _dayShift = if _firstDay is self.daysPerWeek then 0 else _firstDay
                if events.day
                    $.each events.day, (key, value) ->
                        _day = $.inArray value, self.days
                        _length = weeks.length
                        $.each weeks, ->
                            _that = $ @
                            _days = if self.view is 'month'
                                    _that.find ".#{self.classes.date}"
                                else
                                    _that.find ".#{self.classes.date}[data-hour='All Day Event']"

                            _weekLength = _days.length

                            if key is 0 and _length isnt 1
                                if _dayShift <= _day then eventDates.push _that.find(".#{self.classes.date}[data-day=#{_day}]").data('date')
                            else if key is (_length - 1) and _length isnt 1
                                if _day < _weekLength then eventDates.push _that.find(".#{self.classes.date}[data-day=#{_day}]").data('date')
                            else
                                eventDates.push _that.find(".#{self.classes.date}[data-day=#{_day}]").data('date')

                eventDates

            addDailyEvents: (events, eventDates) ->
                _days = if self.view is 'month'
                        calendarInner.find ".#{self.classes.date}"
                    else
                        calendarInner.find ".#{self.classes.date}[data-hour='All Day Event']"

                _days.each ->
                    eventDates.push $(@).data 'date'

            addOneTimeEvents: (events, eventDates) ->
                eventDates.push parseInt(events.eventDate, 10)
                eventDates

        _addCalendarEvent = (events, dates) ->
            # create event html

            if self.view is 'month'
                _calendarItem = calendarInner.find ".drm-date[data-date=#{dates}]"
            else if !events.time?
                _calendarItem = calendarInner.find ".drm-date[data-date=#{dates}][data-hour='All Day Event']"
            else
                # find hour td element
                re = new RegExp '^0?','gi'
                re2 = new RegExp ':[0-9]{2}', 'gi'
                hour = events.time.replace re, ''
                hour = hour.replace re2, ''
                _calendarItem = calendarInner.find ".drm-date[data-date=#{dates}][data-hour=#{hour}]"

            _eventList = _calendarItem.find "ul.#{self.eventClass}"

            _eventContent = 
                if events.time?
                    "<span class='drm-time'>#{events.time}: </span><span class='drm-event'>#{events.name}</span>"
                else
                    "<span class='drm-event drm-all-day-event'>#{events.name}</span>"

            _eventHtml = $ '<a></a>',
                href: '#'
                'data-event': events.id
                html: _eventContent

            if _eventList.length is 0
                _eventList = $ '<ul></ul>',
                    class: "#{self.eventClass}"

                _eventList.appendTo _calendarItem
            
            _item = $ '<li></li>',
                html: _eventHtml
            
            _item.appendTo _eventList

            if events.type is 'holiday' then _eventList.find("a:contains(#{events.name})").addClass self.classes.holiday

        if events.recurrance is 'yearly' and eventMonth is month
            addEvents.addYearlyEvents events, eventDates
        else if events.recurrance is 'monthly'
            addEvents.addMonthlyEvents events, eventDates
        else if events.recurrance is 'biweekly'
            addEvents.addBiWeeklyEvents events, eventDates
        else if events.recurrance is 'weekly'
            addEvents.addWeeklyEvents events, eventDates
        else if events.recurrance is 'daily'
            addEvents.addDailyEvents events, eventDates
        else if events.recurrance is 'none' and eventMonth is month and eventYear is parseInt(events.year, 10)                                         
            addEvents.addOneTimeEvents events, eventDates
        if eventDates.length > 0
            $.each eventDates, (key, date) ->
                # add css classes here
                _addCalendarEvent events, date

    advanceDate: (direction) =>
        _calendarInner = @calendar.find "div.#{@calendarInnerClass}"
        newDate =
            month: _calendarInner.data 'month'
            date: _calendarInner.find(".#{@classes.date}").data 'date'
            year: _calendarInner.data 'year'
        _nextYear = newDate.year + 1
        _lastYear = newDate.year - 1
        _nextMonth = if newDate.month is 11 then 0 else newDate.month + 1
        lastMonth = if newDate.month is 0 then 11 else newDate.month - 1
        
        if direction is 'prev'
            _lastDayOfPrevMonth = @getDaysInMonth lastMonth, newDate.year

            if newDate.date is 1
                newDate.date = _lastDayOfPrevMonth
                newDate.year = if newDate.month is 0 then _lastYear else newDate.year
                newDate.month = lastMonth
            else
                newDate.date = newDate.date - 1

        else if direction is 'next'
            _lastDayOfMonth = @getDaysInMonth newDate.month, newDate.year

            if newDate.date is _lastDayOfMonth
                newDate.date = 1
                newDate.year = if newDate.month is 11 then _nextYear else newDate.year
                newDate.month = _nextMonth
            else
                newDate.date = newDate.date + 1

        if @view is 'date' then @changeCalendar newDate

    advanceWeek: (direction) =>
        _calendarInner = @calendar.find "div.#{@calendarInnerClass}"
        newDate =
            month: _calendarInner.data 'month'
            date: 1
            year: _calendarInner.data 'year'
        _nextYear = newDate.year + 1
        _lastYear = newDate.year - 1
        _nextMonth = if newDate.month is 11 then 0 else newDate.month + 1
        lastMonth = if newDate.month is 0 then 11 else newDate.month - 1
        
        if direction is 'prev'
            _firstDay = _calendarInner.find(".#{@classes.date}").first().data 'date'
            _lastDayOfPrevMonth = @getDaysInMonth lastMonth, newDate.year

            if _firstDay is 1 and @view is 'week'
                newDate.date = _lastDayOfPrevMonth
                newDate.year = if newDate.month is 0 then _lastYear else newDate.year
                newDate.month = lastMonth
            else if _firstDay < 7 and @view is 'week'
                newDate.date = _firstDay - 1
            else if _firstDay is 1 and @view is 'date'
                newDate.date = _lastDayOfPrevMonth - 6 # 30 - 6 1 24
                newDate.year = if newDate.month is 0 then _lastYear else newDate.year
                newDate.month = lastMonth
            else if _firstDay < 7 and @view is 'date'
                newDate.date = _lastDayOfPrevMonth - (7 - _firstDay) # 31 - (7 - 3) = 27 27  28 - (7 - 6) = 27 6 27
                newDate.year = if newDate.month is 0 then _lastYear else newDate.year
                newDate.month = lastMonth
            else
                newDate.date = _firstDay - 7

        else if direction is 'next'
            _lastDay = _calendarInner.find(".#{@classes.date}").last().data 'date'
            _lastDayOfMonth = @getDaysInMonth newDate.month, newDate.year

            if _lastDay is _lastDayOfMonth and @view is 'week'
                newDate.date = 1
                newDate.year = if newDate.month is 11 then _nextYear else newDate.year
                newDate.month = _nextMonth
            else if (_lastDay + 7 > _lastDayOfMonth) and @view is 'week'
                newDate.date = _lastDayOfMonth
            else if (_lastDay + 7 > _lastDayOfMonth) and @view is 'date'
                newDate.date = 7 - (_lastDayOfMonth - _lastDay) # 31 - 29 = 2 then 7 - 2 = 5
                newDate.year = if newDate.month is 11 then _nextYear else newDate.year
                newDate.month = _nextMonth
            else
                newDate.date = _lastDay + 7

        if @view is 'date' or @view is 'week' then @changeCalendar newDate

    advanceMonth: (direction) =>
        self = @
        _calendarInner = @calendar.find "div.#{@calendarInnerClass}"
        newDate =
            month: _calendarInner.data 'month'
            date: if @month is self.today.month then self.today.date else 1
            year: _calendarInner.data 'year'
        
        if direction is 'prev'
            newDate.month = if newDate.month is 0 then 11 else newDate.month - 1
            newDate.year = if newDate.month is 11 then newDate.year - 1 else newDate.year
        else if direction is 'next'
            newDate.month = if newDate.month is 11 then 0 else newDate.month + 1
            newDate.year = if newDate.month is 0 then newDate.year + 1 else newDate.year
        @changeCalendar newDate

    advanceYear: (direction) =>
        self = @
        _calendarInner = @calendar.find "div.#{@calendarInnerClass}"
        newDate =
            month: _calendarInner.data 'month'
            year: _calendarInner.data 'year'

        newDate.date = if newDate.month is self.today.month then self.today.date else 1
        newDate.year = if direction is 'prev' then newDate.year - 1 else newDate.year + 1
        
        @changeCalendar newDate

    changeCalendarView: (view) =>
        self = @
        _calendarInner = @calendar.find "div.#{@calendarInnerClass}"
        newDate =
            month: _calendarInner.data 'month'
            year: _calendarInner.data 'year'

        newDate.date = if newDate.month is self.today.month then self.today.date else 1     

        # update view
        @view = view
        @changeCalendar newDate
        # change calendar class
        @calendarInnerClass = "drm-calendar-#{view}-view"
        return

    changeCalendar: (newDate) =>
        self = @
        _calendarInner = self.calendar.find "div.#{self.calendarInnerClass}"
        _calendarInner.fadeOut(300).queue (next) ->
            _that = $ @
            $.when(_that.remove()).then(self.createCalendar(newDate))
            next()

    createCalendar: (newDate, calendar, events) ->
        self = @
        nextYear = newDate.year + 1
        lastYear = newDate.year - 1
        nextMonth = if newDate.month is 11 then 0 else newDate.month + 1
        lastMonth = if newDate.month is 0 then 11 else newDate.month - 1
        firstDay = self.getDayOfWeek newDate.month, 1, newDate.year
        dayShift = if firstDay is self.daysPerWeek then 0 else firstDay
        numberDays = self.getDaysInMonth newDate.month, newDate.year
        numberWeeks = self.getWeeksInMonth newDate.month, newDate.year
        prevMonthNumberDays = self.getDaysInMonth lastMonth, newDate.year
        weekInfo = self.getDatesInWeek newDate.month, newDate.date, newDate.year
        datesInWeek = weekInfo.datesInWeek
        weekNumber = self.getWeekNumber newDate.month, newDate.date, newDate.year
        weekClass = if weekNumber % 2 is 0 then 'even-week' else 'odd-week'
        day = self.getDayOfWeek newDate.month, newDate.date, newDate.year

        utilities =
            highlightWeekends: ->
                _calendarInner = calendar.find "div.#{self.calendarInnerClass}"
                _weeks = _calendarInner.find '.drm-week'
                weekends = [0, 6]

                $.each _weeks, ->
                    _that = $ @
                    $.each weekends, ->
                        _weekend = _that.find(".#{self.classes.date}[data-day=#{@}]")
                            .not ".#{self.classes.muted}, .#{self.classes.today}, .#{self.classes.holiday}"
                        _weekend.addClass self.classes.weekend

            highlightToday: ->
                _calendarInner = calendar.find "div.#{self.calendarInnerClass}"
                _month = _calendarInner.data 'month'
                _year = _calendarInner.data 'year'

                if _month is newDate.month and _year is newDate.year
                    _calendarInner.find(".drm-date[data-date=#{newDate.date}]").addClass self.classes.today

            addWeekNumbers: ->
                _weeks = calendar.find("div.#{self.calendarInnerClass}").find '.drm-week'

                $.each _weeks, ->
                    _that = $ @
                    _firstDateInWeek = _that.find('.drm-date').first().data 'date'
                    _weekNumber = self.getWeekNumber newDate.month, _firstDateInWeek, newDate.year

                    if _weekNumber % 2 is 0
                        _that.addClass 'even-week'
                    else
                        _that.addClass 'odd-week'

                    _that.attr 'data-week', _weekNumber
            
            getDates: (datesInWeek, key) ->
                dates = {}
                # if its the first week of the month
                if datesInWeek.length < self.daysPerWeek and datesInWeek[0] is 1
                    if key is firstDay
                        dates.date = 1
                        dates.month = newDate.month
                    else if key > firstDay
                        dates.date = (key - firstDay) + 1
                        dates.month = newDate.month
                    else
                        dates.date = prevMonthNumberDays - (firstDay - (key + 1))
                        dates.month = lastMonth
                else if datesInWeek.length is self.daysPerWeek
                    dates.date = datesInWeek[key]
                    dates.month = newDate.month
                # if its the last week of the month
                else if datesInWeek.length < self.daysPerWeek and datesInWeek[0] isnt 1
                    if key < datesInWeek.length
                        dates.date = datesInWeek[key]
                        dates.month = newDate.month
                    else
                        dates.date = Math.abs (datesInWeek.length - (key + 1))
                        dates.month = nextMonth
                dates

        views =
            createMonth: (newDate) ->
                _newDate = {month: newDate.month, date: newDate.date, year: newDate.year}
                createWeekdays = ->
                    weekdays = "<div class='#{self.calendarInnerClass}' data-month='#{_newDate.month}' data-year='#{_newDate.year}'><table><thead><tr>"
                    $.each self.days, ->
                        weekdays += "<th>#{@}</th>"
                    weekdays += '</tr></thead>'

                    return weekdays
                createFirstWeek = ->
                    # add cells for the previous month until we get to the first day
                    _lastMonthDays = 1
                    _prevDays = (prevMonthNumberDays - dayShift) + 1
                    firstWeekHtml = ''
                    
                    $.each self.days, (key) ->
                        if _lastMonthDays <= dayShift
                            firstWeekHtml += "<td class='#{self.classes.muted}' data-day='#{key}'>#{_prevDays}</td>"
                            _prevDays += 1
                            _lastMonthDays += 1
                        else                    
                        # start adding cells for the current month
                            firstWeekHtml += "<td class='#{self.classes.date}' data-month='#{_newDate.month}' data-date='#{_newDate.date}' 
                                data-year='#{_newDate.year}' data-day='#{key}'>#{_newDate.date}</td>"
                            _newDate.date += 1

                    return firstWeekHtml

                createLastWeek = ->
                    _nextDates = 1
                    lastWeekHtml = ''
                    $.each self.days, (key) ->
                        # finish adding cells for the current month
                        if _newDate.date <= numberDays
                            lastWeekHtml += "<td class='#{self.classes.date}' data-month='#{_newDate.month}' data-date='#{_newDate.date}' 
                                data-year='#{_newDate.year}' data-day='#{key}'>#{_newDate.date}</td>"
                        # start adding cells for next month
                        else
                            lastWeekHtml += "<td class='#{self.classes.muted}' data-day='#{key}'>#{_nextDates}</td>"
                            _nextDates += 1
                        _newDate.date += 1

                    return lastWeekHtml

                createMiddleWeeks = ->
                    middleWeeksHtml = ''
                    $.each self.days, (key) ->
                        middleWeeksHtml += "<td class='#{self.classes.date}' data-month='#{_newDate.month}' data-date='#{_newDate.date}' 
                            data-year='#{_newDate.year}' data-day='#{key}'>#{_newDate.date}</td>"
                        _newDate.date += 1

                    return middleWeeksHtml

                createWeeks = ->
                    weekCount = 1
                    _newDate.date = 1
                    weeks = "<tbody class='#{self.classes.month}'>"
                    
                    while weekCount <= numberWeeks
                        weeks += "<tr class='#{self.classes.week}'>"
                        # if we are in week 1 we need to shift to the correct day of the week
                        if weekCount is 1 and firstDay isnt 0
                            weeks += createFirstWeek()
                        # if we are in the last week of the month we need to add blank cells for next month
                        else if weekCount is numberWeeks
                            weeks += createLastWeek()
                        else
                            # if we are in the middle of the month add cells for the current month
                            weeks += createMiddleWeeks()
                        weeks += '</tr>'
                        weekCount += 1
                    
                    weeks += '</tbody></table></div>'

                    return weeks

                createCalendarHtml = ->
                    # create html
                    return createWeekdays() + createWeeks()

                # add to DOM
                addCalendar = (calendar) ->
                    _calendarHtml = createCalendarHtml()

                    _heading = $ '<h1></h1>',
                        class: 'drm-calendar-header'
                        text: "#{self.months[newDate.month]} #{newDate.year}"
                    
                    calendar.append _calendarHtml
                    _calenderInner = calendar.find ".#{self.calendarInnerClass}"
                    _heading.prependTo _calenderInner

                    # style weeks
                    utilities.highlightToday()
                    utilities.highlightWeekends()
                    utilities.addWeekNumbers()

                    # add events to calendar
                    $.each events, ->
                        self.addEventsToCalendar @, calendar

                    # add and remove navigation buttons
                    # $('.drm-calendar-year-prev').text lastYear
                    # $('.drm-calendar-year-next').text nextYear

                    # $('.drm-calendar-month-prev').text self.months[lastMonth]
                    # $('.drm-calendar-month-next').text self.months[nextMonth]

                    # $('.drm-calendar-week-prev, .drm-calendar-week-next').hide()
                    # $('.drm-calendar-date-prev, .drm-calendar-date-next').hide()

                addCalendar calendar

            createWeek: (newDate) ->
                weekdaysHtml = "<thead><tr><th></th>"
                $.each self.days, (key, value) ->
                    _dates = utilities.getDates datesInWeek, key
                    weekdaysHtml += "<th>#{value}<br>#{self.months[_dates.month]} #{_dates.date}</th>"
                weekdaysHtml += '</tr></thead>'

                weekHtml = "<tbody class='#{self.classes.week} #{weekClass}' data-week='#{weekNumber}'>"
                $.each self.hours, ->
                    _hour = @name

                    weekHtml += "<tr><td><span class='hour'>#{_hour}</span></td>"
                    $.each self.days, (key) ->
                        dates = utilities.getDates datesInWeek, key
                        weekHtml += "<td class='#{self.classes.date}' data-month='#{dates.month}' data-date='#{dates.date}' 
                            data-year='#{newDate.year}' data-day='#{key}' data-hour='#{_hour}'></td>"
                    weekHtml += '</tr>'

                weekHtml += '</tbody>'

                _weekView = $ '<table></table>',
                    html: weekdaysHtml + weekHtml

                _calendar = $ '<div></div>',
                    class: self.calendarInnerClass
                    html: _weekView
                    'data-month': newDate.month
                    'data-year': newDate.year

                _weekDates = if datesInWeek.length > 1
                        "#{datesInWeek[0]} - #{datesInWeek[datesInWeek.length - 1]}"
                    else 
                        "#{datesInWeek[0]}"

                _heading = $ '<h1></h1>',
                    class: 'drm-calendar-header'
                    text: "#{self.months[newDate.month]} #{_weekDates}: Week #{weekNumber} of #{newDate.year}"
                
                _calendar.appendTo ".#{self.calendarClass}"
                _heading.prependTo "div.#{self.calendarInnerClass}"

                $("div.#{self.calendarInnerClass}")
                    .find "tbody td[data-month=#{lastMonth}]"
                    .addClass self.classes.muted
                    .removeClass 'drm-date'
                
                $("div.#{self.calendarInnerClass}")
                    .find "tbody td[data-month=#{nextMonth}]"
                    .addClass self.classes.muted
                    .removeClass 'drm-date'

                utilities.highlightToday()
                utilities.highlightWeekends()

                $.each self.events, ->
                    self.addEventsToCalendar @

                $('.drm-calendar-year-prev').text lastYear
                $('.drm-calendar-year-next').text nextYear

                $('.drm-calendar-month-prev').text self.months[lastMonth]
                $('.drm-calendar-month-next').text self.months[nextMonth]

                $('.drm-calendar-week-prev, .drm-calendar-week-next').show()
                $('.drm-calendar-date-prev, .drm-calendar-date-next').hide()

            createDate: (newDate) ->
                dayListHtml = "<ul class='drm-week drm-day #{weekClass}' data-week='#{weekNumber}'>"
                $.each self.hours, ->
                    _hour = @name
                    dayListHtml += "<li class='#{self.classes.date}' data-month='#{newDate.month}' data-date='#{newDate.date}' 
                        data-year='#{newDate.year}' data-day='#{day}' data-hour='#{_hour}'><span class='hour'>#{_hour}</span></li>"
                dayListHtml += '</ul>'

                _calendar = $ '<div></div>',
                    class: self.calendarInnerClass
                    'data-month': newDate.month
                    'data-year': newDate.year
                    html: dayListHtml

                _headingText = 
                    if newDate.month is self.today.month and newDate is self.today.date and newDate.year is self.today.year
                        "Today, #{self.days[day]}, #{self.months[newDate.month]} #{newDate.date} #{newDate.year}"
                    else
                        "#{self.days[day]}, #{self.months[newDate.month]} #{newDate.date} #{newDate.year}"

                _heading = $ '<h1></h1>',
                    class: 'drm-calendar-header'
                    text: _headingText
                
                _calendar.appendTo ".#{self.calendarClass}"
                _heading.prependTo ".#{self.calendarInnerClass}"

                $.each self.events, ->
                    self.addEventsToCalendar @

                $('.drm-calendar-year-prev').text lastYear
                $('.drm-calendar-year-next').text nextYear

                $('.drm-calendar-month-prev').text self.months[lastMonth]
                $('.drm-calendar-month-next').text self.months[nextMonth]

                $('.drm-calendar-week-prev, .drm-calendar-week-next').show()
                $('.drm-calendar-date-prev, .drm-calendar-date-next').show()

        switch self.view
            when 'month' then views.createMonth newDate
            when 'week' then views.createWeek newDate
            when 'date' then views.createDate newDate