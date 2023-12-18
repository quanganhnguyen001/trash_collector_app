import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(VoucherInitial());
}
