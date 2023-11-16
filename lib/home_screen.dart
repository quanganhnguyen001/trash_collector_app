import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trash_collector_app/features/auth/base_screen.dart';

import 'features/auth/cubit/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(builder: (ctx) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                child: Text('out'),
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
