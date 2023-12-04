import 'package:flutter/material.dart';

import '../../../gen/localization/l10n.dart';
import '../../../theme/app_style.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static const String routeName = '/HistoryScreen';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              tabs: [
                Tab(
                  child: Text(Str.of(context).trash_wait),
                ),
                Tab(
                  child: Text(
                    Str.of(context).success_collect,
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(Str.of(context).voucher_list),
                )
              ]),
          leading: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          title: Text(
            Str.of(context).history_collect,
            maxLines: 1,
            style: AppTextStyle.H4(),
          ),
          centerTitle: true,
        ),
        body: TabBarView(children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.yellow,
          )
        ]),
      ),
    );
  }
}
