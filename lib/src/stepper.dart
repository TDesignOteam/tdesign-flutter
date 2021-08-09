import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 默认配置项
abstract class _Default {
  // Stepper组件数值增减的默认步长。
  static const step = 1;

  // Stepper组件默认的最小值。
  static const min = 0;

  // Stepper组件默认的最大值。
  static const max = 10000;

  // Stepper组件是否屏蔽点击事件。
  static const disabled = false;

  // Stepper组件的输入框默是否屏蔽输入事件。
  static const disableInput = false;

  // Stepper组件的输入框默的默认宽度。
  static const inputWidth = 80;
}

/// 步进器组件
///
/// 能力及接口参考：[TDesign Mobile Stepper](http://tdesign.woa.com/vue-mobile/components/stepper)
///
/// 使用示例：
/// ```dart
/// TDStepper(
///   value: 10,
///   min: -10,
///   max: 1000,
///   onChanged: (value) {
///     print('value: $value');
///   },
/// ),
/// ```
class TDStepper extends StatefulWidget {
  const TDStepper({
    Key? key,
    required this.value,
    required this.label,
    this.step = _Default.step,
    this.min = _Default.min,
    this.max = _Default.max,
    this.disabled = _Default.disabled,
    this.disableInput = _Default.disableInput,
    this.inputWidth = _Default.inputWidth,
    this.onChanged,
  })  : assert(step > 0, 'step must be greater than 0!'),
        assert(value >= min && value <= max, 'value must be in [min, max]!'),
        assert(inputWidth > 0, 'inputWidth must be greater than 0!'),
        super(key: key);

  /// Stepper显示的数值。
  ///
  /// 该数值的大小必须在[min]和[max]之间，可以通过点击两侧按钮来增减，也可以通过输入框输入。
  final int value;

  /// Stepper左侧显示的文字标题。
  ///
  /// 文字标题只会作一行显示，超出部分会通过`TextOverflow.ellipsis`方式省略。
  final String label;

  /// Stepper是否屏蔽点击事件。
  ///
  /// 默认值为`false`，将会影响输入框和左右两侧的按钮。
  final bool disabled;

  /// Stepper组件数值增减的步长。
  ///
  /// 默认值为`1`，点击输入框两侧按钮后，[value]会进行相应的增减。
  final int step;

  /// Stepper组件数值的最小值。
  ///
  /// 默认值为`0`，当[value]和[min]相等时，将会屏蔽左侧按钮的事件。
  final int min;

  /// Stepper组件数值的最小值。
  ///
  /// 默认值为`10000`，当[value]和[min]相等时，将会屏蔽左侧按钮的事件。
  final int max;

  /// 输入框是否屏蔽事件。
  ///
  /// 默认值为`false`，当为`true`时，用户将不能通过输入框改变[value]，只能通过两侧按钮改变其大小。
  final bool disableInput;

  /// 输入框的宽度。
  ///
  /// 默认值为`80`。
  final int inputWidth;

  /// 输入框中值发生变化时执行的回调方法。
  ///
  /// 该回调方法需要接受一个`String`类型的参数，为输入框中的字符串的值
  ///
  /// ```dart
  /// TDStepper(
  ///   value: 10,
  ///   onChanged: (value) {
  ///     ...
  ///     do something with this value
  ///     ...
  ///   },
  /// ),
  /// ```
  final ValueChanged<String>? onChanged;

  @override
  State<StatefulWidget> createState() => _TDStepperState();
}

class _TDStepperState extends State<TDStepper> {
  late TextEditingController _controller;
  late int _displayValue;
  late bool _enableMinus;
  late bool _enablePlus;

  @override
  void initState() {
    super.initState();
    _displayValue = widget.value;
    _enableMinus = widget.value != widget.min;
    _enablePlus = widget.value != widget.max;
    _controller = TextEditingController(text: _displayValue.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !widget.disabled ? 1.0 : 0.5,
      child: IgnorePointer(
        ignoring: widget.disabled,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              _buildLabel(),
              _buildIcon(align: 'left'),
              _buildInputText(),
              _buildIcon(align: 'right'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Expanded(
      child: Text(
        widget.label,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildInputText() {
    return Container(
      constraints: BoxConstraints(maxWidth: 80),
      child: TextField(
        decoration: null,
        controller: _controller,
        textAlign: TextAlign.center,
        enabled: !widget.disableInput && !widget.disabled,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          // 输入框只能接受整数输入，包括所有负整数、正整数和0
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$'))
        ],
        onChanged: (text) => _onChanged(text),
      ),
    );
  }

  Widget _buildIcon({required String align}) {
    return Opacity(
      opacity: widget.disabled || (align == 'left' ? _enableMinus : _enablePlus) ? 1.0 : 0.5,
      child: IgnorePointer(
        ignoring: align == 'left' ? !_enableMinus : !_enablePlus,
        child: GestureDetector(
          child: align == 'left' ? Icon(Icons.remove) : Icon(Icons.add),
          onTap: () => _onTap(align),
        ),
      ),
    );
  }

  _onTap(String align) {
    var tempValue = _displayValue;
    var step = (align == 'left') ? -widget.step : widget.step;

    // 更新value的时候会自动将其限定在[min, max]
    tempValue = (tempValue + step).clamp(widget.min, widget.max);
    _updateValue(tempValue);
  }

  _onChanged(String text) {
    /**
     * 当textField中的值发生变化时执行
     * 需要判断当前的 `text` 是不是一个数值，因为接受输入的时候包含所有整数，
     * 当用户欲输入一个负数，且只输入了 `-` 时，不执行 [onChanged] 回调方法
     */
    var numbers = RegExp(r'^-?\d+$');
    if (numbers.hasMatch(text)) {
      _updateValue(int.parse(text).clamp(widget.min, widget.max));
    }
  }

  _updateValue(int value) {
    // 更新输入框的值，并将光标移至末尾
    _displayValue = value;
    _controller.value = TextEditingValue(
      text: _displayValue.toString(),
      selection: TextSelection.collapsed(
        offset: _displayValue.toString().length,
      ),
    );

    // 调用回调方法
    if (widget.onChanged != null) {
      widget.onChanged!(_displayValue.toString());
    }

    // 根据value的变化来判断是否需要更新widget，以禁用或者解禁icon
    if (_enableMinus != (value != widget.min) || _enablePlus != (value != widget.max)) {
      setState(() {
        _enableMinus = value != widget.min;
        _enablePlus = value != widget.max;
      });
    }
  }
}
