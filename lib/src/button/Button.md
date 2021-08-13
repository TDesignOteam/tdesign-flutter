# Button


Button - 按钮组件


能力及接口参考：[TDesign Mobile Button](http://tdesign.woa.com/vue-mobile/components/button/)


## 使用示例


```dart

TDButton(
  onClick: () {},
  text: '强按钮',
),


TDButton(
  icon: Icon(Icons.android, color: TDColors.blue),
  style: TDButtonStyle.stroke,
  onClick: () {},
  text: '带图标按钮',
),

```


## API

**Properties** **

| 属性      | 类型         | 默认值      | 必传 | 说明                                                         
| --------- | ------------ | -------------- | -------- | ---------------- |
| text     | String?       |                                          | N    | 按钮的文本展示，如果不传的话，则没有文字，text和icon需至少传入一个，否则不展示按钮  |
| onClick     | VoidCallback? |                                    | N    | 点击事件的回调方法，包括控制整个按钮的disable样式状态，如果不传，则是disable状态。不会有按压态。 |
| style | TDButtonStyle?  | TDButtonStyle.normal                                   | N    | enum{normal, stroke, secondary, warn, warnStroke, text, ghost}。分别对应如Example工程中的不同类型按钮|
| icon   | Widget?      |                                          | N    | 按钮左侧的图标控件，需要自己根据按钮样式来设置颜色传入。内部不进行处理。                 |
| size   | TDButtonSize?      |  TDButtonSize.mid                                        | N    | enum{large, mid, small, tint}，按钮的默认大小， large和mid均会填满父布局，samll和tint都遵循设计稿的内间距实现 |
| textStyle     | TextStyle?       |   | N    | 需要独立设置的文字样式 根据 TDButtonSize 以及  TDButtonStyle 匹配的不同字体样式 会进行不同的设置  | 
| radius | BorderRadiusGeometry?       | 默认为4的圆角大小 | N    | 背景圆角大小  |


## Design config

### 通用属性

  | 属性                | 数值                           |
  | ------------------- | ------------------------------ |
  | 圆角    | 4    |
  | 按压时浮层颜色     | `Color(0x26000000)`  设置主题色参数为   `tapColor` |
### TDButtonSize

Large

  | 属性                | 数值                           |
  | ------------------- | ------------------------------ |
  | 文字和图标内容横向间距    | 保持充满父布局     |
  | 文字和图标内容纵向间距     | 12       |
  | 文字大小     | 16       |
mid

  | 属性                | 数值                           |
  | ------------------- | ------------------------------ |
  | 文字和图标内容横向间距          | 保持充满父布局     |
  | 文字和图标内容纵向间距     | 10      |
  | 文字大小     | 14     |
small

  | 属性                | 数值                           |
  | ------------------- | ------------------------------ |
  | 文字和图标内容横向间距      |  20     |
  | 文字和图标内容纵向间距     | 8      |
  | 文字大小     | 14       |
tint

  | 属性                | 数值                           |
  | ------------------- | ------------------------------ |
  | 文字和图标内容横向间距      |  16     |
  | 文字和图标内容纵向间距     | 4   |
  | 文字大小     | 14       |
  
### TDButtonStyle
以下相关颜色均和`主题`设置相关，数值为默认主题时的色值
可以通过

  | TDButtonStyle   | 文字颜色 <br> 主题参数|  禁用文字颜色 <br> 主题参数 |背景颜色 <br> 主题参数|禁用背景颜色 <br> 主题参数
  | ---- | ------ | ---- | ---- | ---- |---- |
  | normal     |  `0xFFFFFFFF` <br> `textAntiPrimaryColor` |  `0xFFFFFFFF` <br> `textAntiPrimaryColor`| `0xFF0052D9`  <br> `primaryColor`| `0xFFBBD3FB` <br> `buttonDisablePrimary`
  | stroke    |`0xFF0052D9`  <br> `primaryColor`  | `0xFFBBD3FB` <br> `buttonDisablePrimary` |  `0xFF0052D9`  <br> `primaryColor`  | `0xFFBBD3FB` <br> `buttonDisablePrimary` |
  | secondary     | `0xE6000000`    <br>   `textColorL1`   | `0x42000000` <br> `textColorL4`    |`0xFFFFFFFF` <br> `textAntiPrimaryColor` |`0xFFFFFFFF` <br> `textAntiPrimaryColor` |
  | warn     | `0xFFFFFFFF` <br> `textAntiPrimaryColor`    |`0xFFFFFFFF` <br> `textAntiPrimaryColor`| `0xFFE34D59` <br> `errorColor`|`0xFFF9D7D9` <br> `errorColorDisabled`|
  | warnStroke     | `0xFFE34D59` <br> `errorColor`|`0xFFF9D7D9` <br> `errorColorDisabled`| `0xFFE34D59` <br> `errorColor`|`0xFFF9D7D9` <br> `errorColorDisabled`|
  | text     |`0xFF0052D9`  <br> `primaryColor`  | `0xFFBBD3FB` <br> `buttonDisablePrimary` | 暂定白色 | 暂定白色 |
  | ghost     | `0xFF0052D9`  <br> `primaryColor`  | `0xFFBBD3FB` <br> `buttonDisablePrimary` |  透明  | 透明 |


