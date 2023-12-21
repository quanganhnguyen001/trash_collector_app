part of 'voucher_cubit.dart';

class VoucherState extends Equatable {
  const VoucherState(this.listVoucher, this.point);
  final List<VoucherModel> listVoucher;
  final int point;

  @override
  List<Object> get props => [listVoucher];

  VoucherState copyWith({
    List<VoucherModel>? listVoucher,
    int? point,
  }) {
    return VoucherState(
      listVoucher ?? this.listVoucher,
      point ?? this.point,
    );
  }
}
