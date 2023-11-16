part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool isShowPassword;
  const SignupState({required this.isShowPassword});

  @override
  List<Object> get props => [isShowPassword];

  SignupState copyWith({bool? isShowPassword}) {
    return SignupState(isShowPassword: isShowPassword ?? this.isShowPassword);
  }
}
