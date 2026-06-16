import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Pertemuan 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Profile Data
  Uint8List? profileImageBytes;
  String profileImageUrl = 'https://avatars.githubusercontent.com/u/9919?s=200&v=4';
  String name = 'Maelani Ningrum';
  String role = 'Mahasiswa Teknik Informatika';
  String about = 'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan pengembangan aplikasi mobile.';
  String education = 'Universitas Pasundan - Semester 6 (IPK: 3.95)';
  String location = 'Bandung, Jawa Barat';
  String contact = 'myln@gmail.com | +62 852-3455-6750';
  List<String> skillsList = ['Flutter', 'Dart', 'Java', 'UI Design', 'HTML', 'CSS', 'JS', 'PHP', 'MySQL'];

  // Bonus Experience Data
  List<Map<String, dynamic>> experiences = [];

  void _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          initialData: {
            'profileImageBytes': profileImageBytes,
            'profileImageUrl': profileImageUrl,
            'name': name,
            'role': role,
            'about': about,
            'education': education,
            'location': location,
            'contact': contact,
          },
        ),
      ),
    );

    if (result != null) {
      setState(() {
        profileImageBytes = result['profileImageBytes'];
        profileImageUrl = result['profileImageUrl'];
        name = result['name'];
        role = result['role'];
        about = result['about'];
        education = result['education'];
        location = result['location'];
        contact = result['contact'];
      });
    }
  }

  void _editExperience() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UploadExperiencePage(),
      ),
    );

    if (result != null) {
      setState(() {
        experiences.add(result);
      });
    }
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 50,
      height: 50,
      color: const Color(0xFFF3F2FF),
      child: const Icon(Icons.image_outlined, color: Color(0xFFB5B2FF), size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E8CD8), Color(0xFF6C63FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                'Menu Utama',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text('Widget Gallery'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.file_upload_outlined),
              title: const Text('Upload Pengalaman'),
              onTap: () {
                Navigator.pop(context);
                _editExperience();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Pengaturan'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImageBytes != null 
                        ? MemoryImage(profileImageBytes!) 
                        : NetworkImage(profileImageUrl) as ImageProvider,
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(role, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatBox(label: 'Post', value: '50'),
                _StatBox(label: 'Teman', value: '500'),
                _StatBox(label: 'Like', value: '5.2K'),
              ],
            ),
            const SizedBox(height: 24),
            _SectionCard(icon: Icons.school_outlined, title: 'Pendidikan', content: education),
            _SectionCard(icon: Icons.location_on_outlined, title: 'Lokasi', content: location),
            _SectionCard(icon: Icons.email_outlined, title: 'Kontak', content: contact),
            
            // Skills Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.star, color: Color(0xFF6C63FF), size: 20),
                      SizedBox(width: 8),
                      Text('Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: skillsList.map((skill) => Chip(
                      label: Text(skill, style: const TextStyle(color: Color(0xFF6C63FF))),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFF6C63FF), width: 0.5),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Experience Section
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.collections_bookmark_outlined, color: Color(0xFF6C63FF), size: 20),
                const SizedBox(width: 8),
                const Text('Pengalaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E7FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${experiences.length}', 
                    style: const TextStyle(color: Color(0xFF6C63FF), fontSize: 12),
                  ),
                ),
              ],
            ),
            const Divider(height: 16, thickness: 0.5),
            const SizedBox(height: 8),
            if (experiences.isEmpty)
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Belum ada pengalaman. Ketuk menu Upload Pengalaman untuk menambahkan.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...experiences.map((exp) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: exp['imageBytes'] != null
                            ? Image.memory(exp['imageBytes'], width: 50, height: 50, fit: BoxFit.cover)
                            : _buildPlaceholderImage(),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(exp['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(exp['desc'] ?? '', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _editProfile,
        icon: const Icon(Icons.edit_outlined),
        label: const Text('Edit Profil'),
        backgroundColor: const Color(0xFFE8E7FF),
        foregroundColor: const Color(0xFF6C63FF),
        elevation: 1,
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _SectionCard({required this.icon, required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6C63FF), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(content, style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> initialData;
  const EditProfilePage({super.key, required this.initialData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _aboutController;
  Uint8List? _pickedImageBytes;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['name']);
    _aboutController = TextEditingController(text: widget.initialData['about']);
    _pickedImageBytes = widget.initialData['profileImageBytes'];
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        _pickedImageBytes = bytes;
      });
    }
  }

  void _save() {
    Navigator.pop(context, {
      ...widget.initialData,
      'profileImageBytes': _pickedImageBytes,
      'name': _nameController.text,
      'about': _aboutController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profil', style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('✓ Simpan', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Foto Profil', style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _pickedImageBytes != null 
                      ? MemoryImage(_pickedImageBytes!) 
                      : NetworkImage(widget.initialData['profileImageUrl']) as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Color(0xFF6C63FF), shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.copy, size: 16, color: Colors.grey),
              label: const Text('Ganti Foto dari Galeri', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Informasi Profil', style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildRoundedField(_nameController, 'Nama Lengkap *', Icons.person_outline),
                  const SizedBox(height: 16),
                  _buildRoundedField(_aboutController, 'Bio / Tentang', Icons.info_outline, isBio: true),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Simpan Perubahan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF53508E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
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

  Widget _buildRoundedField(TextEditingController controller, String label, IconData icon, {bool isBio = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            maxLines: isBio ? 3 : 1,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              prefixIcon: Icon(icon, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
}

class UploadExperiencePage extends StatefulWidget {
  const UploadExperiencePage({super.key});

  @override
  State<UploadExperiencePage> createState() => _UploadExperiencePageState();
}

class _UploadExperiencePageState extends State<UploadExperiencePage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  Uint8List? _pickedImageBytes;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        _pickedImageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Upload Pengalaman', style: TextStyle(fontSize: 18)),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context, {'imageBytes': _pickedImageBytes, 'title': _titleController.text, 'desc': _descController.text}),
            icon: const Icon(Icons.save, size: 18, color: Color(0xFF53508E)),
            label: const Text('Simpan', style: TextStyle(color: Color(0xFF53508E))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0DFFF)),
                ),
                child: _pickedImageBytes != null
                    ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(_pickedImageBytes!, fit: BoxFit.cover))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add_photo_alternate_outlined, size: 40, color: Color(0xFFB5B2FF)),
                          SizedBox(height: 8),
                          Text('Ketuk untuk pilih gambar', style: TextStyle(color: Color(0xFFB5B2FF), fontSize: 13)),
                          Text('dari galeri perangkat kamu', style: TextStyle(color: Color(0xFFB5B2FF), fontSize: 11)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Informasi Pengalaman', style: TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildField(_titleController, 'Judul *', Icons.title),
            const SizedBox(height: 16),
            _buildField(_descController, 'Deskripsi', Icons.description_outlined, isLong: true),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, {'imageBytes': _pickedImageBytes, 'title': _titleController.text, 'desc': _descController.text}),
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan Pengalaman'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF53508E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {bool isLong = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: isLong ? 4 : 1,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          prefixIcon: Icon(icon, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
