import elrUtlities from './elr-utilities';
import elrTimeUtlities from './elr-time-utilities';
import elrCalendarCreate from './elr-calendar-create';
import elrCalendarActions from './elr-calendar-actions';
const $ = require('jquery');

let elr = elrUtlities();
let elrTime = elrTimeUtlities();
let elrCreate = elrCalendarCreate();
let elrActions = elrCalendarActions();

const elrCalendar = function({
    calendarClass = 'elr-calendar',
    view = 'month',
    addHolidays = true,
    currentDate = elrTime.today(),
    newEvents = []
} = {}) {
    // let self = {};
    let $calendar = $(`.${calendarClass}`);

    if ($calendar.length) {
        let $body = $('body');
        let evtClass = 'elr-events';
        let classes = {
            'weekend': 'elr-cal-weekend',
            'muted': 'elr-cal-muted',
            'holiday': 'elr-cal-holiday',
            'today': 'elr-cal-today',
            'month': 'elr-month',
            'week': 'elr-week',
            'date': 'elr-date'
        };

        $calendar.each(function() {
            let $cal = $(this);
            let $calendarNav = $cal.find('.elr-calendar-nav');
            let $calendarSelect = $cal.find('.elr-calendar-select');
            let $calendarSelectButton = $calendarSelect.find('button[type=submit]');
            let $addEventForm = $cal.find('form.elr-calendar-new-evt').hide();
            let $showEventFormButton = $cal.find('button.elr-show-evt-form');
            let $calendarViewActiveButton = $cal.find(`.elr-calendar-view-nav button[data-view=${view}]`).addClass('active');
            let evts = elrTime.holidays;

            elrCreate.buildCalendar(view, currentDate, $calendar, evts);

            $cal.on('click', '.elr-calendar-year-prev, .elr-calendar-year-next', function() {
                let dir = $(this).data('dir');

                elrActions.advanceYear(dir, evts, $cal);
            });

            $cal.on('click', '.elr-calendar-month-prev, .elr-calendar-month-next', function() {
                let dir = $(this).data('dir');

                elrActions.advanceMonth(dir, evts, $cal);
            });

            $cal.on('click', '.elr-calendar-current', function() {
                elrCreate.changeCalendar(view, elrTime.today(), $cal, evts);
            });

            $cal.on('click', 'button.elr-calendar-view', function() {
                let $calendarInner = $cal.find('.calendar-inner');
                let dateObj = {
                    'month': $calendarInner.data('month'),
                    'date': $calendarInner.find(`.${classes.date}`).first().data('date'),
                    'year': $calendarInner.data('year')
                };

                $('button.elr-calendar-view.active').removeClass('active');
                $(this).addClass('active');

                elrCreate.changeCalendar($(this).data('view'), dateObj, $cal, evts);
            })
        });
    }

    // return self;
};

export default elrCalendar;