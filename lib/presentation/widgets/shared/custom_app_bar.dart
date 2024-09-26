import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final themeTitleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: themeColors.primary),
              const SizedBox(width: 5),
              Text('Flutter cinema', style: themeTitleStyle),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
        ),
    ));
  }
}
