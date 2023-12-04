part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({required this.selectedImage});
  final File? selectedImage;

  UpdateProfileState copyWith(File? selectedImage) {
    return UpdateProfileState(
        selectedImage: selectedImage ?? this.selectedImage);
  }

  @override
  List<Object?> get props => [selectedImage];
}
