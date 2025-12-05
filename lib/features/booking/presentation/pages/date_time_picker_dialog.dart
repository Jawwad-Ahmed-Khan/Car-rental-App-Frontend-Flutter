import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/booking_time.dart';
import '../bloc/calendar_bloc.dart';
import '../bloc/calendar_event.dart';
import '../bloc/calendar_state.dart';
import '../widgets/time_selector.dart';
import '../widgets/month_navigation.dart';
import '../widgets/calendar_grid.dart';
import '../widgets/calendar_action_buttons.dart';

/// Main calendar/date-time picker dialog
class DateTimePickerDialog extends StatelessWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final bool isSelectingEndDate;

  const DateTimePickerDialog({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.isSelectingEndDate = false,
  });

  /// Show the dialog and return the selected BookingTime
  static Future<BookingTime?> show(
    BuildContext context, {
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    bool isSelectingEndDate = false,
  }) async {
    return showDialog<BookingTime>(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => DateTimePickerDialog(
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        isSelectingEndDate: isSelectingEndDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc()
        ..add(
          InitializeCalendar(
            initialStartDate: initialStartDate,
            initialEndDate: initialEndDate,
            isSelectingEndDate: isSelectingEndDate,
          ),
        ),
      child: const _DateTimePickerContent(),
    );
  }
}

class _DateTimePickerContent extends StatelessWidget {
  const _DateTimePickerContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarBloc, CalendarState>(
      listener: (context, state) {
        if (state is CalendarConfirmed) {
          Navigator.of(context).pop(state.bookingTime);
        } else if (state is CalendarCancelled) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is! CalendarLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Time',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Time Selector
                  TimeSelector(
                    startTime: state.startTime,
                    endTime: state.endTime,
                    onStartTimePressed: () =>
                        _showTimePicker(context, true, state),
                    onEndTimePressed: () =>
                        _showTimePicker(context, false, state),
                  ),
                  const SizedBox(height: 24),
                  // Month Navigation
                  MonthNavigation(
                    displayMonth: state.displayMonth,
                    onPreviousMonth: () {
                      context.read<CalendarBloc>().add(const PreviousMonth());
                    },
                    onNextMonth: () {
                      context.read<CalendarBloc>().add(const NextMonth());
                    },
                  ),
                  const SizedBox(height: 16),
                  // Calendar Grid
                  CalendarGrid(
                    displayMonth: state.displayMonth,
                    rangeStart: state.rangeStart,
                    rangeEnd: state.rangeEnd,
                    onDateSelected: (date) {
                      context.read<CalendarBloc>().add(SelectDate(date));
                    },
                  ),
                  const SizedBox(height: 24),
                  // Action Buttons
                  CalendarActionButtons(
                    onCancel: () {
                      context.read<CalendarBloc>().add(const CancelSelection());
                    },
                    onDone: () {
                      context.read<CalendarBloc>().add(
                        const ConfirmSelection(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showTimePicker(
    BuildContext context,
    bool isStartTime,
    CalendarLoaded state,
  ) async {
    final initialTime = isStartTime
        ? TimeOfDay.fromDateTime(state.startTime)
        : TimeOfDay.fromDateTime(state.endTime);

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF21292B),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && context.mounted) {
      if (isStartTime) {
        context.read<CalendarBloc>().add(
          UpdateStartTime(
            hour: picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod,
            minute: picked.minute,
            isAm: picked.period == DayPeriod.am,
          ),
        );
      } else {
        context.read<CalendarBloc>().add(
          UpdateEndTime(
            hour: picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod,
            minute: picked.minute,
            isAm: picked.period == DayPeriod.am,
          ),
        );
      }
    }
  }
}
