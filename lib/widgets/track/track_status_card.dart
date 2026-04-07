import 'package:flutter/material.dart';

class TrackStatusCard extends StatelessWidget {
  const TrackStatusCard({
    super.key,
    required this.queueNumber,
    required this.statusLabel,
    required this.steps,
  });

  final String queueNumber;
  final String statusLabel;
  final List<TrackTimelineStepData> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -18,
            child: IgnorePointer(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF815534).withValues(alpha: 0.06),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CURRENT QUEUE',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 10,
                                letterSpacing: 2.0,
                                color: const Color(0xFF9C9D9D),
                              ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              queueNumber,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -2,
                                    color: const Color(0xFF17191A),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDCC5),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF815534),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          statusLabel,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 10,
                                letterSpacing: 1.6,
                                color: const Color(0xFF714828),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Stack(
                children: [
                  Positioned(
                    left: 11,
                    top: 6,
                    bottom: 6,
                    child: Container(width: 1, color: const Color(0xFFE3E5E6)),
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < steps.length; i++) ...[
                        _TrackTimelineStep(step: steps[i]),
                        if (i != steps.length - 1) const SizedBox(height: 28),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrackTimelineStep extends StatelessWidget {
  const _TrackTimelineStep({required this.step});

  final TrackTimelineStepData step;

  @override
  Widget build(BuildContext context) {
    final Color titleColor = switch (step.state) {
      TrackTimelineState.active => const Color(0xFF815534),
      TrackTimelineState.completed => const Color(0xFF17191A),
      TrackTimelineState.pending => const Color(0xFF17191A),
    };

    final Color subtitleColor = switch (step.state) {
      TrackTimelineState.active => const Color(0xFF5A6061),
      TrackTimelineState.completed => const Color(0xFF9C9D9D),
      TrackTimelineState.pending => const Color(0xFF9C9D9D),
    };

    final double opacity = step.state == TrackTimelineState.pending ? 0.42 : 1;

    return Opacity(
      opacity: opacity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TrackStepIndicator(state: step.state),
          const SizedBox(width: 18),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      letterSpacing: 0,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackStepIndicator extends StatelessWidget {
  const _TrackStepIndicator({required this.state});

  final TrackTimelineState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: switch (state) {
        TrackTimelineState.completed => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF815534),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 14, color: Colors.white),
        ),
        TrackTimelineState.active => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF815534), width: 2),
            color: const Color(0xFFF9F9F9),
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF815534),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        TrackTimelineState.pending => Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDADDDD),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFDADDDD), width: 2),
          ),
        ),
      },
    );
  }
}

enum TrackTimelineState { completed, active, pending }

class TrackTimelineStepData {
  const TrackTimelineStepData({
    required this.title,
    required this.subtitle,
    required this.state,
  });

  final String title;
  final String subtitle;
  final TrackTimelineState state;
}
