# CheckBox & CheckGroup

### 复选框/复选框组(多项选择)

能力及接口参考：[TDesign Mobile CheckBox](http://tdesign.woa.com/vue-mobile/components/checkbox)

### 使用示例

- TDCheckBox - 单个复选框

```dart
TDCheckBox(
  name: '1.1',
  title: '单行标题',
  onChange: (selected, name) {
    setState(() {
      this.selected = selected;
    });
  },
)
```

- TDCheckGroup - 复选框群组(多项选择)

```dart
TDCheckGroup(
  options: [
    GroupOption(name: '选项一', title: '选项一'),
    GroupOption(name: '选项二', title: '选项二'),
    GroupOption(name: '选项三', title: '选项三'),
  ]);
```



### API

#### TDCheckBox

**Properties**

(带下划线表示TDTheme主题中定义的属性)

| 属性                  | 类型                                           | 默认值                           | 必传 | 说明                                               |
| --------------------- | ---------------------------------------------- | -------------------------------- | ---- | -------------------------------------------------- |
| name                  | String                                         |                                  | Y    | 选项的值，即ID，必须传入。                         |
| title                 | String                                         |                                  | Y    | 选项展示的标题，必须传入。                         |
| content               | String?                                        |                                  | N    | 选项额外的解释文本。                               |
| disabled              | bool                                           | false                            | N    | 选项是否被禁用，即是否只读(readonly)。             |
| contentDisabled       | Bool                                           | false                            | N    | 文本区域能否被点击。若不能，则仅icon部分点击有效。 |
| limitTitleRow         | int                                            | 1                                | N    | 标题`title`部分的行数限制。                        |
| limitContentRow       | int                                            | 1                                | N    | 内容`content`部分的行数限制。                      |
| checkedColor          | Color?                                         | <u>primaryColor</u> (0xFF0052D9) | N    | 选中图标的颜色，仅在使用默认图标时生效。           |
| defaultSelected       | bool                                           | false                            | N    | 默认的选中状态，即是否选中。                       |
| selectedIconBuilder   | Widget IconBuilder(TDTheme? theme)             |                                  | N    | 自定义选中时的左侧icon的Builder                    |
| unselectedIconBuilder | Widget IconBuilder(TDTheme? theme)             |                                  | N    | 自定义未选中时的左侧icon的Builder                  |
| onChange              | void OnChangeSingle(bool checked, String name) |                                  | N    | 选项选中状态变化的回调                             |

#### TDCheckGroup

**Properties**

| 属性                  | 类型                                      | 默认值                           | 必传 | 说明                                                         |
| --------------------- | ----------------------------------------- | -------------------------------- | ---- | ------------------------------------------------------------ |
| options               | List\<String>                             |                                  | Y    | 选项信息实例的列表，必须传入，选项的数量由列表长度决定，长度不可为0。 |
| defaultSelected       | List\<String>                             |                                  | N    | 默认初始状态为选中的选项的id列表。                           |
| contentDisabled       | bool                                      | false                            | N    | 文本区域能否被点击。默认为`false`。群组中所有选项统一配置。  |
| limitTitleRow         | int                                       | 1                                | N    | 标题的行数限制，所有选项统一配置。                           |
| limitContentRow       | int                                       | 1                                | N    | 内容的行数限制，所有选项统一配置。                           |
| checkedColor          | Color?                                    | <u>primaryColor</u> (0xFF0052D9) | N    | 选中图标的颜色，仅在使用默认图标时生效。所有选项统一配置。   |
| selectedIconBuilder   | Widget IconBuilder(TDTheme? theme)        |                                  | N    | 自定义选中时的左侧icon的Builder，所有选项统一配置。          |
| unselectedIconBuilder | Widget IconBuilder(TDTheme? theme)        |                                  | N    | 自定义未选中时的左侧icon的Builder，所有选项统一配置。        |
| onChange              | void OnChangeGroup(List\<String> checked) |                                  | N    | 选项选中状态变化的回调。                                     |
| controller            | TDCheckGroupController?                   |                                  | N    | 控制器，用于从使用侧控制选择或取消选项、反选、全选和全部取消。 |
| separatorWidget       | Widget?                                   |                                  | N    | 可选的选项之间的分割widget。                                 |
| selectLimit           | int?                                      |                                  | N    | 最多可以选择群组内的几项，为空时无限制。使用controller进行的外部控制操作不受约束。 |

**Operations - TDCheckGroupController**

| 方法                     | 功能                                                         |
| ------------------------ | ------------------------------------------------------------ |
| toggleAll({bool? check}) | 控制所有选项。`check`为`null`时，操作为反选；为`true`时，操作为全选；为`false`时，操作为全部取消； |
| toggle(String name)      | 反选某一选项，传入的`name`为该选项的`name`                   |
| check(String name)       | 选择某一选项，传入的`name`为该选项的`name`                   |
| uncheck(String name)     | 取消选择某一选项，传入的`name`为该选项的`name`               |



### Design config

(带下划线表示和TDTheme主题相关)

| 属性                   | 数值                            |
| ---------------------- | ------------------------------- |
| 默认的选中icon大小     | <u>iconX</u> (24)               |
| 默认的选中icon         | checkCircleFilled               |
| 默认未选中圆圈颜色     | <u>bgIconFade</u> (0xFFCCCCCC)  |
| 选项被禁用时透明度     | 0.4                             |
| 选项icon四周padding    | 8                               |
| title文字字体大小      | <u>fontSizeL</u> (16)           |
| content文字字体大小    | <u>fontSizeBase</u> (14)        |
| content文字颜色        | <u>textColorL3</u> (0x66000000) |
| title和content之间间距 | <u>spacer</u> (6)               |

