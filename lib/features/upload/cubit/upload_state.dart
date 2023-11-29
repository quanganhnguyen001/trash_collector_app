part of 'upload_cubit.dart';

class UploadState extends Equatable {
  const UploadState({required this.selectedDate, required this.selectedTime});
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  @override
  List<Object> get props => [selectedDate, selectedTime];

  UploadState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  }) {
    return UploadState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}
