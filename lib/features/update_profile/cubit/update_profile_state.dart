part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({required this.selectedImage});
  final String selectedImage;

  UpdateProfileState copyWith(String? selectedImage) {
    return UpdateProfileState(
        selectedImage: selectedImage ?? this.selectedImage);
  }

  @override
  List<Object?> get props => [selectedImage];
}
