import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/journey_models.dart';

extension GardenStageL10n on GardenStage {
  String label(AppLocalizations l10n) => switch (this) {
        GardenStage.seed => l10n.journeyStageSeed,
        GardenStage.sprout => l10n.journeyStageSprout,
        GardenStage.sapling => l10n.journeyStageSapling,
        GardenStage.blooming => l10n.journeyStageBlooming,
        GardenStage.flourishing => l10n.journeyStageFlourishing,
      };

  String message(AppLocalizations l10n) => switch (this) {
        GardenStage.seed => l10n.journeyStageMessageSeed,
        GardenStage.sprout => l10n.journeyStageMessageSprout,
        GardenStage.sapling => l10n.journeyStageMessageSapling,
        GardenStage.blooming => l10n.journeyStageMessageBlooming,
        GardenStage.flourishing => l10n.journeyStageMessageFlourishing,
      };
}

extension JourneyMilestoneX on JourneyMilestone {
  String label(AppLocalizations l10n) => switch (this) {
        JourneyMilestone.firstStep => l10n.journeyMilestoneFirstStep,
        JourneyMilestone.firstReflection => l10n.journeyMilestoneFirstReflection,
        JourneyMilestone.fivePrayersInADay => l10n.journeyMilestoneFivePrayers,
        JourneyMilestone.ayahs100 => l10n.journeyMilestoneAyahs100,
        JourneyMilestone.streak7 => l10n.journeyMilestoneStreak7,
        JourneyMilestone.streak30 => l10n.journeyMilestoneStreak30,
        JourneyMilestone.level5 => l10n.journeyMilestoneLevel5,
      };

  IconData get icon => switch (this) {
        JourneyMilestone.firstStep => Icons.spa_outlined,
        JourneyMilestone.firstReflection => Icons.edit_note,
        JourneyMilestone.fivePrayersInADay => Icons.mosque_outlined,
        JourneyMilestone.ayahs100 => Icons.menu_book_outlined,
        JourneyMilestone.streak7 => Icons.local_florist_outlined,
        JourneyMilestone.streak30 => Icons.park_outlined,
        JourneyMilestone.level5 => Icons.workspace_premium_outlined,
      };
}
