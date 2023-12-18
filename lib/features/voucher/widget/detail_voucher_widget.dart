import 'package:flutter/material.dart';
import 'package:trash_collector_app/gen/assets/assets.gen.dart';

import '../../../common/widget/button_component.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

class DetailVoucherWidget extends StatelessWidget {
  const DetailVoucherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorPalettes.darkColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: Text(
                  'Voucher Highland Coffee',
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Assets.images.highlandCoffeeImg.image(),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Voucher Highland Coffee trị giá 50.000 VNĐ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.H4(color: ColorPalettes.darkColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text.rich(
                      TextSpan(
                          style: AppTextStyle.paragraphMedium(
                              color: ColorPalettes.darkColor),
                          text: 'Đổi',
                          children: [
                            WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                            TextSpan(
                                text: '50.000',
                                style: AppTextStyle.H5(color: Colors.green)),
                            WidgetSpan(
                                child: SizedBox(
                              width: 5,
                            )),
                            TextSpan(
                                text: 'điểm',
                                style: AppTextStyle.paragraphMedium(
                                    color: ColorPalettes.darkColor))
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Hạn sử dụng đến: 30/01/2024',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkColor),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Hướng dẫn sử dụng',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.H4(color: ColorPalettes.darkColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      ' - Bước 1: Khách hàng vào mục Đổi rác lấy quà để đổi voucher phù hợp với số điểm hiện có',
                      maxLines: 2,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      ' - Bước 2: Khách hàng đến trực tiếp các hệ thống cửa hàng để sử dụng voucher. Vui lòng cung cấp mã cho nhân viên tại quầy khi thanh toán để được áp dụng giảm trừ',
                      maxLines: 3,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkColor),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Điều kiện sử dụng',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.H4(color: ColorPalettes.darkColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      ' - Voucher chỉ có giá trị sử dụng một lần/hóa đơn',
                      maxLines: 1,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      ' - Voucher được dùng như tiền mặt nhưng không có giá trị quy đổi thành tiền mặt, không hoàn trả tiền thừa',
                      maxLines: 3,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      ' - Sản phẩm/dịch vụ vượt quá giá trị của voucher, khách hàng vui lòng kết hợp thanh toán cùng hình thức khác',
                      maxLines: 3,
                      style: AppTextStyle.paragraphMedium(
                          color: ColorPalettes.darkColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonComponents(
            onPressed: () {
              // if (formKey.currentState!.validate()) {
              //   context.read<SignupCubit>().signUp(
              //         ctx: context,
              //       );
              // }
            },
            height: 56,
            radius: 16,
            title: 'Đổi điểm ngay',
            textStyle:
                AppTextStyle.buttonMedium(color: ColorPalettes.whiteColor),
            backgroundColor: Colors.green,
          ),
        ],
      )),
    );
  }
}
