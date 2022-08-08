import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/durations.dart';

class PageDotBar extends ConsumerWidget {
  const PageDotBar({
    Key? key,
    required this.count,
    required this.activeIndex,
  }) : super(key: key);

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => PageDot(active: i == activeIndex),
      ),
    );
  }
}

class PageDot extends StatelessWidget {
  const PageDot({Key? key, required this.active}) : super(key: key);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Durations.animation,
      height: 10,
      margin: const EdgeInsets.only(right: 8),
      width: active ? 30 : 10,
      decoration: BoxDecoration(
        color: active ? Theme.of(context).colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
