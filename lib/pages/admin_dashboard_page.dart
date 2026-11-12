import 'package:flutter/material.dart';

import '../state/auth_state.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key, required this.authState});

  final AuthState authState;

  static const double _maxContentWidth = 1100;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    final String name = '${authState.username}'.trim();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxContentWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(_spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _WelcomeCard(name: name),
                  const SizedBox(height: 24),
                  const _SectionTitle('Ringkasan'),
                  const SizedBox(height: 12),
                  const _StatsSection(),
                  const SizedBox(height: 24),
                  const _SectionTitle('Aksi Cepat'),
                  const SizedBox(height: 12),
                  const _QuickActions(),
                  const SizedBox(height: 24),
                  const _SectionTitle('Aktivitas Terbaru'),
                  const SizedBox(height: 12),
                  const _RecentActivity(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.name});

  final String name;

  String _greeting() {
    final int hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi';
    if (hour < 15) return 'Selamat siang';
    if (hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final String displayName = name.isEmpty ? 'Admin' : name;
    final String initial = displayName.substring(0, 1).toUpperCase();

    return Card(
      elevation: 0,
      color: scheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 28,
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              child: Text(
                initial,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_greeting()},',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selamat datang di panel admin.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}



class _StatData {
  const _StatData({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  static const List<_StatData> _stats = <_StatData>[
    _StatData(label: 'Total Pengguna', value: '1.250', icon: Icons.people),
    _StatData(label: 'Pesanan Baru', value: '84', icon: Icons.shopping_cart),
    _StatData(label: 'Pendapatan', value: 'Rp 12,5 jt', icon: Icons.payments),
    _StatData(label: 'Laporan Aktif', value: '7', icon: Icons.report),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double spacing = AdminDashboardPage._spacing;
        final double maxWidth = constraints.maxWidth;
        final int columns = maxWidth >= 900 ? 4 : 2;
        final double itemWidth = (maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: _stats
              .map((_StatData s) => SizedBox(
                    width: itemWidth,
                    child: _StatCard(data: s),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.data});

  final _StatData data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(data.icon, color: scheme.primary),
            const SizedBox(height: 12),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                data.value,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}



class _QuickActions extends StatelessWidget {
  const _QuickActions();

  void _notImplemented(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$label belum dihubungkan.')));
  }

  @override
  Widget build(BuildContext context) {
    final List<(IconData, String)> actions = <(IconData, String)>[
      (Icons.person_add, 'Tambah Pengguna'),
      (Icons.inventory_2, 'Kelola Data'),
      (Icons.bar_chart, 'Lihat Laporan'),
      (Icons.settings, 'Pengaturan'),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: actions
          .map(
            ((IconData, String) a) => FilledButton.tonalIcon(
              onPressed: () => _notImplemented(context, a.$2),
              icon: Icon(a.$1),
              label: Text(a.$2),
            ),
          )
          .toList(),
    );
  }
}



class _RecentActivity extends StatelessWidget {
  const _RecentActivity();

  static const List<(IconData, String, String)> _items =
      <(IconData, String, String)>[
    (Icons.person_add_alt_1, 'Pengguna baru terdaftar', '5 menit lalu'),
    (Icons.shopping_bag, 'Pesanan #1042 dibuat', '23 menit lalu'),
    (Icons.edit_note, 'Data produk diperbarui', '1 jam lalu'),
    (Icons.report_problem, 'Laporan baru masuk', '3 jam lalu'),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < _items.length; i++) ...<Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.secondaryContainer,
                foregroundColor: scheme.onSecondaryContainer,
                child: Icon(_items[i].$1),
              ),
              title: Text(_items[i].$2),
              subtitle: Text(_items[i].$3),
            ),
            if (i != _items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}