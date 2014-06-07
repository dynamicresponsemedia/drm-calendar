# DRM Calendar

A jQuery calendar

## Features

+ Add static and recurring events
+ month, week, day, and single event views

## Usage

At the moment only US style dates and times are used

### Initialize:

    new DrmCalendar(calendarClass = 'drm-calendar', @view = 'month', @addHolidays = yes);

#### Options:

+ calendarClass: classname of the calendar holder - default: drm-calendar
+ view:first view when the calendar loads - default: month
    * month
    * week
    * date
+ addHolidays:add holidays to calendar (US only for now) - default: yes

### Add events dynamically using the createEvent method
createEvent takes an object as its only argument

    drmCalendar = new DrmCalendar();
    drmCalendar.createEvent(newEvent);

#### Options:

+ id: the event id number (DrmCalendar will add this for you - don't add this yourself)
+ name: name of your event
+ recurrance: how often the event will occur
    * yearly: once per year
    * monthly: once per month
    * biweekly: every other week
    * weekly: once per week
    * daily: every single day
    * none: exactly once
+ month: month of your event - full name of month not abbreviations or month number
+ year: year of your event - for non-recurring events only
+ eventDate: date of event
+ time: time of event ex. 2:30pm - omit for all day events
+ day: day of the week - array of days of the week - full name of day not abbreviations or day number - can be an array ex. ['Saturday', 'Sunday']
+ dayNum: day number - ex. 1 for first occurance of day in month - use 'last' for the last occurance in the month
+ type: event type - so far holiday is the only type that has any effect
+ notes: event notes - show up in the event view

#### Examples:

##### Yearly Event:

    drmCalendar.createEvent({
        name: 'Thanksgiving',
        month: 'November',
        dayNum: 'last',
        day: ['Thursday'],
        type: 'holiday',
        recurrance: 'yearly',
        notes: 'Thanksgiving occurs on the last Thursday in November'
    });

##### Monthly Event:

    drmCalendar.createEvent({
        name: 'Rabbit Rabbit Day',
        eventDate: 1,
        type: 'fun day',
        recurrance: 'monthly',
        notes: 'Say Rabbit Rabbit for good luck this month'
    });

##### Weekly Event:

    drmCalendar.createEvent({
        name: 'Sleep In!',
        day: ['Sunday', 'Saturday']
        time: '9:00am'
        recurrance: 'weekly',
        notes: 'Thanksgiving occurs on the last Thursday in November'
    });

##### Daily Event:

    drmCalendar.createEvent({
        name: 'Eat Lunch',
        time: '12:00pm'
        recurrance: 'daily',
        notes: 'Eat a healthy lunch'
    });
