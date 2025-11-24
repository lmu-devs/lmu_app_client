import 'dart:async';
import 'dart:convert';

import 'package:core/api.dart';
import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationSearchSheet extends StatefulWidget {
  const LocationSearchSheet({super.key, required this.onSelected});

  final ValueChanged<LocationModel> onSelected;

  @override
  State<LocationSearchSheet> createState() => _LocationSearchSheetState();
}

class _LocationSearchSheetState extends State<LocationSearchSheet> {
  final TextEditingController controller = TextEditingController();
  Timer? debounce;
  List<LocationModel> results = [];
  bool loading = false;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String text) {
    if (debounce?.isActive ?? false) debounce?.cancel();

    if (text.length < 3) {
      setState(() => results = []);
      return;
    }

    debounce = Timer(const Duration(milliseconds: 1000), () async {
      setState(() => loading = true);

      results = await _searchAddress(text);

      if (mounted) {
        setState(() => loading = false);
      }
    });
  }

  Future<List<LocationModel>> _searchAddress(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5',
    );

    final response = await http.get(url, headers: {'User-Agent': 'LmuStudentsApp/1.0 (contact@lmu-dev.org)'});

    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body) as List;

    return data.map((e) {
      return LocationModel(
        address: e['display_name'],
        latitude: double.tryParse(e['lat']) ?? 0,
        longitude: double.tryParse(e['lon']) ?? 0,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LmuSizes.size_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LmuInputField(
            controller: controller,
            hintText: "Adresse suchen",
            isMultiline: false,
            onChanged: _onSearchChanged,
          ),
          const SizedBox(height: 12),
          if (loading) const Center(child: CircularProgressIndicator()),
          ...results.map((loc) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: LmuText(
                      loc.address,
                    ),
                  ),
                  const SizedBox(width: 12),
                  LmuButton(
                    onTap: () {
                      widget.onSelected(loc);
                    },
                    title: "Auswählen",
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
