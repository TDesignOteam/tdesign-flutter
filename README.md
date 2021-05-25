# tdesign

TDesign Flutter组件

## 使用

通过在`pubspec.yaml`中作如下配置使用：

``` json
tdesign:
  git: http://git.woa.com/TDesign/tdesign-mobile-flutter.git
```

组件的使用方式参考[示例工程`example`](https://git.code.oa.com/TDesign/tdesign-mobile-flutter/tree/master/example)。

要使用图标资源的话，在`pubspec.yaml`中添加如下配置：

``` json
  fonts:
   - family: TDIcons
     fonts:
       - asset: packages/tdesign/fonts/td_icons.ttf
```



## 工程开发

### 工程结构

所有组件都在`lib\src`路径下。

```
tdesign-mobile-flutter
├─ CHANGELOG.md
├─ LICENSE
├─ README.md
├─ example
│  ├─ lib
│  │  ├─ main.dart
│  │  ├─ page_util.dart
│  │  └─ pages             # 所有组件示例代码文件在pages目录下
├─ lib
│  ├─ fonts
│  ├─ src                  # 所有组件代码文件在src目录下
│  ├─ tdesign.dart
│  └─ theme
│     ├─ td_colors.dart    # TDesign色卡，组件所需颜色可以从这里取用
│     └─ td_theme.dart     # TDesign主题化相关属性，组件中部分默认属性需要从这里取用
├─ pubspec.yaml
└─ test                    # 所有组件测试代码在test目录下

```

### 分支

开发组件时，创建自己的`个人分支`或`feature`分支，开发完之后通过MR方式合入`master`。

### 提交日志

git提交日志，使用[commitizen](https://github.com/commitizen/cz-cli)工具，根据其中的指引安装并配置[Commitizen-friendly repo](https://github.com/commitizen/cz-cli#making-your-repo-commitizen-friendly)。

配置完成后，所有修改的提交都使用`git cz`命令提交，以生成规范的、“社区友好”的提交信息。

### 风格和主题

TDesign支持主题化。即用户可以通过改变一些全局属性来改变所有组件的风格。工程`lib\theme`目录下的`td_theme.dart`文件中定义了这些全局属性。当配置所开发组件的各类默认外观属性，例如尺寸、颜色、字号等时，判断属性是否需要包含在主题化的范畴中，需要则从`td_theme.dart`中取值。

工程`lib\theme`目录下的`td_colors.dart`文件定义了TDesign的设计色卡。在配置所开发组件的默认颜色时，如果颜色不在主题化范畴内，从`td_colors.dart`的色卡中取用颜色。

TDesign-mobile-flutter支持黑暗模式。如果组件某颜色配置需要在黑暗模式下改变，调用`TDTheme.isDarkMode(context)`判断场景模式以配置不同的颜色。

### 示例

在示例中完整展示组件的使用效果，风格参考[TDesign移动端组件库示例](http://tdesign.woa.com/vue-mobile/components/badge)。

在`example\lib\pages`下添加文件，命名为`组件名_page.dart`。

在`example\lib\main.dart`中的主菜单添加页面入口。页面统一以`page_util.dart`中的`ExamplePage`作为根Widget。

### 测试

在`test`目录下为组件添加测试。若组件中存在重要逻辑则必须进行测试，例如边界条件，显示与隐藏等。

为每个组件创建一个单独的测试文件，命名为`组件名_test.dart`。



## 文档/资源

[接口设计文档](https://docs.qq.com/sheet/DWmViVlNvU3p2VHZs?tab=6mdwpj)

[TDesign-for-web](https://www.figma.com/file/UghlEiQXZogyPvx1XDMMyx/TDesign-for-web?node-id=729%3A9)

[TDesign-Mobile图标库](http://bkicon.oa.com/resource/project/95/detail)



## 工程/代码规范

主要遵守 [腾讯Dart规范](https://git.code.oa.com/standards/dart)。

使用`dart format`来格式化你的代码。

注意：使用多个参数时在最后一个参数后添加逗号可能造成`dart format`格式化出多余的缩进，删除逗号重新格式化可以解决问题。

### 名称

变量名与前端定义尽量一致，当属性名中含有`-`时，去掉连接线，连接线后面的字符大写，如：`allow-half` 使用 `allowHalf`。

### 逻辑分块

当类接口过多时，使用extension来分组不同功能的接口。




## 支持组件列表

- [Rate](http://tdesign.woa.com/vue-mobile/components/rate)
- [Badge](http://tdesign.woa.com/vue-mobile/components/badge)



## 三方工具

### icon_font_generator

td_icons.dart由[icon_font_generator](https://pub.dev/packages/icon_font_generator)工具自动生成，命令为：`icon_font_generator --from=tdesign-icon --class-name=TDIcons --out-font=td_icons.ttf --out-flutter=td_icons.dart`

生成的ttf文件，替换掉`lib/fonts/td_icons.ttf`

生成的`td_icons.dart`，将其`class TDIcons`的内容替换掉，前面的注释不要删除了。