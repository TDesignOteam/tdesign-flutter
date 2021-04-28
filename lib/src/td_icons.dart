//  Created by matthewyan on 2021/4/26.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

/// TDIcons
/// TDesign图标库
/// 由icon_font_generator工具自动生成的文件
/// 生成命令：`icon_font_generator --from=tdesign-icon --class-name=TDIcons --out-font=td_icons.ttf --out-flutter=td_icons.dart`

import 'package:flutter/widgets.dart';

@immutable
class _TDIconsData extends IconData {
  const _TDIconsData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'TDIcons',
        );
}

/// TDIcons
/// 要使用资源图标，请在工程`pubspec.yaml`中添加如下配置：
/// ``` json
///   fonts:
///    - family: TDIcons
///      fonts:
///        - asset: packages/tdesign/fonts/td_icons.ttf
/// ```
/// 
/// 通过TDIcons来引用相应图标资源即可：`TDIcons.arrowUp`
/// 
@immutable
class TDIcons {
  TDIcons._();

  static const IconData add = _TDIconsData(0xe000);
  static const IconData arrowDown = _TDIconsData(0xe001);
  static const IconData arrowUp = _TDIconsData(0xe002);
  static const IconData checkCircleFilled = _TDIconsData(0xe003);
  static const IconData check = _TDIconsData(0xe004);
  static const IconData chevronLeft = _TDIconsData(0xe005);
  static const IconData chevronRight = _TDIconsData(0xe006);
  static const IconData circle = _TDIconsData(0xe007);
  static const IconData clearCircleFilled = _TDIconsData(0xe008);
  static const IconData close = _TDIconsData(0xe009);
  static const IconData errorCircleFilled = _TDIconsData(0xe00a);
  static const IconData helpCircleFilled = _TDIconsData(0xe00b);
  static const IconData loading = _TDIconsData(0xe00c);
  static const IconData locationFilled = _TDIconsData(0xe00d);
  static const IconData refresh = _TDIconsData(0xe00e);
  static const IconData remove = _TDIconsData(0xe00f);
  static const IconData search = _TDIconsData(0xe010);
  static const IconData soundFilled = _TDIconsData(0xe011);
  static const IconData starFilled = _TDIconsData(0xe012);
  static const IconData timeFilled = _TDIconsData(0xe013);
  static const IconData userFilled = _TDIconsData(0xe014);
  static const IconData warning = _TDIconsData(0xe015);
}
