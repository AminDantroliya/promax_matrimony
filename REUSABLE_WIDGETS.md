# Reusable Input Widgets Guide for Developers

To keep the UI consistent and the codebase easy to maintain, we follow a strict naming convention for our input widgets:
- **`App` Prefix (`App*`)**: Globally reusable input fields (e.g., Registration, Profile Editing, support forms) styled in the standard card-style design *without* prefix icons.
- **`Search` Prefix (`Search*`)**: Widgets designed specifically for the Search tab layouts containing unique design features like left-aligned colored icon boxes.

---

## 1. Global Input Fields (`App*`)

These widgets are located in `lib/widgets/` and are fully theme-aware (automatically adapting to light and dark modes).

### `AppTextField`
* **File**: `lib/widgets/app_text_field.dart`
* **Usage**: Standard text input field.
* **Code Example**:
  ```dart
  AppTextField(
    labelText: "EMAIL ADDRESS",
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    validator: (val) => val == null || val.isEmpty ? "Email is required" : null,
  )
  ```

### `AppSingleSelectDropdown`
* **File**: `lib/widgets/app_single_select_dropdown.dart`
* **Usage**: Selection dropdown showing options in a custom modal bottom sheet.
* **Code Example**:
  ```dart
  AppSingleSelectDropdown(
    hintText: "Religion",
    items: religionOptionsList,
    selectedItem: currentReligion,
    onChanged: (DropdownOptionModel? val) {
      // Handle selection change
    },
  )
  ```

### `AppMultiSelectDropdown`
* **File**: `lib/widgets/app_multi_select_dropdown.dart`
* **Usage**: Multi-selection dropdown showing checkbox options inside a custom modal bottom sheet.
* **Code Example**:
  ```dart
  AppMultiSelectDropdown(
    hintText: "Marital Status",
    items: maritalStatusOptionsList,
    selectedItems: selectedMaritalStatuses,
    onChanged: (List<DropdownOptionModel> selected) {
      // Handle list of selected options
    },
  )
  ```

### `AppPhoneNumberField`
* **File**: `lib/widgets/app_phone_number_field.dart`
* **Usage**: Special phone input with built-in country code select dialog.
* **Code Example**:
  ```dart
  AppPhoneNumberField(
    labelText: "MOBILE NUMBER",
    controller: mobileController,
    countryList: countryCodesList,
    onCountryChanged: (country) {
      print("Selected country dial code: ${country.dialCode}");
    },
    onChanged: (phone) {
      print("Formatted number: ${phone.completeNumber}");
    },
  )
  ```

### `AppPrimaryButton` & `AppSecondaryButton`
* **File**: `lib/widgets/app_button.dart`
* **Usage**: Standard brand primary gradient-filled button and secondary outlined button.
* **Code Example**:
  ```dart
  AppPrimaryButton(
    label: "CONTINUE",
    onPressed: () => print("Primary pressed"),
  )
  ```

### `PhotoRequestBottomSheet`
* **File**: `lib/widgets/photo_request_bottom_sheet.dart`
* **Usage**: Theme-aware modal bottom sheet to request/manage photo access for a specific member. Shows drag handle, description, and action buttons.
* **Code Example**:
  ```dart
  PhotoRequestBottomSheet.show(context, memberId: member.id);
  ```

### `LogoutBottomSheet`
* **File**: `lib/widgets/logout_bottom_sheet.dart`
* **Usage**: Theme-aware modal bottom sheet requesting exit confirmation.
* **Code Example**:
  ```dart
  showModalBottomSheet(
    context: context,
    builder: (_) => const LogoutBottomSheet(),
  );
  ```

### `MembershipUpgradeBottomSheet`
* **File**: `lib/widgets/membership_upgrade_bottom_sheet.dart`
* **Usage**: Bottom sheet guiding the user to upgrade their membership.
* **Code Example**:
  ```dart
  MembershipUpgradeBottomSheet.show(context, message: "Upgrade required");
  ```

### `AppAppBar`
* **File**: `lib/widgets/app_app_bar.dart`
* **Usage**: Standard reusable screen appbar.

### `AppMemberListItem`
* **File**: `lib/widgets/app_member_list_item.dart`
* **Usage**: Standard search result list item card for displaying a member.

### `AppDrawer`
* **File**: `lib/widgets/app_drawer.dart`
* **Usage**: Reusable side navigation drawer.

### `AppLoadingWidget`
* **File**: `lib/widgets/app_loading_widget.dart`
* **Usage**: Centered spinning loader or pagination spinner.

### `AppNoRecordsWidget`
* **File**: `lib/widgets/app_no_records_widget.dart`
* **Usage**: Styled placeholder shown when lists are empty.

---

## 2. Search-Specific Widgets (`Search*`)

These widgets are located in `lib/widgets/search_figma_widgets.dart` and are used specifically in the **Quick Search** and **Advanced Search** screens to support Figma search mockups.

### `SearchIconDropdown`
* **Usage**: Multi-select dropdown featuring a colored squircle container with a leading icon on the left. Opens in a modal bottom sheet.
* **Code Example**:
  ```dart
  SearchIconDropdown(
    labelText: "Marital Status",
    icon: Icons.favorite_rounded,
    items: dropdownData.maritalStatus!,
    selectedItems: selectedItemsList,
    onChanged: (selected) {
      // Handle selection
    },
  )
  ```

### `SearchIconTextField`
* **Usage**: Text input featuring a leading squircle icon container on the left.
* **Code Example**:
  ```dart
  SearchIconTextField(
    labelText: "PROFILE ID",
    icon: Icons.search_rounded,
    controller: idSearchController,
  )
  ```

### `SearchRangeBar`
* **Usage**: Dual-thumb range slider for selections like Age and Height.
* **Code Example**:
  ```dart
  SearchRangeBar(
    title: "Age Range",
    displayValue: "21 Year - 35 Year",
    values: _ageRangeValues,
    min: 18.0,
    max: 70.0,
    divisions: 52,
    onChanged: (values) {
      setState(() => _ageRangeValues = values);
    },
  )
  ```

### `SearchTabBar`
* **Usage**: Custom segmented pill button tab bar (e.g. Quick, Advanced, By ID, Saved).

### `SearchCheckbox`
* **Usage**: Rounded checkbox component used in search filter lists.

---

## 3. Best Practices & Guidelines

1. **Light/Dark Mode Compliance**:
   - Always use `Theme.of(context).colorScheme.surface` or dynamic backgrounds rather than hardcoding solid colors.
   - Use `isDark ? Color(...) : Color(...)` patterns when using custom color schemes.
2. **Text Field Validation**:
   - Core input fields handle errors gracefully outside of the card borders to prevent layout clipping. Always wrap form fields in standard Flutter `Form` widgets and trigger `FormState.validate()`.
3. **Popups/Dialogs to Bottom Sheets**:
   - All selection lists, alerts, and confirmation dialogs must be converted to **Modal Bottom Sheets** using `showModalBottomSheet`. Use `AppDialogs.confirm(...)` for confirm/cancel actions to maintain the unified drag handle and gradient button designs.
4. **Text Helpers (`app_text_helpers.dart`)**:
   - Contains global typography helper methods (e.g., `customTextBoldStyle(...)`, `customTextNormalStyle(...)`). Always use these helper methods rather than manually creating `Text` widgets with local style blocks to ensure app-wide font synchronization.
