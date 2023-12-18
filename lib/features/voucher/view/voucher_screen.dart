import 'package:flutter/material.dart';
import 'package:trash_collector_app/features/voucher/widget/detail_voucher_widget.dart';
import 'package:trash_collector_app/gen/assets/assets.gen.dart';

import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});
  static const String routeName = '/VoucherScreen';

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
              Text(
                Str.of(context).list_voucher,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailVoucherWidget()));
                    },
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: ColorPalettes.grayColor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                            child: Container(
                              height: 194,
                              width: double.infinity,
                              color: ColorPalettes.lightGrayColor,
                              child: Assets.images.highlandCoffeeImg
                                  .image(fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        'Highlands Coffee',
                                        style: AppTextStyle.H4(
                                            color: ColorPalettes.darkColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Text(
                                        'Voucher Highland Coffee trị giá 50.000 VNĐ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.paragraphMedium(
                                            color: ColorPalettes.darkColor),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
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
                                                  style: AppTextStyle.H5(
                                                      color: Colors.green)),
                                              WidgetSpan(
                                                  child: SizedBox(
                                                width: 5,
                                              )),
                                              TextSpan(
                                                  text: 'điểm',
                                                  style: AppTextStyle
                                                      .paragraphMedium(
                                                          color: ColorPalettes
                                                              .darkColor))
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
