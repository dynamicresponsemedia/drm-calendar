import elrUtlities from './elr-utilities';
import elrTimeUtlities from './elr-time-utilities';
import elrCalendarEvents from './elr-calendar-events';
import elrCalendarMonths from './elr-calendar-months';
import elrCalendarWeeks from './elr-calendar-weeks';
const $ = require('jquery');

let elr = elrUtlities();
let elrTime = elrTimeUtlities();
let elrEvents = elrCalendarEvents();
let elrMonths = elrCalendarMonths();
let elrWeeks = elrCalendarWeeks();

const elrCalendarCreate = function({
    view = 'month'
} = {}) {
    let self = {
        renderDate: (dateObj, $cal, evts) => {
            // create date view
        },
        changeCalendar: (view, dateObj, $cal, evts) => {
            $cal.find('.calendar-inner').fadeOut(300).queue(function(next) {
                $.when($(this).remove()).then(self.buildCalendar(view, dateObj, $cal, evts));
                next();
            });
        },
        buildCalendar: (view, dateObj, $cal, evts) => {
            if (view === 'month') {
                elrMonths.renderMonth(dateObj, $cal, evts);
            } else if (view === 'week') {
                elrWeeks.renderWeek(dateObj, $cal, evts);
            } else {
                return;
                // self.renderDate(dateObj, $cal, evts);
            }
        }
    };

    return self;
};

export default elrCalendarCreate;