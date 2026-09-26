import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../widgets/daily_intention_card.dart';
import '../widgets/home_daily_deed_card.dart';
import '../widgets/home_dhikr_card.dart';
import '../widgets/home_footer_verse.dart';
import '../widgets/home_header.dart';
import '../widgets/home_prayer_card.dart';
import '../widgets/home_quick_access.dart';
import '../widgets/home_quran_progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const HomeTopBar(),
            const OfflineBanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                children: const [
                  HomeGreeting(),
                  SizedBox(height: AppSpacing.lg),
                  HomePrayerCard(),
                  SizedBox(height: AppSpacing.lg),
                  DailyIntentionCard(),
                  SizedBox(height: AppSpacing.md),
                  HomeQuickAccess(),
                  SizedBox(height: AppSpacing.md),
                  HomeDhikrCard(),
                  SizedBox(height: AppSpacing.md),
                  HomeQuranProgressCard(),
                  SizedBox(height: AppSpacing.md),
                  HomeDailyDeedCard(),
                  SizedBox(height: AppSpacing.xs),
                  HomeFooterVerse(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
