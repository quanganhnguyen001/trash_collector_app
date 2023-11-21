import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/common/widget/alert_dialog_component.dart';

import '../../../common/cubit/user/user_cubit.dart';
import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';
import '../../../theme/color_paletes.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../widget/cell_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<UserCubit>().loadUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                Str.of(context).profile,
                style: AppTextStyle.H4(),
              ),
              centerTitle: true,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return Container(
                        height: 155,
                        width: 140,
                        decoration: const BoxDecoration(
                            color: Colors.black12, shape: BoxShape.circle),
                      );
                    },
                    imageUrl: state.user?.imageUrl ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 155,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: ColorPalettes.secondaryColor,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 155,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: ColorPalettes.secondaryColor,
                        ),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://media.istockphoto.com/id/1223671392/vi/vec-to/%E1%BA%A3nh-h%E1%BB%93-s%C6%A1-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-h%C3%ACnh-%C4%91%E1%BA%A1i-di%E1%BB%87n-ch%E1%BB%97-d%C3%A0nh-s%E1%BA%B5n-cho-%E1%BA%A3nh-minh-h%E1%BB%8Da-vect%C6%A1.jpg?s=612x612&w=0&k=20&c=l9x3h9RMD16-z4kNjo3z7DXVEORzkxKCMn2IVwn9liI=')),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    Str.of(context).info_account,
                    style: AppTextStyle.H5(color: ColorPalettes.darkColor),
                  ),
                ),
                CellWidget(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: state.user?.name ?? '',
                  title: Str.of(context).username,
                ),
                CellWidget(
                  icon: const Icon(
                    Icons.email,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: state.user?.email ?? '',
                  title: 'Email',
                ),
                CellWidget(
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: state.user?.phone != ""
                      ? state.user?.phone ?? ''
                      : Str.of(context).update_phone,
                  title: 'Phone number',
                ),
                CellWidget(
                  icon: const Icon(
                    Icons.location_city,
                    color: Colors.green,
                    size: 30,
                  ),
                  label: state.user?.phone ?? '',
                  title: Str.of(context).location,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        AlertDialogComponent.showCupertinoAlertDialog(
                            context: context,
                            onPressed: () {
                              context.read<AuthCubit>().logout();
                            },
                            title: Str.of(context).log_out,
                            content: Str.of(context).alert_logout);
                      },
                      child: Text(
                        Str.of(context).log_out,
                        style: AppTextStyle.buttonMedium(
                          color: Colors.red,
                        ),
                      )),
                )
              ],
            ));
      },
    );
  }
}
