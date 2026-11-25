import '../../../../common/data/models/dropdown_models.dart';

/// Complete Form Schema loaded from backend or default configuration
class DynamicFormSchema {
  final int totalSteps;
  final bool allowSkipSteps;
  final List<FormSection> sections;

  const DynamicFormSchema({
    required this.totalSteps,
    this.allowSkipSteps = false,
    required this.sections,
  });

  factory DynamicFormSchema.fromJson(Map<String, dynamic> json) {
    final rawSections = json['sections'] as List<dynamic>? ?? [];
    return DynamicFormSchema(
      totalSteps: json['total_steps'] as int? ?? rawSections.length,
      allowSkipSteps: json['allow_skip_steps'] as bool? ?? false,
      sections: rawSections
          .map((s) => FormSection.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_steps': totalSteps,
        'allow_skip_steps': allowSkipSteps,
        'sections': sections.map((s) => s.toJson()).toList(),
      };

  /// Fallback complete default schema that guarantees offline/instant operation
  static DynamicFormSchema defaultSchema() {
    return DynamicFormSchema.fromJson({
      "total_steps": 10,
      "allow_skip_steps": false,
      "sections": [
        {
          "step_number": 1,
          "step_key": "basic_credentials",
          "title": "Let's create your love profile",
          "subtitle": "Fill in your details to start your journey",
          "endpoint": "register",
          "http_method": "POST",
          "fields": [
            {
              "name": "gender",
              "label": "Gender",
              "type": "segment_selector",
              "is_required": true,
              "default_value": null,
              "options": [
                {"id": "Male", "label": "Male", "icon": "male"},
                {"id": "Female", "label": "Female", "icon": "female"}
              ]
            },
            {
              "name": "fullname",
              "label": "Full Name",
              "placeholder": "Akash Sharma",
              "type": "text",
              "icon": "user",
              "is_required": true,
              "validation": {
                "min_length": 3,
                "max_length": 50,
                "error_message": "Please enter your full name"
              }
            },
            {
              "name": "mobile_number",
              "label": "Phone Number",
              "placeholder": "Phone number",
              "type": "phone_number",
              "is_required": true,
              "default_country_code": "+1",
              "validation": {
                "min_digits": 7,
                "max_digits": 15,
                "error_message": "Please enter a valid phone number"
              }
            },
            {
              "name": "email",
              "label": "Email Address",
              "placeholder": "you@example.com",
              "type": "email",
              "icon": "mail",
              "is_required": true,
              "validation": {
                "regex": r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                "error_message": "Please enter a valid email address"
              }
            },
            {
              "name": "password",
              "label": "Password",
              "placeholder": "••••••••",
              "type": "password",
              "icon": "lock",
              "is_required": true,
              "validation": {
                "min_length": 6,
                "error_message": "Password must be at least 6 characters"
              }
            },
            {
              "name": "confirm_password",
              "label": "Confirm Password",
              "placeholder": "••••••••",
              "type": "password",
              "icon": "lock",
              "is_required": true,
              "validation": {
                "match_field": "password",
                "error_message": "Passwords do not match"
              }
            },
            {
              "name": "birth_date",
              "label": "Date of Birth",
              "placeholder": "Aug 30, 1994",
              "type": "date_picker",
              "icon": "calendar",
              "is_required": true,
              "validation": {
                "min_age_male": 21,
                "min_age_female": 18,
                "error_message": "Age must be at least 18 (Female) or 21 (Male)"
              }
            },
            {
              "name": "terms_and_conditions",
              "label": "I agree to Terms & Conditions and Privacy Policy",
              "type": "checkbox",
              "is_required": true,
              "default_value": true,
              "validation": {
                "must_be_checked": true,
                "error_message": "You must accept Terms & Conditions"
              }
            }
          ]
        },
        {
          "step_number": 2,
          "step_key": "basic_info",
          "title": "Basic Information",
          "subtitle": "Tell us about yourself",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 1},
          "fields": [
            {
              "name": "profileby",
              "label": "Profile Created For",
              "placeholder": "Select relationship",
              "type": "single_select_dropdown",
              "dropdown_source": "profileCreatedForList",
              "is_required": true
            },
            {
              "name": "marital_status",
              "label": "Marital Status",
              "placeholder": "Select marital status",
              "type": "single_select_dropdown",
              "dropdown_source": "maritalStatusList",
              "is_required": true
            },
            {
              "name": "total_children",
              "label": "Total Children",
              "placeholder": "Select total children",
              "type": "single_select_dropdown",
              "dropdown_source": "totalChildrenList",
              "is_required": false,
              "show_if": {
                "field": "marital_status",
                "operator": "not_equal",
                "value": "Unmarried"
              }
            },
            {
              "name": "status_children",
              "label": "Children Living With",
              "placeholder": "Select children status",
              "type": "single_select_dropdown",
              "dropdown_source": "statusChildrenList",
              "is_required": false,
              "show_if": {
                "field": "total_children",
                "operator": "not_in",
                "value": ["0", "None", "No Children", "0 Children"]
              }
            },
            {
              "name": "mother_tongue",
              "label": "Mother Tongue",
              "placeholder": "Select mother tongue",
              "type": "single_select_dropdown",
              "dropdown_source": "motherTongueList",
              "is_required": true
            },
            {
              "name": "height",
              "label": "Height",
              "placeholder": "Select height",
              "type": "single_select_dropdown",
              "dropdown_source": "heightList",
              "is_required": true
            },
            {
              "name": "birthplace",
              "label": "Place of Birth",
              "placeholder": "Enter birth city",
              "type": "text",
              "is_required": false
            },
            {
              "name": "birthtime",
              "label": "Time of Birth",
              "placeholder": "HH:MM",
              "type": "time_picker",
              "is_required": false
            },
            {
              "name": "alternate_number",
              "label": "Alternate Contact Number",
              "placeholder": "Enter alternate phone number",
              "type": "phone_number",
              "is_required": false
            },
            {
              "name": "nri_country",
              "label": "Resident Country (NRI)",
              "placeholder": "Select resident country",
              "type": "single_select_dropdown",
              "dropdown_source": "countryList",
              "is_required": false
            },
            {
              "name": "residence_type",
              "label": "Residence Status",
              "placeholder": "Select residence status",
              "type": "single_select_dropdown",
              "dropdown_source": "residenceTypeList",
              "is_required": false
            },
            {
              "name": "residence_type_other",
              "label": "Visa Type / Details",
              "placeholder": "Enter visa type (e.g. H1-B, Student)",
              "type": "text",
              "is_required": false,
              "show_if": {
                "field": "residence_type",
                "operator": "contains",
                "value": "Temporary Resident"
              }
            }
          ]
        },
        {
          "step_number": 3,
          "step_key": "religious_info",
          "title": "Religious & Astro Details",
          "subtitle": "Add religious background & horoscope",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 2},
          "fields": [
            {
              "name": "religion",
              "label": "Religion",
              "placeholder": "Select religion",
              "type": "single_select_dropdown",
              "dropdown_source": "religionList",
              "is_required": true
            },
            {
              "name": "caste",
              "label": "Caste / Subcaste",
              "placeholder": "Select caste",
              "type": "dependent_dropdown",
              "parent_field": "religion",
              "dependency_api": "common-request/get-dependency-dropdown",
              "dependency_param": "religion_id",
              "is_required": true
            },
            {
              "name": "subcaste",
              "label": "Sub-Caste Details",
              "placeholder": "Enter sub-caste (if any)",
              "type": "text",
              "is_required": false
            },
            {
              "name": "manglik",
              "label": "Manglik Status",
              "placeholder": "Select manglik status",
              "type": "single_select_dropdown",
              "dropdown_source": "manglikList",
              "is_required": true
            },
            {
              "name": "star",
              "label": "Nakshatra / Star",
              "placeholder": "Select star",
              "type": "single_select_dropdown",
              "dropdown_source": "starList",
              "is_required": false
            },
            {
              "name": "moonsign",
              "label": "Rashi / Moon Sign",
              "placeholder": "Select moon sign",
              "type": "single_select_dropdown",
              "dropdown_source": "moonsignList",
              "is_required": false
            },
            {
              "name": "gothra",
              "label": "Gotra",
              "placeholder": "Enter gotra",
              "type": "text",
              "is_required": false
            },
            {
              "name": "horoscope",
              "label": "Horoscope Match Required?",
              "placeholder": "Select horoscope preference",
              "type": "single_select_dropdown",
              "dropdown_source": "horoscopeList",
              "is_required": false
            }
          ]
        },
        {
          "step_number": 4,
          "step_key": "location_info",
          "title": "Location Details",
          "subtitle": "Where are you currently residing?",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 3},
          "fields": [
            {
              "name": "country_id",
              "label": "Country",
              "placeholder": "Select country",
              "type": "single_select_dropdown",
              "dropdown_source": "countryList",
              "is_required": true
            },
            {
              "name": "state_id",
              "label": "State",
              "placeholder": "Select state",
              "type": "dependent_dropdown",
              "parent_field": "country_id",
              "dependency_api": "common-request/get-dependency-dropdown",
              "dependency_param": "country_id",
              "is_required": true
            },
            {
              "name": "city",
              "label": "City",
              "placeholder": "Select city",
              "type": "dependent_dropdown",
              "parent_field": "state_id",
              "dependency_api": "common-request/get-dependency-dropdown",
              "dependency_param": "state_id",
              "is_required": true
            },
            {
              "name": "pincode",
              "label": "Pin Code / Zip Code",
              "placeholder": "Enter pincode",
              "type": "number",
              "is_required": false,
              "validation": {"max_length": 10}
            },
            {
              "name": "address",
              "label": "Current Residential Address",
              "placeholder": "Enter address",
              "type": "textarea",
              "is_required": false,
              "max_lines": 3
            }
          ]
        },
        {
          "step_number": 5,
          "step_key": "education_career",
          "title": "Education & Career",
          "subtitle": "Your qualification and profession",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 4},
          "fields": [
            {
              "name": "education_level",
              "label": "Education Level",
              "placeholder": "Select highest qualifications",
              "type": "multi_select_dropdown",
              "dropdown_source": "educationMasterList",
              "is_required": true
            },
            {
              "name": "education_details",
              "label": "Education Detail / Degree",
              "placeholder": "e.g. B.Tech in Computer Science",
              "type": "text",
              "is_required": false
            },
            {
              "name": "employee_in",
              "label": "Employed In",
              "placeholder": "Select sector (e.g. Private / Govt)",
              "type": "single_select_dropdown",
              "dropdown_source": "employedInList",
              "is_required": true
            },
            {
              "name": "occupation",
              "label": "Occupation",
              "placeholder": "Select occupation",
              "type": "single_select_dropdown",
              "dropdown_source": "occupationList",
              "is_required": true
            },
            {
              "name": "designation_level",
              "label": "Designation",
              "placeholder": "Select designation",
              "type": "single_select_dropdown",
              "dropdown_source": "designationList",
              "is_required": false
            },
            {
              "name": "income",
              "label": "Annual Income",
              "placeholder": "Select income range",
              "type": "single_select_dropdown",
              "dropdown_source": "annualIncomeList",
              "is_required": true
            }
          ]
        },
        {
          "step_number": 6,
          "step_key": "lifestyle_habits",
          "title": "Lifestyle & Habits",
          "subtitle": "Your diet, habits & bio",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 5},
          "fields": [
            {
              "name": "diet",
              "label": "Diet / Food Habits",
              "placeholder": "Select diet",
              "type": "single_select_dropdown",
              "dropdown_source": "dietList",
              "is_required": true
            },
            {
              "name": "smoke",
              "label": "Smoking Habit",
              "placeholder": "Select smoking habit",
              "type": "single_select_dropdown",
              "dropdown_source": "smokeList",
              "is_required": true
            },
            {
              "name": "drink",
              "label": "Drinking Habit",
              "placeholder": "Select drinking habit",
              "type": "single_select_dropdown",
              "dropdown_source": "drinkList",
              "is_required": true
            },
            {
              "name": "about_me_description",
              "label": "About Myself",
              "placeholder": "Write a few lines about yourself...",
              "type": "textarea",
              "has_ai_generate": true,
              "ai_generate_endpoint": "register/generate-about-me",
              "is_required": true,
              "max_lines": 5,
              "validation": {"min_length": 15}
            }
          ]
        },
        {
          "step_number": 7,
          "step_key": "family_details",
          "title": "Family Details",
          "subtitle": "Information about your family",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 6},
          "fields": [
            {
              "name": "family_type",
              "label": "Family Type",
              "type": "single_select_dropdown",
              "dropdown_source": "familyTypeList",
              "is_required": true
            },
            {
              "name": "family_status",
              "label": "Family Status",
              "type": "single_select_dropdown",
              "dropdown_source": "familyStatusList",
              "is_required": true
            },
            {
              "name": "father_name",
              "label": "Father's Name",
              "placeholder": "Enter father's name",
              "type": "text",
              "is_required": true
            },
            {
              "name": "father_present",
              "label": "Father's Status",
              "type": "single_select_dropdown",
              "dropdown_source": "fatherStatusList",
              "is_required": true
            },
            {
              "name": "father_occupation",
              "label": "Father's Occupation",
              "type": "single_select_dropdown",
              "dropdown_source": "occupationList",
              "is_required": false
            },
            {
              "name": "mother_name",
              "label": "Mother's Name",
              "placeholder": "Enter mother's name",
              "type": "text",
              "is_required": true
            },
            {
              "name": "mother_present",
              "label": "Mother's Status",
              "type": "single_select_dropdown",
              "dropdown_source": "motherStatusList",
              "is_required": true
            },
            {
              "name": "mother_occupation",
              "label": "Mother's Occupation",
              "type": "single_select_dropdown",
              "dropdown_source": "occupationList",
              "is_required": false
            },
            {
              "name": "no_of_brothers",
              "label": "No. of Brothers",
              "type": "single_select_dropdown",
              "dropdown_source": "siblingCountList",
              "is_required": true
            },
            {
              "name": "no_of_married_brothers",
              "label": "No. of Married Brothers",
              "type": "single_select_dropdown",
              "dropdown_source": "siblingCountList",
              "is_required": false,
              "show_if": {
                "field": "no_of_brothers",
                "operator": "not_in",
                "value": ["0", "None", "No Brothers", "No brother"]
              }
            },
            {
              "name": "no_of_sisters",
              "label": "No. of Sisters",
              "type": "single_select_dropdown",
              "dropdown_source": "siblingCountList",
              "is_required": true
            },
            {
              "name": "no_of_married_sisters",
              "label": "No. of Married Sisters",
              "type": "single_select_dropdown",
              "dropdown_source": "siblingCountList",
              "is_required": false,
              "show_if": {
                "field": "no_of_sisters",
                "operator": "not_in",
                "value": ["0", "None", "No Sisters", "No sister"]
              }
            },
            {
              "name": "family_details",
              "label": "About Family",
              "placeholder": "Write a few words about your family...",
              "type": "textarea",
              "is_required": false,
              "max_lines": 3
            }
          ]
        },
        {
          "step_number": 8,
          "step_key": "photos",
          "title": "Upload Photos",
          "subtitle": "Add photos & take a selfie to verify your profile",
          "endpoint": "register/upload-photo",
          "http_method": "POST",
          "is_multipart": true,
          "extra_params": {"step": 7},
          "fields": [
            {
              "name": "selfie_image",
              "label": "Live Selfie Verification",
              "type": "selfie_capture",
              "is_required": true,
              "description": "Ensure your face is clearly visible in good lighting"
            },
            {
              "name": "photo1",
              "label": "Primary Profile Photo",
              "type": "photo_upload",
              "is_required": true,
              "aspect_ratio": "1:1"
            },
            {
              "name": "photo2",
              "label": "Gallery Photo 2",
              "type": "photo_upload",
              "is_required": false
            },
            {
              "name": "photo3",
              "label": "Gallery Photo 3",
              "type": "photo_upload",
              "is_required": false
            },
            {
              "name": "photo4",
              "label": "Gallery Photo 4",
              "type": "photo_upload",
              "is_required": false
            }
          ]
        },
        {
          "step_number": 9,
          "step_key": "id_proof",
          "title": "ID Verification",
          "subtitle": "Upload government ID to get verified badge",
          "endpoint": "register/upload-id-proof",
          "http_method": "POST",
          "is_multipart": true,
          "extra_params": {"step": 8},
          "fields": [
            {
              "name": "id_proof_type",
              "label": "Select ID Proof Type",
              "type": "segment_selector",
              "is_required": true,
              "default_value": "Aadhaar",
              "options": [
                {"id": "Aadhaar", "label": "Aadhaar", "subtitle": "Fastest verification"},
                {"id": "PAN Card", "label": "PAN Card", "subtitle": "Tax verified"},
                {"id": "Passport", "label": "Passport", "subtitle": "Global ID"},
                {"id": "License", "label": "License", "subtitle": "Driving ID"}
              ]
            },
            {
              "name": "id_proof_number",
              "label": "Document Number",
              "placeholder": "Enter ID document number",
              "type": "text",
              "is_required": true
            },
            {
              "name": "id_proof_front",
              "label": "Front Side Document",
              "type": "file_upload",
              "is_required": true
            },
            {
              "name": "id_proof_back",
              "label": "Back Side Document",
              "type": "file_upload",
              "is_required": false
            }
          ]
        },
        {
          "step_number": 10,
          "step_key": "partner_preferences",
          "title": "Partner Preferences",
          "subtitle": "Set your desired match criteria",
          "endpoint": "register/next-step",
          "http_method": "POST",
          "extra_params": {"step": 9},
          "fields": [
            {
              "name": "part_age_range",
              "label": "Partner Age (Years)",
              "type": "range_slider",
              "min_val": 18,
              "max_val": 70,
              "default_range": [18, 50],
              "is_required": true
            },
            {
              "name": "part_height_range",
              "label": "Partner Height (cm)",
              "type": "range_slider",
              "min_val": 120,
              "max_val": 220,
              "default_range": [130, 200],
              "is_required": true
            },
            {
              "name": "part_marital_status",
              "label": "Marital Status",
              "placeholder": "Select marital status",
              "type": "multi_select_dropdown",
              "dropdown_source": "maritalStatusList",
              "is_required": false
            },
            {
              "name": "part_religion",
              "label": "Religion",
              "placeholder": "Select preferred religions",
              "type": "multi_select_dropdown",
              "dropdown_source": "religionList",
              "is_required": false
            },
            {
              "name": "part_caste",
              "label": "Caste",
              "placeholder": "Select preferred castes",
              "type": "multi_select_dropdown",
              "parent_field": "part_religion",
              "dependency_api": "common-request/get-dependency-dropdown",
              "is_required": false
            },
            {
              "name": "part_country",
              "label": "Country",
              "placeholder": "Select preferred countries",
              "type": "multi_select_dropdown",
              "dropdown_source": "countryList",
              "is_required": false
            },
            {
              "name": "part_education",
              "label": "Education",
              "placeholder": "Select preferred education",
              "type": "multi_select_dropdown",
              "dropdown_source": "educationMasterList",
              "is_required": false
            },
            {
              "name": "part_occupation",
              "label": "Occupation",
              "placeholder": "Select preferred occupations",
              "type": "multi_select_dropdown",
              "dropdown_source": "occupationList",
              "is_required": false
            },
            {
              "name": "part_income",
              "label": "Annual Income",
              "placeholder": "Select minimum annual income",
              "type": "single_select_dropdown",
              "dropdown_source": "annualIncomeList",
              "is_required": false
            },
            {
              "name": "part_manglik",
              "label": "Manglik Status",
              "placeholder": "Select preferred manglik status",
              "type": "multi_select_dropdown",
              "dropdown_source": "manglikList",
              "is_required": false
            }
          ]
        }
      ]
    });
  }
}

