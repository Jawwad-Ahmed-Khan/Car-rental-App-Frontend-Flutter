import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarInitial()) {
    on<InitializeCalendar>(_onInitialize);
    on<UpdateStartTime>(_onUpdateStartTime);
    on<UpdateEndTime>(_onUpdateEndTime);
    on<PreviousMonth>(_onPreviousMonth);
    on<NextMonth>(_onNextMonth);
    on<SelectDate>(_onSelectDate);
    on<ConfirmSelection>(_onConfirmSelection);
    on<CancelSelection>(_onCancelSelection);
  }

  void _onInitialize(InitializeCalendar event, Emitter<CalendarState> emit) {
    final now = DateTime.now();
    final startTime =
        event.initialStartDate ??
        DateTime(now.year, now.month, now.day, 10, 30);
    final endTime =
        event.initialEndDate ?? DateTime(now.year, now.month, now.day, 17, 30);

    emit(
      CalendarLoaded(
        displayMonth: DateTime(startTime.year, startTime.month, 1),
        startTime: startTime,
        endTime: endTime,
        rangeStart: event.initialStartDate,
        rangeEnd: event.initialEndDate,
        isSelectingEndDate: event.isSelectingEndDate,
      ),
    );
  }

  void _onUpdateStartTime(UpdateStartTime event, Emitter<CalendarState> emit) {
    if (state is CalendarLoaded) {
      final current = state as CalendarLoaded;
      final hour = event.isAm
          ? event.hour
          : (event.hour == 12 ? 12 : event.hour + 12);
      final adjustedHour = event.isAm && event.hour == 12 ? 0 : hour;

      emit(
        current.copyWith(
          startTime: DateTime(
            current.startTime.year,
            current.startTime.month,
            current.startTime.day,
            adjustedHour,
            event.minute,
          ),
        ),
      );
    }
  }

  void _onUpdateEndTime(UpdateEndTime event, Emitter<CalendarState> emit) {
    if (state is CalendarLoaded) {
      final current = state as CalendarLoaded;
      final hour = event.isAm
          ? event.hour
          : (event.hour == 12 ? 12 : event.hour + 12);
      final adjustedHour = event.isAm && event.hour == 12 ? 0 : hour;

      emit(
        current.copyWith(
          endTime: DateTime(
            current.endTime.year,
            current.endTime.month,
            current.endTime.day,
            adjustedHour,
            event.minute,
          ),
        ),
      );
    }
  }

  void _onPreviousMonth(PreviousMonth event, Emitter<CalendarState> emit) {
    if (state is CalendarLoaded) {
      final current = state as CalendarLoaded;
      final prevMonth = DateTime(
        current.displayMonth.year,
        current.displayMonth.month - 1,
        1,
      );
      emit(current.copyWith(displayMonth: prevMonth));
    }
  }

  void _onNextMonth(NextMonth event, Emitter<CalendarState> emit) {
    if (state is CalendarLoaded) {
      final current = state as CalendarLoaded;
      final nextMonth = DateTime(
        current.displayMonth.year,
        current.displayMonth.month + 1,
        1,
      );
      emit(current.copyWith(displayMonth: nextMonth));
    }
  }

  void _onSelectDate(SelectDate event, Emitter<CalendarState> emit) {
    if (state is CalendarLoaded) {
      final current = state as CalendarLoaded;

      // If no range start, set it
      if (current.rangeStart == null) {
        emit(
          current.copyWith(rangeStart: event.date, isSelectingEndDate: true),
        );
      }
      // If selecting end date
      else if (current.isSelectingEndDate) {
        // If selected date is before start, reset and start over
        if (event.date.isBefore(current.rangeStart!)) {
          emit(
            current.copyWith(
              rangeStart: event.date,
              rangeEnd: null,
              isSelectingEndDate: true,
            ),
          );
        } else {
          emit(
            current.copyWith(rangeEnd: event.date, isSelectingEndDate: false),
          );
        }
      }
      // If already have range, start new selection
      else {
        emit(
          current.copyWith(
            rangeStart: event.date,
            clearRange: true,
            isSelectingEndDate: true,
          ),
        );
      }
    }
  }

  void _onConfirmSelection(
    ConfirmSelection event,
    Emitter<CalendarState> emit,
  ) {
    if (state is CalendarLoaded) {
      final current = state as CalendarLoaded;
      emit(CalendarConfirmed(current.bookingTime));
    }
  }

  void _onCancelSelection(CancelSelection event, Emitter<CalendarState> emit) {
    emit(const CalendarCancelled());
  }
}
