part of 'home_admin_cubit.dart';

class HomeAdminState extends Equatable {
  const HomeAdminState(
      {required this.trashListAdminPending,
      required this.trashListAminCompleted});
  final List<TrashModel> trashListAdminPending;
  final List<TrashModel> trashListAminCompleted;

  @override
  List<Object> get props => [trashListAdminPending, trashListAminCompleted];

  HomeAdminState copyWith({
    List<TrashModel>? trashListAdminPending,
    List<TrashModel>? trashListAminCompleted,
  }) {
    return HomeAdminState(
      trashListAdminPending:
          trashListAdminPending ?? this.trashListAdminPending,
      trashListAminCompleted:
          trashListAminCompleted ?? this.trashListAminCompleted,
    );
  }
}
