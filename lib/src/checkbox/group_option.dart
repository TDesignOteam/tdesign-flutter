/// `RadioGroup`和`CheckGroup`中的单个选项的数据类
/// 使用示例：
/// ``` dart
/// CheckGroup(
///   options: [
///     GroupOption(name: '选项一', title: '选项一'),
///     GroupOption(name: '选项二', title: '选项二'),
///     GroupOption(name: '选项三', title: '选项三'),
///   ])
/// ```
class TDGroupOption {
  /// 选项的值，即ID，必须传入。
  final String name;

  /// 选项的标题，必须传入。
  final String title;

  /// 选项的内容，即解释文本。
  final String? content;

  /// 选项是否被禁用，即是否只读(readonly)，默认为`false`。
  final bool disabled;

  const TDGroupOption({
    required this.name,
    required this.title,
    this.content,
    this.disabled = false,
  });
}