/// Represents one step/section of the dynamic form
class FormSection {
  final int stepNumber;
  final String stepKey;
  final String title;
  final String subtitle;
  final String endpoint;
  final String httpMethod;
  final bool isMultipart;
  final Map<String, dynamic> extraParams;
  final List<FormFieldModel> fields;

  const FormSection({
    required this.stepNumber,
    required this.stepKey,
    required this.title,
    required this.subtitle,
    required this.endpoint,
    this.httpMethod = 'POST',
    this.isMultipart = false,
    this.extraParams = const {},
    required this.fields,
  });

  factory FormSection.fromJson(Map<String, dynamic> json) {
    final rawFields = json['fields'] as List<dynamic>? ?? [];
    return FormSection(
      stepNumber: json['step_number'] as int? ?? 1,
      stepKey: json['step_key']?.toString() ?? 'step_${json['step_number'] ?? 1}',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      endpoint: json['endpoint']?.toString() ?? 'register/next-step',
      httpMethod: json['http_method']?.toString() ?? 'POST',
      isMultipart: json['is_multipart'] as bool? ?? false,
      extraParams: (json['extra_params'] as Map<String, dynamic>?) ?? {},
      fields: rawFields
          .map((f) => FormFieldModel.fromJson(f as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'step_number': stepNumber,
        'step_key': stepKey,
        'title': title,
        'subtitle': subtitle,
        'endpoint': endpoint,
        'http_method': httpMethod,
        'is_multipart': isMultipart,
        'extra_params': extraParams,
        'fields': fields.map((f) => f.toJson()).toList(),
      };
}

/// Represents a single field inside a section
class FormFieldModel {
  final String name;
  final String label;
  final String placeholder;
  final String type;
  final String? icon;
  final bool isRequired;
  final dynamic defaultValue;
  final List<FieldOption>? options;
  final String? dropdownSource;
  final String? parentField;
  final String? dependencyApi;
  final String? dependencyParam;
  final ValidationRule? validation;
  final VisibilityCondition? showIf;
  final bool hasAiGenerate;
  final String? aiGenerateEndpoint;
  final String? aspectRatio;
  final String? description;
  final int maxLines;
  final double? minVal;
  final double? maxVal;
  final List<double>? defaultRange;

  const FormFieldModel({
    required this.name,
    required this.label,
    this.placeholder = '',
    required this.type,
    this.icon,
    this.isRequired = false,
    this.defaultValue,
    this.options,
    this.dropdownSource,
    this.parentField,
    this.dependencyApi,
    this.dependencyParam,
    this.validation,
    this.showIf,
    this.hasAiGenerate = false,
    this.aiGenerateEndpoint,
    this.aspectRatio,
    this.description,
    this.maxLines = 1,
    this.minVal,
    this.maxVal,
    this.defaultRange,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    List<FieldOption>? opts;
    if (json['options'] is List) {
      opts = (json['options'] as List)
          .map((o) => FieldOption.fromJson(o as Map<String, dynamic>))
          .toList();
    }

    List<double>? range;
    if (json['default_range'] is List) {
      range = (json['default_range'] as List)
          .map((e) => double.tryParse(e.toString()) ?? 0.0)
          .toList();
    }

    return FormFieldModel(
      name: json['name']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      placeholder: json['placeholder']?.toString() ?? '',
      type: json['type']?.toString() ?? 'text',
      icon: json['icon']?.toString(),
      isRequired: json['is_required'] as bool? ?? false,
      defaultValue: json['default_value'],
      options: opts,
      dropdownSource: json['dropdown_source']?.toString(),
      parentField: json['parent_field']?.toString(),
      dependencyApi: json['dependency_api']?.toString(),
      dependencyParam: json['dependency_param']?.toString(),
      validation: json['validation'] != null
          ? ValidationRule.fromJson(json['validation'] as Map<String, dynamic>)
          : null,
      showIf: json['show_if'] != null
          ? VisibilityCondition.fromJson(json['show_if'] as Map<String, dynamic>)
          : null,
      hasAiGenerate: json['has_ai_generate'] as bool? ?? false,
      aiGenerateEndpoint: json['ai_generate_endpoint']?.toString(),
      aspectRatio: json['aspect_ratio']?.toString(),
      description: json['description']?.toString(),
      maxLines: json['max_lines'] as int? ?? 1,
      minVal: json['min_val'] != null ? double.tryParse(json['min_val'].toString()) : null,
      maxVal: json['max_val'] != null ? double.tryParse(json['max_val'].toString()) : null,
      defaultRange: range,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'label': label,
        'placeholder': placeholder,
        'type': type,
        'icon': icon,
        'is_required': isRequired,
        'default_value': defaultValue,
        'options': options?.map((o) => o.toJson()).toList(),
        'dropdown_source': dropdownSource,
        'parent_field': parentField,
        'dependency_api': dependencyApi,
        'dependency_param': dependencyParam,
        'validation': validation?.toJson(),
        'show_if': showIf?.toJson(),
        'has_ai_generate': hasAiGenerate,
        'ai_generate_endpoint': aiGenerateEndpoint,
        'aspect_ratio': aspectRatio,
        'description': description,
        'max_lines': maxLines,
        'min_val': minVal,
        'max_val': maxVal,
        'default_range': defaultRange,
      };
}

/// Validation rules for a field
class ValidationRule {
  final int? minLength;
  final int? maxLength;
  final String? regex;
  final String? errorMessage;
  final String? matchField;
  final int? minAgeMale;
  final int? minAgeFemale;
  final int? minDigits;
  final int? maxDigits;
  final bool? mustBeChecked;

  const ValidationRule({
    this.minLength,
    this.maxLength,
    this.regex,
    this.errorMessage,
    this.matchField,
    this.minAgeMale,
    this.minAgeFemale,
    this.minDigits,
    this.maxDigits,
    this.mustBeChecked,
  });

  factory ValidationRule.fromJson(Map<String, dynamic> json) {
    return ValidationRule(
      minLength: json['min_length'] as int?,
      maxLength: json['max_length'] as int?,
      regex: json['regex']?.toString(),
      errorMessage: json['error_message']?.toString(),
      matchField: json['match_field']?.toString(),
      minAgeMale: json['min_age_male'] as int?,
      minAgeFemale: json['min_age_female'] as int?,
      minDigits: json['min_digits'] as int?,
      maxDigits: json['max_digits'] as int?,
      mustBeChecked: json['must_be_checked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'min_length': minLength,
        'max_length': maxLength,
        'regex': regex,
        'error_message': errorMessage,
        'match_field': matchField,
        'min_age_male': minAgeMale,
        'min_age_female': minAgeFemale,
        'min_digits': minDigits,
        'max_digits': maxDigits,
        'must_be_checked': mustBeChecked,
      };
}

/// Visibility condition for a field
class VisibilityCondition {
  final String field;
  final String operator;
  final dynamic value;

  const VisibilityCondition({
    required this.field,
    required this.operator,
    required this.value,
  });

  factory VisibilityCondition.fromJson(Map<String, dynamic> json) {
    return VisibilityCondition(
      field: json['field']?.toString() ?? '',
      operator: json['operator']?.toString() ?? 'equals',
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'field': field,
        'operator': operator,
        'value': value,
      };

  bool isVisible(Map<String, dynamic> currentValues) {
    final currentVal = currentValues[field];
    if (currentVal == null) return false;

    // Extract string identifiers and display values from currentVal
    final List<String> currentStrings = [];

    void extractStrings(dynamic item) {
      if (item == null) return;
      if (item is DropdownOptionModel) {
        if (item.val != null) {
          final s = item.val.toString().toLowerCase().trim();
          if (s.isNotEmpty) currentStrings.add(s);
        }
        if (item.id != null) {
          final s = item.id.toString().toLowerCase().trim();
          if (s.isNotEmpty) currentStrings.add(s);
        }
      } else if (item is List) {
        for (var sub in item) {
          extractStrings(sub);
        }
      } else if (item is Map) {
        final v = item['val'] ?? item['value'] ?? item['name'] ?? item['label'];
        final id = item['id'];
        if (v != null) {
          final s = v.toString().toLowerCase().trim();
          if (s.isNotEmpty) currentStrings.add(s);
        }
        if (id != null) {
          final s = id.toString().toLowerCase().trim();
          if (s.isNotEmpty) currentStrings.add(s);
        }
      } else {
        final s = item.toString().toLowerCase().trim();
        if (s.isNotEmpty) currentStrings.add(s);
      }
    }

    extractStrings(currentVal);

    if (currentStrings.isEmpty) {
      return false;
    }

    // Helper to check if any of currentStrings matches a target object/string
    bool matchesTarget(dynamic target) {
      if (target == null) return false;
      final tStr = target.toString().toLowerCase().trim();

      return currentStrings.any((c) {
        if (c == tStr) return true;
        // Synonym matching for marital status
        if ((tStr == 'unmarried' || tStr == 'never married' || tStr == 'single') &&
            (c == 'unmarried' || c == 'never married' || c == 'single')) {
          return true;
        }
        // Synonym matching for 0/none
        if ((tStr == 'none' || tStr == '0' || tStr == 'no children' || tStr == '0 children') &&
            (c == 'none' || c == '0' || c == 'no children' || c == '0 children' || c == 'no')) {
          return true;
        }
        return false;
      });
    }

    switch (operator) {
      case 'equals':
      case 'equal':
      case '==':
        if (value is List) {
          return (value as List).any((v) => matchesTarget(v));
        }
        return matchesTarget(value);

      case 'not_equal':
      case '!=':
        if (value is List) {
          return !(value as List).any((v) => matchesTarget(v));
        }
        return !matchesTarget(value);

      case 'in':
        if (value is List) {
          return (value as List).any((v) => matchesTarget(v));
        }
        return matchesTarget(value);

      case 'not_in':
        if (value is List) {
          return !(value as List).any((v) => matchesTarget(v));
        }
        return !matchesTarget(value);

      case 'contains':
        final tStr = value?.toString().toLowerCase().trim() ?? '';
        return currentStrings.any((c) => c.contains(tStr));

      case 'not_empty':
      case 'is_not_empty':
        return currentStrings.isNotEmpty && currentStrings.any((s) => s.isNotEmpty);

      case 'empty':
      case 'is_empty':
        return currentStrings.isEmpty;

      default:
        return true;
    }
  }
}

/// Option item for segment selectors / radio groups
class FieldOption {
  final String id;
  final String label;
  final String? icon;
  final String? subtitle;

  const FieldOption({
    required this.id,
    required this.label,
    this.icon,
    this.subtitle,
  });

  factory FieldOption.fromJson(Map<String, dynamic> json) {
    return FieldOption(
      id: json['id']?.toString() ?? '',
      label: json['label']?.toString() ?? json['name']?.toString() ?? '',
      icon: json['icon']?.toString(),
      subtitle: json['subtitle']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'icon': icon,
        'subtitle': subtitle,
      };
}
