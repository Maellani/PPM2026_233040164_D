import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Mahasiswa_Tugas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            final catatanUntukEdit = settings.arguments as Catatan?;
            return MaterialPageRoute(
              builder: (_) => FormCatatanPage(catatanLama: catatanUntukEdit),
            );
          case '/detail':
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

// ==========================================
// MODEL (Berubah: Tambah field email)
// ==========================================
class Catatan {
  final String id;
  final String judul;
  final String isi;
  final String kategori;
  final String email; // <-- TUGAS MANDIRI: Tambah field email di model
  final DateTime dibuatPada;

  Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.kategori,
    required this.email, // <-- Wajib diisi
    required this.dibuatPada,
  });
}

// ==========================================
// HOMEPAGE
// ==========================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      id: '1',
      judul: 'Belajar Flutter',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      email: 'maelani@student.com', // <-- Data dummy awal
      dibuatPada: DateTime.now(),
    ),
  ];

  String _filterKategori = 'Semua';
  final _filterOpsi = const ['Semua', 'Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  String _formatTanggal(DateTime dt) {
    final bulanOpsi = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${dt.day.toString().padLeft(2, '0')} ${bulanOpsi[dt.month - 1]} ${dt.year}';
  }

  Future<void> _bukaFormCatatan({Catatan? catatanLama}) async {
    final hasil = await Navigator.pushNamed(
      context,
      '/tambah',
      arguments: catatanLama,
    );

    if (hasil is Catatan) {
      setState(() {
        if (catatanLama == null) {
          _catatan.add(hasil);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Catatan "${hasil.judul}" berhasil dibuat')),
          );
        } else {
          final index = _catatan.indexWhere((element) => element.id == catatanLama.id);
          if (index != -1) {
            _catatan[index] = hasil;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Catatan "${hasil.judul}" berhasil diperbarui')),
            );
          }
        }
      });
    }
  }

  void _hapusCatatan(int index, String judul) {
    setState(() {
      _catatan.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan "$judul" telah dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listTerfilter = _filterKategori == 'Semua'
        ? _catatan
        : _catatan.where((c) => c.kategori == _filterKategori).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: _filterKategori,
              underline: const SizedBox(),
              icon: const Icon(Icons.filter_list, color: Colors.indigo),
              items: _filterOpsi.map((k) {
                return DropdownMenuItem(value: k, child: Text(k));
              }).toList(),
              onChanged: (v) {
                setState(() => _filterKategori = v!);
              },
            ),
          )
        ],
      ),
      body: listTerfilter.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Tidak ada catatan',
              style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: listTerfilter.length,
        itemBuilder: (context, i) {
          final c = listTerfilter[i];

          return ListTile(
            title: Text(c.judul),
            subtitle: Text('${c.kategori} • ${_formatTanggal(c.dibuatPada)}'),
            onTap: () async {
              final butuhEdit = await Navigator.pushNamed(context, '/detail', arguments: c);
              if (butuhEdit == true && mounted) {
                _bukaFormCatatan(catatanLama: c);
              }
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                final indexAsli = _catatan.indexOf(c);
                _hapusCatatan(indexAsli, c.judul);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bukaFormCatatan(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ==========================================
// FORM CATATAN PAGE (Berubah: Tambah field & validasi email)
// ==========================================
class FormCatatanPage extends StatefulWidget {
  final Catatan? catatanLama;

  const FormCatatanPage({super.key, this.catatanLama});

  @override
  State<FormCatatanPage> createState() => _FormCatatanPageState();
}

class _FormCatatanPageState extends State<FormCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulCtrl;
  late TextEditingController _isiCtrl;
  late TextEditingController _emailCtrl; // <-- TUGAS MANDIRI: Controller Email
  late String _kategori;

  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    _judulCtrl = TextEditingController(text: widget.catatanLama?.judul ?? '');
    _isiCtrl = TextEditingController(text: widget.catatanLama?.isi ?? '');
    _emailCtrl = TextEditingController(text: widget.catatanLama?.email ?? ''); // <-- Set data lama jika edit
    _kategori = widget.catatanLama?.kategori ?? 'Kuliah';
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _isiCtrl.dispose();
    _emailCtrl.dispose(); // <-- Wajib di-dispose biar ga memory leak
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final catatanHasil = Catatan(
      id: widget.catatanLama?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      judul: _judulCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      email: _emailCtrl.text.trim(), // <-- Ambil text email
      dibuatPada: widget.catatanLama?.dibuatPada ?? DateTime.now(),
    );

    Navigator.pop(context, catatanHasil);
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.catatanLama != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditMode ? 'Ubah Catatan' : 'Tambah Catatan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),

            // --- TUGAS MANDIRI: Field Email Baru + Validasi Regex ---
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Email wajib diisi';
                }
                // Regex untuk cek format email standar internasional
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(v.trim())) {
                  return 'Format email tidak valid (contoh: user@gmail.com)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: Icon(isEditMode ? Icons.update : Icons.save),
              label: Text(isEditMode ? 'Perbarui Catatan' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// DETAIL CATATAN PAGE (Berubah: Nampilin email)
// ==========================================
class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note, size: 30),
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(catatan.judul, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Row untuk menampilkan Kategori dan Email Pengirim biar rapi
            Row(
              children: [
                Chip(label: Text(catatan.kategori)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'oleh: ${catatan.email}',
                    style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(catatan.isi, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}