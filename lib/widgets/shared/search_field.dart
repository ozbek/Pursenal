import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField(
      {super.key,
      required this.searchFn,
      this.hintText = "Search",
      this.autoFocus = false,
      this.initText = ""});

  final Function(String) searchFn;
  final String hintText;
  final bool autoFocus;
  final String initText;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initText);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          autofocus: widget.autoFocus,
          onChanged: (term) => widget.searchFn(term),
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: controller.text.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear(); // Clear the text field
                        widget.searchFn(''); // Reset the search
                      },
                    ),
                  )
                : const Icon(Icons.search),
            fillColor: Theme.of(context).cardColor.withValues(alpha: .7),
            filled: true,
          ),
        ),
      ),
    );
  }
}
