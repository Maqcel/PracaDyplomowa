import 'package:flutter/material.dart';
import 'package:praca_inz/config/dimensions/padding_dimension.dart';
import 'package:praca_inz/config/dimensions/radius_dimension.dart';
import 'package:praca_inz/config/theme/color_palette.dart';
import 'package:praca_inz/extensions/build_context_extension.dart';

class OnboardingGroupPicker extends StatelessWidget {
  final String _currentValue;
  final List<String> _groups;
  final Function({String? groupId}) _onDropdownChange;

  const OnboardingGroupPicker({
    Key? key,
    required String currentValue,
    required List<String> groups,
    required Function({String? groupId}) onDropdownChange,
  })  : _currentValue = currentValue,
        _groups = groups,
        _onDropdownChange = onDropdownChange,
        super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: PaddingDimension.small),
        child: Container(
          decoration: const BoxDecoration(
            color: ColorPalette.colorBasic0,
            borderRadius: BorderRadius.all(RadiusDimension.circularMedium),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingDimension.medium),
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: ColorPalette.colorBasic0,
              borderRadius:
                  const BorderRadius.all(RadiusDimension.circularMedium),
              icon: Icon(
                Icons.group_rounded,
                color: context.theme.backgroundColor,
              ),
              value: _currentValue,
              onChanged: (picked) => _onDropdownChange(groupId: picked),
              items: _groups
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}
