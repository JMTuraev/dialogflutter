import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router.dart';
import 'theme/app_theme.dart';

class DialogApp extends ConsumerWidget {
  const DialogApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dialog',
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
