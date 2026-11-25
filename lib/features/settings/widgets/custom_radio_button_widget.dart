import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pro_matrimony/app_theme/size_config.dart';
import 'package:pro_matrimony/utils/utils.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            const Gap(5),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? appPrimaryColor : Colors.grey,
              size: getProportionateScreenWidth(26),
            ),
            const Gap(10),
            Expanded(child: customTextSemiBoldStyle(label, getProportionateScreenWidth(15), TextAlign.start, isSelected ? appPrimaryColor : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)))
          ],
        ),
      ),
    );
  }
}