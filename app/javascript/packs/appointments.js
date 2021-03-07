import $ from 'jquery';

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin, { Draggable } from '@fullcalendar/interaction';
import listPlugin from '@fullcalendar/list';
import bootstrapPlugin from '@fullcalendar/bootstrap';

import swal from 'sweetalert';

let calendar;

const defaultHours = '00';
const defaultMinutes = '30';

$(function() {
  let calendarEl = document.getElementById('calendar');
  calendar = new Calendar(calendarEl, {
      events: function(info, successCallback, failureCallback) {
        $.ajax({
            type: 'GET',
            url: 'appointments.json',
            dataType: 'json',
            success: function (data) {
              successCallback(data.map(function(obj) {
                if(obj.start)
                  obj.start = new Date(obj.start);
                if(obj.end)
                  obj.end = new Date(obj.end);
                if(obj.fixed)
                  obj.rendering = 'background';
                return obj;
              }));
            },
            error: function (request, error, status) {
              failureCallback(status);
            }
        });
      },
      eventClick: function(info) {
        if(info.event.rendering !== 'background') { // Here there should be, ad example, a check on customer.
          swal({
            title: 'Are you sure?',
            text: 'Your will not be able to recover this appointment!',
            icon: 'warning',
            buttons: {
              cancel: true,
              confirm: {
                text: 'Yes, delete it!',
                value: true,
                visible: true,
                className: "bg-danger",
                closeModal: true
              }
            }
          }).then((isConfirm) => {
            if (isConfirm) {
              if(info.event.id) {
                $.ajax({
                    type: 'DELETE',
                    url: 'appointments/' + info.event.id + '.json',
                    dataType: 'json',
                    success: function (data) {
                      removeEvent(info.event);
                    },
                    error: function (request, error, status) {
                      swal('Error!', status, error);
                    }
                });
              }
              else {
                removeEvent(info.event);
              }
            } else {
              swal('Cancelled', 'Your appointment is safe :)', 'error');
            }
          });
        }
      },
      plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin, bootstrapPlugin],
      themeSystem: 'bootstrap',
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'timeGridWeek,timeGridDay,listWeek'
      },
      defaultView: 'timeGridWeek',
      defaultTimedEventDuration: defaultHours + ':' + defaultMinutes,
      editable: true,
      droppable: true, // this allows things to be dropped onto the calendar
      eventReceive: function(info) {
          let styles = getComputedStyle(info.draggedEl);
          info.event.setProp('backgroundColor', styles.backgroundColor);
          info.event.setProp('borderColor', styles.borderColor);

          saveEvent(info.event, 'POST', null);
      },
      eventResize: function(info) {
        saveEvent(info.event, 'PATCH', info.prevEvent);
      },
      eventDrop: function(info) {
        saveEvent(info.event, 'PATCH', info.oldEvent);
      },
      eventOverlap: function(stillEvent, movingEvent) {
        return ((new URLSearchParams(window.location.search)).get('overlap') === 'false');
      }
  });

  /* initialize the external events */
  var containerEl = document.getElementById('external-events-list');
  new Draggable(containerEl, {
    itemSelector: '.fce-event',
    eventData: function(eventEl) {
        return {
            title: eventEl.innerText.trim()
        };
    }
  });

  calendar.render();
});

function saveEvent(event, method, oldEvent) {
  const startEpoch = (new Date(event.start)).getTime();
  const endEpoch = (new Date(event.end)).getTime();

  let eventObj = {
    title: event.title,
    start: startEpoch,
    end: (endEpoch > startEpoch ? endEpoch : getEndTimeFromStart(startEpoch)),
    allDay: event.allDay,
    backgroundColor: event.backgroundColor,
    borderColor: event.borderColor
  };

  $.ajax({
      type: method,
      url: 'appointments' + (event.id ? "/" + event.id : '') + '.json',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify(eventObj),
      success: function (data) {
        eventObj.id = data.id;
        calendar.addEvent(eventObj);
        event.remove();
        swal('Success!', 'Your appointment has been set.', 'success');
      },
      error: function (request, error, status) {
        event.remove();
        if(oldEvent != null)
          calendar.addEvent(oldEvent);
        swal('Error!', "This timeslot is not available!", error);
      }
  });

}

function removeEvent(event) {
  event.remove();
  swal('Deleted!', 'Your appointment has been deleted.', 'success');
}

function getEndTimeFromStart(start) {
  return start + (Number(defaultHours) * 60 + Number(defaultMinutes)) * 60 * 1000;
}
