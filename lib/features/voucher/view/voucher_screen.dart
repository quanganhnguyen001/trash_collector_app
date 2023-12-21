import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trash_collector_app/common/cubit/user/user_cubit.dart';

import 'package:trash_collector_app/features/auth/model/user_model.dart';
import 'package:trash_collector_app/features/voucher/cubit/voucher_cubit.dart';
import 'package:trash_collector_app/features/voucher/model/voucher_model.dart';
import 'package:trash_collector_app/features/voucher/widget/detail_voucher_widget.dart';
import 'package:trash_collector_app/features/voucher/widget/list_voucher_collected.dart';
import 'package:trash_collector_app/gen/assets/assets.gen.dart';

import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';

class VoucherScreen extends StatefulWidget {
  const VoucherScreen({super.key, required this.userModel});
  static const String routeName = '/VoucherScreen';
  final UserModel userModel;

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  void initState() {
    context.read<UserCubit>().loadUserData();

    super.initState();
  }

  final List<VoucherModel> listVoucher = [
    VoucherModel(
        voucherId: '1',
        nameVoucher: 'Highlands Coffee',
        voucherDescription: 'Voucher Highland Coffee trị giá 50.000 VNĐ',
        imageVoucher: Assets.images.highlandCoffeeImg.path,
        point: 50000),
    VoucherModel(
        voucherId: '2',
        nameVoucher: 'Winmart',
        voucherDescription: 'Winmart trị giá 40.000 VNĐ',
        imageVoucher: Assets.images.winmartImg.path,
        point: 40000),
    VoucherModel(
        voucherId: '3',
        nameVoucher: 'Circle K',
        voucherDescription: 'Circle K trị giá 30.000 VNĐ',
        imageVoucher: Assets.images.cirlkeImg.path,
        point: 30000)
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherCubit, VoucherState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorPalettes.darkColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          Str.of(context).list_voucher,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            return Text(
                              '${state.user?.point}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            VoucherCubit()..fetchVoucher(),
                                        child: const ListVoucherCollected(),
                                      )));
                            },
                            child: Assets.images.voucherIc.image(height: 30)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listVoucher.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => DetailVoucherWidget(
                                    onPressed: () {
                                      if (widget.userModel.point! <
                                          listVoucher[index].point!) {
                                        Fluttertoast.showToast(
                                            msg: 'Bạn không đủ điểm',
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.TOP,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            timeInSecForIosWeb: 2,
                                            fontSize: 18);
                                      } else {
                                        context.read<VoucherCubit>().addVoucher(
                                            imageUrl:
                                                listVoucher[index].imageVoucher,
                                            nameVoucher:
                                                listVoucher[index].nameVoucher,
                                            voucherDescription:
                                                listVoucher[index]
                                                    .voucherDescription,
                                            context: context,
                                            userPoint: widget.userModel.point,
                                            voucherPoint:
                                                listVoucher[index].point);
                                      }
                                    },
                                    voucher: listVoucher[index],
                                    userModel: widget.userModel,
                                  )));
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
                                  child: Image.asset(
                                    listVoucher[index].imageVoucher ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            listVoucher[index].nameVoucher ??
                                                '',
                                            style: AppTextStyle.H4(
                                                color: ColorPalettes.darkColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            listVoucher[index]
                                                    .voucherDescription ??
                                                '',
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
                                                style: AppTextStyle
                                                    .paragraphMedium(
                                                        color: ColorPalettes
                                                            .darkColor),
                                                text: 'Đổi',
                                                children: [
                                                  const WidgetSpan(
                                                      child: SizedBox(
                                                    width: 5,
                                                  )),
                                                  TextSpan(
                                                      text: listVoucher[index]
                                                          .point
                                                          .toString(),
                                                      style: AppTextStyle.H5(
                                                          color: Colors.green)),
                                                  const WidgetSpan(
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
      },
    );
  }
}
