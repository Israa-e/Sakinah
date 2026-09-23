import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../widgets/daily_intention_card.dart';
import '../widgets/home_daily_deed_card.dart';
import '../widgets/home_dhikr_card.dart';
import '../widgets/home_header.dart';
import '../widgets/home_prayer_card.dart';
import '../widgets/home_quran_progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                children: const [
                  HomeHeader(),
                  SizedBox(height: AppSpacing.xl),
                  HomePrayerCard(),
                  SizedBox(height: AppSpacing.lg),
                  DailyIntentionCard(),
                  SizedBox(height: AppSpacing.lg),
                  HomeQuranProgressCard(),
                  SizedBox(height: AppSpacing.lg),
                  HomeDhikrCard(),
                  SizedBox(height: AppSpacing.lg),
                  HomeDailyDeedCard(),
                  SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
