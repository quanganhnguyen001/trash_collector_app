part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({required this.isShowPassword});
  final bool isShowPassword;

  @override
  List<Object> get props => [isShowPassword];

  LoginState copyWith({bool? isShowPassword}) {
    return LoginState(isShowPassword: isShowPassword ?? this.isShowPassword);
  }
}
