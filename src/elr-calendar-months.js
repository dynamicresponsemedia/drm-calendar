import elrUtlities from './elr-utilities';
import elrTimeUtlities from './elr-time-utilities';
import elrCalendarEvents from './elr-calendar-events';
const $ = require('jquery');

let elr = elrUtlities();
let elrTime = elrTimeUtlities();
let elrEvents = elrCalendarEvents();

const elrCalendarMonths = function({
    view = 'month'
} = {}) {
    let calendarInnerClass = `elr-calendar-${view}-view`;
    let classes = {
        'weekend': 'elr-cal-weekend',
        'muted': 'elr-cal-muted',
        'holiday': 'elr-cal-holiday',
        'today': 'elr-cal-today',
        'month': 'elr-month',
        'week': 'elr-week',
        'date': 'elr-date'
    };

    let highlightWeekends = function($cal) {
        let $calendarInner = $cal.find(`.${calendarInnerClass}`);
        let $weeks = $calendarInner.find('.elr-week');
        let weekends = [0, 6];

        $.each($weeks, function() {
            let $that = $(this);
            let weekend;

            $.each(weekends, function() {
                weekend = $that.find(`.${classes.date}[data-day=${this}]`)
                    .not(`.${classes.muted}`, `.${classes.today}`, `.${classes.holiday}`);

                weekend.addClass(classes.weekend);
            });
        });
    };

    let highlightToday = function($cal, renderDate) {
        let $calendarInner = $cal.find(`.${calendarInnerClass}`);
        let month = $calendarInner.data('month');
        let year = $calendarInner.data('year');

        if (month === parseInt(renderDate.month, 10) && year === parseInt(renderDate.year, 10)) {
            $calendarInner.find(`.elr-date[data-date=${renderDate.date}]`).addClass(classes.today);
        }

        return;
    };

    let addWeekNumbers = function($cal, renderDate) {
        let weeks = $cal.find(`.${calendarInnerClass}`).find('.elr-week');

        $.each(weeks, function() {
            let $that = $(this);
            let firstDateInWeek = $that.find('.elr-date').first().data('date');
            let dateObj = {
                'month': renderDate.month,
                'date': firstDateInWeek,
                'year': renderDate.year
            };

            let weekNumber = elrTime.getWeekNumber(dateObj);

            if (weekNumber === 53) {
                $that.addClass('even-week');
            } else if (weekNumber % 2 === 0) {
                $that.addClass('even-week');
            } else {
                $that.addClass('odd-week');
            }

            $that.attr('data-week', weekNumber);
        });
    };

    let createWeekdays = function(renderDate) {
        let weekdays = '<table><thead><tr>';

        $.each(elrTime.days, function() {
            weekdays += `<th>${this}</th>`;
        });

        weekdays += '</tr></thead>';

        return weekdays;
    };

    let createFirstWeek = function(renderDate, firstDay) {
        let lastMonthDays = 1;
        let prevMonthNumberDays = elrTime.getDaysInMonth({
            'month': elrTime.getPrevMonth(renderDate),
            'date': 0,
            'year': renderDate.year
        });

        let dayShift = (firstDay === elrTime.daysPerWeek) ? 0 : firstDay;
        let prevDays = (prevMonthNumberDays - dayShift) + 1;
        let firstWeekHtml = '';

        $.each(elrTime.days, function(k) {
            if (lastMonthDays <= dayShift) {
                firstWeekHtml += `<td class='${classes.muted}' data-day='${k}'>${prevDays}</td>`;
                prevDays += 1;
                lastMonthDays += 1;
            } else {
                firstWeekHtml += `<td class='${classes.date}' data-month='${renderDate.month}' data-date='${renderDate.date}' data-year='${renderDate.year}' data-day='${k}'>${renderDate.date}</td>`;

                renderDate.date += 1;
            }
        });

        return firstWeekHtml;
    };

    let createLastWeek = function(renderDate) {
        let nextDates = 1;
        let lastWeekHtml = '';
        let numberDays = elrTime.getDaysInMonth(renderDate);

        $.each(elrTime.days, function(k) {
            // finish adding cells for the current month
            if (renderDate.date <= numberDays) {
                lastWeekHtml += `<td class=${classes.date} data-month=${renderDate.month} data-date=${renderDate.date} data-year=${renderDate.year} data-day=${k}>${renderDate.date}</td>`;
            // start adding cells for next month
            } else {
                lastWeekHtml += `<td class=${classes.muted} data-day=${k}>${nextDates}</td>`;
                nextDates += 1;
            }

            renderDate.date += 1;
        });

        return lastWeekHtml;
    };

    let createMiddleWeeks = function(renderDate) {
        let middleWeeksHtml = '';

        $.each(elrTime.days, function(k) {
            middleWeeksHtml += `<td class=${classes.date} data-month=${renderDate.month} data-date=${renderDate.date} data-year=${renderDate.year} data-day=${k}>${renderDate.date}</td>`;
            renderDate.date += 1;
        });

        return middleWeeksHtml;
    };

    let createWeeks = function(renderDate) {
        let tempDate = {
            'month': renderDate.month,
            'date': 1,
            'year': renderDate.year
        };

        let weekCount = 1;
        let weeks = `<tbody class="${classes.month}">`;
        let numberWeeks = elrTime.getWeeksInMonth(tempDate);
        let firstDay = elrTime.getFirstDayOfMonth(tempDate);

        while (weekCount <= numberWeeks) {
            weeks += '<tr class="' + classes.week + '">';

            // if we are in week 1 we need to shift to the correct day of the week
            if (weekCount === 1 && (firstDay !== 0)) {
                weeks += createFirstWeek(tempDate, firstDay);
            } else if (weekCount === numberWeeks) {
                // if we are in the last week of the month we need to add blank cells for next month
                weeks += createLastWeek(tempDate);
            } else {
                // if we are in the middle of the month add cells for the current month
                weeks += createMiddleWeeks(tempDate);
            }

            weeks += `</tr>`;
            weekCount += 1;
        }

        weeks += `</tbody></table>`;

        return weeks;
    };

    let createMonth = function(renderDate) {
        let html = createWeekdays(renderDate) + createWeeks(renderDate);

        return elr.createElement('div', {
            'class': `calendar-inner ${calendarInnerClass}`,
            'data-month': renderDate.month,
            'data-year': renderDate.year,
            'html': html
        });
    };

    let createHeading = function(renderDate) {
        return elr.createElement('h1', {
            'class': 'elr-calendar-header',
            'text': `${elrTime.months[renderDate.month]}' '${renderDate.year}`
        });
    };

    let self = {
        renderMonth: (newDate, $cal, evts) => {
            let renderDate = {
                'month': newDate.month,
                'date': newDate.date,
                'year': newDate.year
            };

            let lastYear = elrTime.getPrevYear(renderDate);
            let nextYear = elrTime.getNextYear(renderDate);
            let lastMonth = elrTime.getPrevMonth(renderDate);
            let nextMonth = elrTime.getNextMonth(renderDate);

            let $monthHtml = createMonth(renderDate);
            let $heading = createHeading(renderDate);

            $cal.append($monthHtml);

            $heading.prependTo($cal.find(`.${calendarInnerClass}`));

            highlightWeekends($cal);
            highlightToday($cal, renderDate);
            addWeekNumbers($cal, renderDate);

            elr.each(evts, function() {
                elrEvents.addEvents(this, $cal);
            });

            // add and remove navigation buttons
            $('.elr-calendar-year-prev').text(lastYear);
            $('.elr-calendar-year-next').text(nextYear);

            $('.elr-calendar-month-prev').text(elrTime.months[lastMonth]);
            $('.elr-calendar-month-next').text(elrTime.months[nextMonth]);

            $('.elr-calendar-week-prev, .elr-calendar-week-next').hide();
            $('.elr-calendar-date-prev, .elr-calendar-date-next').hide();
        }
    };

    return self;
};

export default elrCalendarMonths;