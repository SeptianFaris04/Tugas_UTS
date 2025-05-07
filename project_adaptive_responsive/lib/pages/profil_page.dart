import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  final void Function(bool isDark)? onThemeChanged;

  const ProfilPage({super.key, this.onThemeChanged});

  @override
  State<ProfilPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<ProfilPage> {
  bool _isDarkMode = false;

  String _nama = 'Muhammad Septian Farisasmita';
  String _npm = '4522210124';
  String _email = '4522210124@univpancasila.ac.id';

  void _editData(String label, String initialValue, Function(String) onSave) {
    String tempValue = initialValue;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit $label'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
              controller: TextEditingController(text: initialValue),
              onChanged: (value) => tempValue = value,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  onSave(tempValue);
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/Foto1.jpg'),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Nama: $_nama',
                            textAlign: TextAlign.center,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => _editData(
                                  'Nama',
                                  _nama,
                                  (val) => setState(() => _nama = val),
                                ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                            'NPM: $_npm',
                            textAlign: TextAlign.center,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => _editData(
                                  'NPM',
                                  _npm,
                                  (val) => setState(() => _npm = val),
                                ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                            'Email: $_email',
                            textAlign: TextAlign.center,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => _editData(
                                  'Email',
                                  _email,
                                  (val) => setState(() => _email = val),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Mode Gelap:', style: TextStyle(fontSize: 18)),
                    Switch(
                      value: _isDarkMode,
                      onChanged: (value) {
                        setState(() => _isDarkMode = value);
                        widget.onThemeChanged?.call(value);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
