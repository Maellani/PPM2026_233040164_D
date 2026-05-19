import 'package:flutter/material.dart';
import 'galery_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text('Profil Saya'),

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),

              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
            ),

            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),

              onTap: () {
                showDialog(
                  context: context,

                  builder: (_) => AlertDialog(
                    title: const Text('Pengaturan'),

                    content: const Text(
                      'Fitur pengaturan belum tersedia.',
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),

              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                    const GalleryHome(),
                  ),
                );
              },
            ),

            const ListTile(
              leading: Icon(Icons.info),
              title: Text('Tentang'),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,

                    backgroundImage:
                    NetworkImage(
                      'https://avatars.githubusercontent.com/u/9919?s=200&v=4',
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Maelani Ningrum',

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Mahasiswa Teknik Informatika',

                    style: TextStyle(
                      fontSize: 14,
                      color: Colors
                          .grey
                          .shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    label: 'Post',
                    value: '50',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Teman',
                    value: '500',
                  ),
                ),

                Expanded(
                  child: _StatBox(
                    label: 'Like',
                    value: '5.2K',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',

              content:
              'Saya suka belajar hal baru, terutama yang berkaitan '
                  'dengan teknologi dan pengembangan aplikasi mobile.',
            ),

            _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',

              content:
              'Universitas Pasundan — Semester 6\nIPK: 3.95',
            ),

            _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi & Minat',

              content:
              'Coding • Membaca • Mendaki • Game',
            ),

            _SectionCard(
              icon: Icons.email,
              title: 'Kontak',

              content:
              'myln@gmail.com\n+62 852-3455-6750',
            ),

            Card(
              margin:
              const EdgeInsets.only(
                bottom: 12,
              ),

              child: Padding(
                padding:
                const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 12),

                        Text(
                          'Skills',

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,

                      children: const [
                        Chip(
                            label:
                            Text('Flutter')),

                        Chip(
                            label:
                            Text('Dart')),

                        Chip(
                            label:
                            Text('Java')),

                        Chip(
                            label: Text(
                                'UI Design')),

                        Chip(
                            label: Text(
                                'Firebase')),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Edit profil belum tersedia',
              ),
            ),
          );
        },

        icon: const Icon(Icons.edit),

        label:
        const Text('Edit Profil'),
      ),

      bottomNavigationBar:
      NavigationBar(
        selectedIndex: 1,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),

          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Pesan',
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],

        onDestinationSelected: (i) {},
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,

          style: const TextStyle(
            fontSize: 20,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,

          style: TextStyle(
            color:
            Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.only(
        bottom: 12,
      ),

      child: Padding(
        padding:
        const EdgeInsets.all(16),

        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 28,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [
                  Text(
                    title,

                    style:
                    const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    content,

                    style:
                    const TextStyle(
                      height: 1.4,
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