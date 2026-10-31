import 'package:bottobnavigation_bar/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No new notifications"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Explorer! 👋",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Manage your state seamlessly",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.bolt_rounded,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Hero Counter Card with Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.35),
                    offset: const Offset(0, 12),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          "Live Counter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "${counter.count}",
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Current Value",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick Action Buttons inside Card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Decrement button
                      _CounterCircleButton(
                        icon: Icons.remove,
                        tooltip: "Decrement",
                        onPressed: () => context.read<CounterProvider>().decrement(),
                      ),
                      const SizedBox(width: 16),
                      // Reset button
                      _CounterCircleButton(
                        icon: Icons.refresh_rounded,
                        tooltip: "Reset",
                        isSubtle: true,
                        onPressed: () => context.read<CounterProvider>().reset(),
                      ),
                      const SizedBox(width: 16),
                      // Increment button
                      _CounterCircleButton(
                        icon: Icons.add,
                        tooltip: "Increment",
                        onPressed: () => context.read<CounterProvider>().increment(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Step Adjustments Chips
            Text(
              "Quick Steps",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _QuickStepChip(
                  label: "-10",
                  onTap: () => context.read<CounterProvider>().decrement(10),
                ),
                const SizedBox(width: 10),
                _QuickStepChip(
                  label: "-5",
                  onTap: () => context.read<CounterProvider>().decrement(5),
                ),
                const SizedBox(width: 10),
                _QuickStepChip(
                  label: "+5",
                  isPositive: true,
                  onTap: () => context.read<CounterProvider>().increment(5),
                ),
                const SizedBox(width: 10),
                _QuickStepChip(
                  label: "+10",
                  isPositive: true,
                  onTap: () => context.read<CounterProvider>().increment(10),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Statistics Overview
            Text(
              "Analytics Overview",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: "State Status",
                    value: counter.count >= 0 ? "Positive" : "Negative",
                    icon: counter.count >= 0
                        ? Icons.check_circle_outline_rounded
                        : Icons.error_outline_rounded,
                    iconColor: counter.count >= 0 ? const Color(0xFF10B981) : Colors.amber.shade700,
                    subtitle: "Auto synchronizing",
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _StatCard(
                    title: "Provider Mode",
                    value: "Reactive",
                    icon: Icons.sync_alt_rounded,
                    iconColor: const Color(0xFF6366F1),
                    subtitle: "Scoped listener",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterCircleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isSubtle;

  const _CounterCircleButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isSubtle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSubtle ? Colors.white.withOpacity(0.2) : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Tooltip(
          message: tooltip,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(
              icon,
              size: 26,
              color: isSubtle ? Colors.white : const Color(0xFF6366F1),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickStepChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPositive;

  const _QuickStepChip({
    required this.label,
    required this.onTap,
    this.isPositive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isPositive
                ? const Color(0xFF6366F1).withOpacity(0.08)
                : const Color(0xFFE2E8F0).withOpacity(0.6),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isPositive
                  ? const Color(0xFF6366F1).withOpacity(0.3)
                  : const Color(0xFFCBD5E1),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: isPositive ? const Color(0xFF6366F1) : const Color(0xFF475569),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 4),
            blurRadius: 16,
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
