import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';
import 'states.dart';

/// Placeholder for a feature tab whose implementation phase hasn't landed
/// yet, so the app shell stays fully navigable while features build out
/// incrementally (see DEVELOPMENT ORDER in the project spec).
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EmptyState(
          icon: icon,
          title: context.l10n.comingSoonTitle,
          message: context.l10n.comingSoonBody,
        ),
      ),
    );
  }
}
