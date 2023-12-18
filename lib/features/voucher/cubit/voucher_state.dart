part of 'voucher_cubit.dart';

sealed class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
}

final class VoucherInitial extends VoucherState {}
