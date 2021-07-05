class GroupOption {
  /// 选项的值，即ID，必须传入。
  final String name;

  /// 选项的标题，必须传入。
  final String title;

  /// 选项的内容，即解释文本。
  final String? content;

  /// 选项是否被禁用，即是否只读(readonly)，默认为`false`。
  final bool disabled;

  const GroupOption({
    required this.name,
    required this.title,
    this.content,
    this.disabled = false,
  });
}
