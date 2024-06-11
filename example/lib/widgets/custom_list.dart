import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomList extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, String>> data;
  final AsyncCallback onPressed;

  const CustomList({
    super.key,
    required this.isLoading,
    required this.data,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (data.isEmpty) {
      return CustomButton(onPressed: onPressed);
    }

    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (builderContext, index) {
          Map item = data[index];

          return ListTile(
            title: Text(
              item["title"] ?? "",
            ),
            subtitle: Text(item['subtitle']),
          );
        },
      ),
    );
  }
}
