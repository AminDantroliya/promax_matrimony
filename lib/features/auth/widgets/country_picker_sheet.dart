import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/app_font.dart';

class CountryPickerSheet extends StatefulWidget {
  final List<Country> countryList;
  final bool isDarkMode;
  final ValueChanged<Country> onCountrySelected;

  const CountryPickerSheet({
    super.key,
    required this.countryList,
    required this.isDarkMode,
    required this.onCountrySelected,
  });

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.countryList.where((country) {
      final query = _searchQuery.toLowerCase();
      return country.name.toLowerCase().contains(query) ||
          country.dialCode.contains(query) ||
          country.code.toLowerCase().contains(query);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Country Code',
                style: AppFont.font(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : const Color(0xFF16182F),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: widget.isDarkMode ? Colors.white70 : const Color(0xFF8A90A6),
                ),
              ),
            ],
          ),
          const Gap(12),
          // Search Field
          Container(
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F3FB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: _searchController,
              style: AppFont.font(
                color: widget.isDarkMode ? Colors.white : const Color(0xFF16182F),
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search country...',
                hintStyle: AppFont.font(
                  color: widget.isDarkMode ? Colors.white38 : const Color(0xFF8A90A6),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: widget.isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear_rounded,
                          color: widget.isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                          size: 20,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No countries found',
                      style: AppFont.font(
                        color: widget.isDarkMode ? Colors.white54 : const Color(0xFF8A90A6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final country = filteredList[index];
                      return ListTile(
                        leading: Text(
                          country.flag,
                          style: const TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          country.name,
                          style: AppFont.font(
                            fontWeight: FontWeight.w600,
                            color: widget.isDarkMode ? Colors.white : const Color(0xFF16182F),
                          ),
                        ),
                        trailing: Text(
                          '+${country.dialCode}',
                          style: AppFont.font(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onTap: () {
                          widget.onCountrySelected(country);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
