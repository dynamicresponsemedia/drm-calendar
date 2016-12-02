import elrUtlities from './elr-utilities';
import elrTimeUtlities from './elr-time-utilities';
import elrCalendarEvents from './elr-calendar-events';
const $ = require('jquery');

let elr = elrUtlities();
let elrTime = elrTimeUtlities();
let elrEvents = elrCalendarEvents();

const elrCalendarWeeks = function() {
    let classes = {
        'weekend': 'elr-cal-weekend',
        'muted': 'elr-cal-muted',
        'holiday': 'elr-cal-holiday',
        'today': 'elr-cal-today',
        'month': 'elr-month',
        'week': 'elr-week',
        'date': 'elr-date'
    };

    let createWeekdayHtml = function(datesInWeek, weekNum) {
        let weekdayHtml = `<thead><tr><th></th>`;

        $.each(datesInWeek.datesInWeek, function(k) {
            let day = elrTime.days[elrTime.getDayOfWeek(this)];
            weekdayHtml += `<th>${day}<br>${(this.month + 1)} / ${this.date}</th>`;
        });

        weekdayHtml += `</tr></thead>`;

        return weekdayHtml;
    };

    let createWeekHtml = function(datesInWeek, weekNum) {
        let weekClass = (weekNum % 2 === 0) ? 'even-week' : 'odd-week';
        let weekHtml = `<tbody class="${classes.week} ${weekClass}" data-week="${weekNum}">`;

        $.each(elrTime.hours, function() {
            // need to account for first and last weeks of the month
            let hour = this.name;

            weekHtml += `<tr><td><span class="hour">${hour}</span></td>`;

            $.each(datesInWeek.datesInWeek, function(k) {
                weekHtml += `<td `;
                weekHtml += `class="${classes.date}"`;
                weekHtml += ` data-month="${(this.month + 1)}"`;
                weekHtml += ` data-date="${this.date}"`;
                weekHtml += ` data-year="${this.year}"`;
                weekHtml += ` data-day="${k}"`;
                weekHtml += ` data-hour="${hour}"`;
                weekHtml += `></td>`;
            });

            weekHtml += '</tr>';
        });

        weekHtml += '</tbody>';

        return weekHtml;
    };

    let createWeekHeading = function(dateObj, datesInWeek, weekNum) {
        let month = elrTime.months[dateObj.month];
        let startDate = {
            month: elrTime.months[datesInWeek.datesInWeek[0].month],
            date: datesInWeek.datesInWeek[0].date
        };
        let endDate = {
            month: elrTime.months[datesInWeek.datesInWeek[datesInWeek.datesInWeek.length - 1].month],
            date: datesInWeek.datesInWeek[datesInWeek.datesInWeek.length - 1].date
        };
        let year = dateObj.year;
        let text = `${startDate.month} ${startDate.date} - ${endDate.month} ${endDate.date}: Week ${weekNum} of ${year}`;

        let $heading = elr.createElement('h1', {
            'class': 'elr-calendar-header',
            'text': text
        });

        return $heading;
    };

    let self = {
        renderWeek: function(dateObj, $cal, evts) {
            let weekNum = elrTime.getWeekNumber(dateObj);
            let lastYear = elrTime.getPrevYear(dateObj);
            let nextYear = elrTime.getNextYear(dateObj);
            let lastMonth = elrTime.getPrevMonth(dateObj);
            let nextMonth = elrTime.getNextMonth(dateObj);
            let datesInWeek = elrTime.getDatesInWeek(dateObj);
            let $heading = createWeekHeading(dateObj, datesInWeek, weekNum);
            let weekdayHtml = createWeekdayHtml(datesInWeek, weekNum);
            let weekHtml = createWeekHtml(datesInWeek, weekNum);

            let weekView = elr.createElement('table', {
                'html': weekdayHtml + weekHtml
            });

            let calendarHtml = elr.createElement('div', {
                'class': 'calendar-inner calendar-week-view',
                'data-month': dateObj.month,
                'data-year': dateObj.year,
                'html': weekView
            });

            $cal.append(calendarHtml);

            $heading.prependTo($cal.find(`.calendar-week-view`));

            // add and remove navigation buttons
            $('.elr-calendar-year-prev').text(lastYear).hide();
            $('.elr-calendar-year-next').text(nextYear).hide();

            $('.elr-calendar-month-prev').text(elrTime.months[lastMonth]).hide();
            $('.elr-calendar-month-next').text(elrTime.months[nextMonth]).hide();

            $('.elr-calendar-week-prev, .elr-calendar-week-next').hide();
            $('.elr-calendar-date-prev, .elr-calendar-date-next').hide();

            $('.elr-calendar-current').hide();
        }
    };

    return self;
};

export default elrCalendarWeeks;