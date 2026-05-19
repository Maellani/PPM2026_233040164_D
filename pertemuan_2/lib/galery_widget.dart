import 'package:flutter/material.dart';

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      ('Display', Icons.image, Colors.blue),
      ('Input', Icons.edit, Colors.green),
      ('Button', Icons.smart_button, Colors.orange),
      ('Feedback', Icons.notifications, Colors.purple),
      ('Layout', Icons.dashboard, Colors.teal),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Gallery'),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,

        separatorBuilder: (_, __) =>
        const SizedBox(height: 8),

        itemBuilder: (context, i) {
          final (name, icon, color) =
          categories[i];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,

                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),

              title: Text(name),

              trailing:
              const Icon(Icons.chevron_right),

              onTap: () => Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                      CategoryPage(name: name),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String name;

  const CategoryPage({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final body = switch (name) {
      'Display' => const _DisplayDemo(),
      'Input' => const _InputDemo(),
      'Button' => const _ButtonDemo(),
      'Feedback' => const _FeedbackDemo(),
      'Layout' => const _LayoutDemo(),
      _ => const Center(child: Text('?')),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}

class _DisplayDemo extends StatelessWidget {
  const _DisplayDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        const Text(
          'Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text('Judul Item'),
            subtitle: Text('Sub-judul'),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Chip',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        Wrap(
          spacing: 8,

          children: const [
            Chip(label: Text('Flutter')),
            Chip(label: Text('Dart')),
            Chip(label: Text('Mobile')),
          ],
        ),
      ],
    );
  }
}

class _InputDemo extends StatefulWidget {
  const _InputDemo();

  @override
  State<_InputDemo> createState() =>
      _InputDemoState();
}

class _InputDemoState
    extends State<_InputDemo> {
  bool _checked = false;
  bool _switched = true;
  double _slider = 0.5;
  String? _dropdown = 'Apel';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        const Text('TextField'),

        const SizedBox(height: 4),

        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nama',
            hintText: 'Ketik nama Anda',
          ),
        ),

        const SizedBox(height: 16),

        CheckboxListTile(
          title: const Text('Checkbox'),
          value: _checked,

          onChanged: (v) =>
              setState(() => _checked = v ?? false),
        ),

        SwitchListTile(
          title: const Text('Switch'),
          value: _switched,

          onChanged: (v) =>
              setState(() => _switched = v),
        ),

        const Text('Slider'),

        Slider(
          value: _slider,

          onChanged: (v) =>
              setState(() => _slider = v),
        ),

        const SizedBox(height: 8),

        const Text('Dropdown'),

        DropdownButton<String>(
          value: _dropdown,

          items: ['Apel', 'Jeruk', 'Mangga']
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
              .toList(),

          onChanged: (v) =>
              setState(() => _dropdown = v),
        ),
      ],
    );
  }
}

class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Elevated'),
        ),

        const SizedBox(height: 8),

        FilledButton(
          onPressed: () {},
          child: const Text('Filled'),
        ),

        const SizedBox(height: 8),

        OutlinedButton(
          onPressed: () {},
          child: const Text('Outlined'),
        ),

        const SizedBox(height: 8),

        TextButton(
          onPressed: () {},
          child: const Text('Text Button'),
        ),
      ],
    );
  }
}

class _FeedbackDemo extends StatelessWidget {
  const _FeedbackDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,

      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content:
                Text('Halo dari SnackBar!'),
              ),
            );
          },

          child:
          const Text('Tampilkan SnackBar'),
        ),
      ],
    );
  }
}

class _LayoutDemo extends StatelessWidget {
  const _LayoutDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        const Text(
          'Stack — widget bertumpuk',
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 120,

          child: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue.shade100,
              ),

              Positioned(
                top: 12,
                left: 12,

                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}