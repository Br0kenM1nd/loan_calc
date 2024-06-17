import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool allowFloat;
  final double min;
  final double max;

  const InputFieldWidget({
    required this.controller,
    required this.labelText,
    this.allowFloat = true,
    this.min = 1.0,
    this.max = 100.0,
    super.key,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  double _currentValue = 0;

  String? _firstValidator(String? value) {
    if (value == null || value.isEmpty) return 'Пожалуйста, заполните поле';
    final numValue = double.tryParse(value);
    return switch (numValue) {
      == null => 'Должно быть введено число',
      < 0 => 'Значение должно быть положительным',
      == 0 => 'Значение не должно равняться 0',
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextFormFieldRow(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CupertinoColors.inactiveGray),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            widget.allowFloat
                ? FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                : FilteringTextInputFormatter.digitsOnly,
          ],
          controller: widget.controller,
          validator: _firstValidator,
        ),

        // Линейный ввод неудобен для больших значений
        // Логарифмический ввод не удобен, так как выдаёт неточные значения
        // Расчёт шага не универсален для разных значений
        SizedBox(
          width: double.infinity,
          child: CupertinoSlider(
            min: widget.min,
            max: widget.max,
            value: _currentValue,
            onChanged: (newValue) {
              setState(() {
                _currentValue = _roundToStep(newValue, _getStepSize(newValue));
                widget.controller.text = _currentValue.toStringAsFixed(widget.allowFloat ? 2 : 0);
              });
            },
          ),
        ),
      ],
    );
  }

  double _getStepSize(double value) => switch (value) {
        <= 100 => 1,
        <= 1e5 => 1e3,
        <= 1e6 => 1e4,
        _ => 1e5,
      };

  double _roundToStep(double value, double stepSize) => (value / stepSize).round() * stepSize;
}
