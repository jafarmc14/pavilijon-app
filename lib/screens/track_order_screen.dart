import 'package:flutter/material.dart';
import 'package:pavilijon_app/screens/screen_components.dart';
import 'package:pavilijon_app/widgets/track/track_widgets.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const timelineSteps = [
      TrackTimelineStepData(
        title: 'Ordered',
        subtitle: '10:15 AM - Ritual initiated',
        state: TrackTimelineState.completed,
      ),
      TrackTimelineStepData(
        title: 'Brewing',
        subtitle: '10:18 AM - Precision extraction in progress',
        state: TrackTimelineState.active,
      ),
      TrackTimelineStepData(
        title: 'Ready',
        subtitle: 'Awaiting the call',
        state: TrackTimelineState.pending,
      ),
      TrackTimelineStepData(
        title: 'Completed',
        subtitle: 'The ceremony concludes',
        state: TrackTimelineState.pending,
      ),
    ];

    const summaryItems = [
      TrackSummaryItemData(
        title: 'Ceremony Latte',
        subtitle: 'Oat Milk, Light Roast',
        quantity: 1,
      ),
      TrackSummaryItemData(
        title: 'Miso Cookie',
        subtitle: 'Salted Caramel Glaze',
        quantity: 2,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 72,
            expandedHeight: 72,
            flexibleSpace: ColoredBox(
              color: const Color(0xFFF9F9F9).withValues(alpha: 0.96),
            ),
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const SizedBox(width: 52),
                  Expanded(
                    child: Text(
                      'THE SILENT CEREMONY',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 11,
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF17191A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 52),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TrackHeaderSection(),
                  SizedBox(height: 28),
                  TrackSearchSection(),
                  SizedBox(height: 28),
                  TrackStatusCard(
                    queueNumber: '#232425',
                    statusLabel: 'ARTISANS ARE BREWING',
                    steps: timelineSteps,
                  ),
                  SizedBox(height: 24),
                  TrackSummaryCard(
                    items: summaryItems,
                    totalLabel: 'Total Precision',
                    totalAmount: '\$24.50',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ShellBottomBar(
        activeTab: AppNavTab.track,
        currentTab: AppNavTab.track,
      ),
    );
  }
}
