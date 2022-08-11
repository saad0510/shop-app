import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/extensions/context.dart';
import '../../../auth/presentation/controllers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(userProvider.notifier).signout();
              context.goReplaceNamed(Routes.signin);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: state is UserLoaded
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.userData.uid),
                  Text(state.userData.firstName),
                  Text(state.userData.lastName),
                  Text(state.userData.email),
                  Text(state.userData.password),
                  Text(state.userData.phone),
                  Text(state.userData.address),
                ],
              )
            : const Text("No user is signed in"),
      ),
    );
  }
}
