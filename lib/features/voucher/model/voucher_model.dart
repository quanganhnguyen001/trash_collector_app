import 'dart:convert';

class VoucherModel {
  final String? voucherId;
  final String? nameVoucher;
  final String? voucherDescription;
  final String? imageVoucher;
  final int? point;

  VoucherModel(
      {this.voucherId,
      this.nameVoucher,
      this.voucherDescription,
      this.imageVoucher,
      this.point});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (voucherId != null) {
      result.addAll({'voucherId': voucherId});
    }
    if (nameVoucher != null) {
      result.addAll({'nameVoucher': nameVoucher});
    }
    if (voucherDescription != null) {
      result.addAll({'voucherDescription': voucherDescription});
    }
    if (imageVoucher != null) {
      result.addAll({'imageVoucher': imageVoucher});
    }
    if (point != null) {
      result.addAll({'point': point});
    }

    return result;
  }

  factory VoucherModel.fromMap(Map<String, dynamic> map) {
    return VoucherModel(
      voucherId: map['voucherId'],
      nameVoucher: map['nameVoucher'],
      voucherDescription: map['voucherDescription'],
      imageVoucher: map['imageVoucher'],
      point: map['point'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VoucherModel.fromJson(String source) =>
      VoucherModel.fromMap(json.decode(source));
}
