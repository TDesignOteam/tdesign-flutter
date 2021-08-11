# Dialog


Dialog - 弹窗组件


能力及接口参考：[TDesign Mobile Dialog](http://tdesign.woa.com/vue-mobile/components/dialog)


## 使用示例


```dart

tdDialogBase.showCenterDialog(
    dialog: TDAlertDialog(
      title: '对话框标题',
      confirmText: '知道了',
    ),
    context: context);


tdDialogBase.showCenterDialog(
    dialog: TDActionDialog(
      list: ['按钮文案文字内容较长'],
      onItemClick: (index) {
      },
      title: '对话框标题',
      describe: '告知当前状态、信息和解决方法，等内容。描述文案尽可能控制在三行内',
    ),
    context: context);
```


## API

### 弹出层API
`tdDialogBase`作为弹窗辅助类，暂时提供了两种弹窗方式
`showCenterDialog` 方法为弹出一个屏幕居中布局的界面，传入布局即可。
`showBottomSheet` 方法为弹出一个底部适配高度的布局界面。
**Properties** **
| 属性      | 类型         | 默认值      | 必传 | 说明                                                         
| ------ | ----- | ----- | -------- | ------------ |
| sheet | Widget |  | Y | 内部做了圆角为10的裁剪，不需要在布局外部做裁剪 |
| context |BuildContext |  | Y | 只用作弹窗使用上下文，不做其余使用 |
| heightPercent | double? | 0.66 | N | 弹窗最大高度百分比 |
| offset | double? | 0 | N | 高度为基础的向下便宜|

### 弹窗布局API
`TDConfirmDialog`普通确认弹窗
| 属性      | 类型         | 默认值      | 必传 | 说明                                                         
| --------- | ------------ | -------------- | -------- | ---------------- |
| confirm     | String?       |    确认     | N    |   |
| title     | String |             | Y    | 弹窗的标题 |
| cancel | String?  |             取消                  | N    | 取消按钮的文字|
| describe   | String?       |                       | N    | 弹窗的描述文字       |
| onWhetherClick  | Function(bool, String?)      |      | N    | 点击事件的回调，如果为确认弹窗，则返回bool值为是否选中，第二个参数在此处不使用。，如果不传递方法则默认点击关闭。传递了方法则外部控制关闭逻辑 |
| primary     | bool?       | true  | N    | 设置弹窗主题样式，true则会主题色，false则为告警色  | 

`TDAlertDialog`普通告警弹窗
| 属性      | 类型         | 默认值      | 必传 | 说明                                                         
| --------- | ------------ | -------------- | -------- | ---------------- |
| confirmText     | String?       |    确认     | N    | 按钮文字  |
| title     | String |             | Y    | 弹窗的标题 |
| describe   | String?       |                       | N    | 弹窗的描述文字       |
| onConfirm  | VoidCallback?  |   |N    |点击确认按钮的回调。不传则默认点击关闭弹窗

`TDActionDialog`列表式操作弹框
| 属性      | 类型         | 默认值      | 必传 | 说明                                                         
| --------- | ------------ | -------------- | -------- | ---------------- |
| list     | List<String>?       |         | Y    | 选择项文字数组  |
| cancel     | String? |             | N    | 取消选项的文字 |
| describe   | String?       |                       | N    | 弹窗的描述文字       |
| onItemClick   | Function(int index)?       |        | Y    | 选中第几项的回调方法，不包括取消      |
| onCancelClick   | Function()?       |        | N  | 选中取消的回调方法，不传的话则默认关闭弹窗      |
    

`TInputDialog` 输入确认类型弹窗
| 属性      | 类型         | 默认值      | 必传 | 说明                                                         
| --------- | ------------ | -------------- | -------- | ---------------- |
| confirm     | String?       |    确认     | N    | 按钮文字  |
| title     | String |             | Y    | 弹窗的标题 |
| describe   | String?       |                       | N    | 弹窗的描述文字       |
| cancel  |  String?  |   |N    | 取消的文字按钮
| onWhetherClick  | Function(bool, String?)      |      | N    | 点击事件的回调，如果为确认弹窗，则返回bool值为是否选中，如果不传递方法则默认点击关闭。传递了方法则外部控制关闭逻辑,返回String为输入参数 |
| controller  | TextEditingController  |   |Y    | 文本编辑器的控制器


## Design config

### 通用属性

  | 属性                | 默认值                           | 设置主题色参数
  | ------------------- | ------------------------------ |
  | 高亮选择颜色    | `0xFF0052D9`     |    `primaryColor` |
    | 告警高亮颜色    | `0xFFE34D59`     |    `errorColor` |
    
    


