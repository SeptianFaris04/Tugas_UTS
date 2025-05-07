import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  final List<Map<String, String>> jadwal = const [
    {'hari': 'Senin', 'mataKuliah': 'Metodologi Penelitian - 08:00'},
    {'hari': 'Selasa', 'mataKuliah': 'Praktikum - 10:00'},
    {'hari': 'Rabu', 'mataKuliah': 'Manajemen Proyek - 13:00'},
    {'hari': 'Kamis', 'mataKuliah': 'Ethical Hacking - 09:00'},
    {'hari': 'Jumat', 'mataKuliah': 'Data Mining - 11:00'},
  ];

  String getQuote() {
    return '📘 Belajar hari ini adalah investasi untuk masa depanmu!';
  }

  String getToday() {
    // Mapping weekday to string (1 = Monday)
    final weekdays = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    final todayIndex = DateTime.now().weekday - 1; // Convert to 0-based index
    return weekdays[todayIndex >= 0 && todayIndex < 7 ? todayIndex : 0];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = getToday();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Kuliah'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  getQuote(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: jadwal.length,
                  itemBuilder: (context, index) {
                    final item = jadwal[index];
                    final isToday = item['hari'] == today;

                    return Card(
                      margin: const EdgeInsets.all(8),
                      color: isToday ? Colors.lightBlue.shade50 : null,
                      elevation: isToday ? 4 : 2,
                      child: ListTile(
                        title: Text(
                          item['hari']!,
                          style: TextStyle(
                            fontWeight:
                                isToday ? FontWeight.bold : FontWeight.normal,
                            color: isToday ? Colors.blue.shade800 : null,
                          ),
                        ),
                        subtitle: Text(item['mataKuliah']!),
                        trailing:
                            isToday
                                ? const Icon(
                                  Icons.star,
                                  color: Colors.orangeAccent,
                                )
                                : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
