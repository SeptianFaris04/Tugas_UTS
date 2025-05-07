import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _kegiatan = [
    {
      'nama': 'Kuliah Pemrograman Mobile',
      'tanggal': '7 Mei 2025',
      'selesai': false,
    },
    {'nama': 'Rapat Organisasi', 'tanggal': '8 Mei 2025', 'selesai': false},
    {'nama': 'Praktikum Basis Data', 'tanggal': '9 Mei 2025', 'selesai': false},
  ];

  final Map<int, String> quotes = {
    1: 'Tetap semangat, hari ini adalah kesempatan baru!',
    2: 'Setiap tantangan adalah peluang untuk berkembang.',
    3: 'Terus belajar, terus bertumbuh.',
    4: 'Hari ini kamu lebih hebat dari kemarin.',
    5: 'Kerja kerasmu akan membuahkan hasil.',
    6: 'Ambil waktu untuk beristirahat dan refleksi.',
    7: 'Siapkan dirimu untuk minggu yang luar biasa!',
  };

  String getQuoteOfTheDay() {
    final today = DateTime.now().weekday; // 1 = Senin, 7 = Minggu
    return quotes[today] ?? 'Selalu ada alasan untuk tersenyum!';
  }

  void _toggleSelesai(int index, bool? value) {
    setState(() {
      _kegiatan[index]['selesai'] = value ?? false;
    });
  }

  void _hapusKegiatan(int index) {
    setState(() {
      _kegiatan.removeAt(index);
    });
  }

  void _tambahKegiatan() {
    String nama = '';
    String tanggal = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Kegiatan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nama Kegiatan'),
                onChanged: (value) => nama = value,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Tanggal (mis. 10 Mei 2025)',
                ),
                onChanged: (value) => tanggal = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nama.isNotEmpty && tanggal.isNotEmpty) {
                  setState(() {
                    _kegiatan.add({
                      'nama': nama,
                      'tanggal': tanggal,
                      'selesai': false,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    getQuoteOfTheDay(),
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
                    itemCount: _kegiatan.length,
                    itemBuilder: (context, index) {
                      final item = _kegiatan[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(item['nama']),
                          subtitle: Text('Tanggal: ${item['tanggal']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: item['selesai'],
                                onChanged:
                                    (value) => _toggleSelesai(index, value),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _hapusKegiatan(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahKegiatan,
        tooltip: 'Tambah Kegiatan',
        child: const Icon(Icons.add),
      ),
    );
  }
}
