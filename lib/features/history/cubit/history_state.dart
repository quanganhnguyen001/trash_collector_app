part of 'history_cubit.dart';

class HistoryState extends Equatable {
  const HistoryState(
      {required this.trashListPending, required this.trashListCompleted});
  final List<TrashModel> trashListPending;
  final List<TrashModel> trashListCompleted;

  @override
  List<Object> get props => [trashListCompleted, trashListPending];

  HistoryState copyWith({
    List<TrashModel>? trashListPending,
    List<TrashModel>? trashListCompleted,
  }) {
    return HistoryState(
      trashListPending: trashListPending ?? this.trashListPending,
      trashListCompleted: trashListCompleted ?? this.trashListCompleted,
    );
  }
}
