import 'package:flutter/material.dart';

/// Widget for entering car location
class LocationInputField extends StatefulWidget {
  final String? location;
  final ValueChanged<String?> onLocationChanged;

  const LocationInputField({
    super.key,
    this.location,
    required this.onLocationChanged,
  });

  @override
  State<LocationInputField> createState() => _LocationInputFieldState();
}

class _LocationInputFieldState extends State<LocationInputField> {
  late TextEditingController _controller;
  bool _isUserEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.location ?? '');
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _isUserEditing = true;
  }

  @override
  void didUpdateWidget(LocationInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update controller text if the change came from outside (e.g. clear all)
    // and not from user typing
    if (!_isUserEditing && 
        widget.location != oldWidget.location && 
        widget.location != _controller.text) {
      _controller.text = widget.location ?? '';
    }
    _isUserEditing = false;
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Car Location',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFD7D7D7)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: Color(0xFF767676),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onLocationChanged,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                      border: InputBorder.none,
                      hintText: 'Enter location...',
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Color(0xFF7F7F7F),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

