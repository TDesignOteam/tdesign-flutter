# tdesign_flutter

TDesign Flutter组件

### 工程开发

#### 工程结构

所有组件都在`lib\src`路径下



#### 日志提交

git提交日志，使用[commitizen](https://github.com/commitizen/cz-cli)工具

通过：`git cz`来提交代码



#### 注释

注释采用官方推荐注释写法，最终支持`dartdoc`来生成文档



#### 接口设计

[接口设计文档](https://docs.qq.com/sheet/DWmViVlNvU3p2VHZs?tab=6mdwpj)



#### 设计稿

[TDesign-for-web](https://www.figma.com/file/UghlEiQXZogyPvx1XDMMyx/TDesign-for-web?node-id=729%3A9)

#### 资源

[TDesign-Mobile图标库](http://bkicon.oa.com/resource/project/95/detail)


### 支持组件列表

- [Rate](http://tdesign.woa.com/vue-mobile/components/rate)


### 三方工具

#### icon_font_generator

td_icons.dart由[icon_font_generator](https://pub.dev/packages/icon_font_generator)工具自动生成，命令为：`icon_font_generator --from=tdesign-icon --class-name=TDIcons --out-font=td_icons.ttf --out-flutter=td_icons.dart`

生成的ttf文件，替换掉`lib/fonts/td_icons.ttf`

生成的`td_icons.dart`，将其`class TDIcons`的内容替换掉，前面的注释不要删除了。
