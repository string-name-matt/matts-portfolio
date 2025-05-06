import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeIntro extends StatelessWidget {
  const HomeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("👋 Hi, I’m Matt Smith", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text("Remote Flutter Developer", style: TextStyle(fontSize: 20)),
        const Text("Built tools used by 300+ employees", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => context.go('/projects'),
              child: const Text("View Projects"),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () => context.go('/resume'),
              child: const Text("View Resume"),
            ),
          ],
        )
      ],
    );
  }
}
