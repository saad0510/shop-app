import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/controllers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authUserProvider) as AuthUserLoaded;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
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
        ),
      ),
    );
  }
}
