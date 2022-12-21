import 'package:flutter/material.dart';
import 'package:tdesign_flutter/td_export.dart';

import '../../annotation/demo.dart';
import '../../base/example_widget.dart';

class TDBottomNavBarPage extends StatelessWidget {
  const TDBottomNavBarPage({Key? key}) : super(key: key);

  void onTapTab(BuildContext context, String tabName) {
    TDToast.showText('点击了 $tabName', context: context);
  }

  // 避免冗余代码
  List<TDBottomNavBarTabConfig> _generateIconTextTabs(
      int count, TDBottomNavBarBasicType type, BuildContext context) {
    switch (type) {
      case TDBottomNavBarBasicType.text:
        return List.generate(
            count,
            (index) => TDBottomNavBarTabConfig(
                tabText: '标签',
                onTap: () {
                  onTapTab(context, '标签${index + 1}');
                }));
      case TDBottomNavBarBasicType.iconText:
        return List.generate(
            count,
            (index) => TDBottomNavBarTabConfig(
                  iconTextTypeConfig:
                      IconTextTypeConfig(tabText: '标签', useDefaultIcon: true),
                  onTap: () {
                    onTapTab(context, '标签${index + 1}');
                  },
                ));
      case TDBottomNavBarBasicType.icon:
        return List.generate(
            count,
            (index) => TDBottomNavBarTabConfig(
                iconTypeConfig: IconTypeConfig(useDefaultIcon: true),
                onTap: () {
                  onTapTab(context, '标签${index + 1}');
                }));
      case TDBottomNavBarBasicType.expansionPanel:
        return List.generate(
            count,
            (index) => TDBottomNavBarTabConfig(
                tabText: '标签${index + 1}',
                onTap: () {
                  onTapTab(context, '标签${index + 1}');
                }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
        title: '标签栏 TDBottomNavBar',
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: const Color(0xFFF0F2F5),
        exampleCodeGroup: 'bottomNavBar',
        children: [
          ExampleModule(
            title: '组件类型',
            children: [
              ExampleItem(desc: '图标加文本标签栏', builder: _iconTextTypeNavBar),
              ExampleItem(
                builder: (BuildContext context) {
                  return TDBottomNavBar(
                    TDBottomNavBarBasicType.iconText,
                    useVerticalDivider: true,
                    navigationTabs: _generateIconTextTabs(
                        3, TDBottomNavBarBasicType.iconText, context),
                  );
                },
              ),
              ExampleItem(
                builder: (BuildContext context) {
                  return TDBottomNavBar(
                    TDBottomNavBarBasicType.iconText,
                    useVerticalDivider: true,
                    navigationTabs: _generateIconTextTabs(
                        4, TDBottomNavBarBasicType.iconText, context),
                  );
                },
              ),
              ExampleItem(
                builder: (BuildContext context) {
                  return TDBottomNavBar(
                    TDBottomNavBarBasicType.iconText,
                    useVerticalDivider: true,
                    navigationTabs: _generateIconTextTabs(
                        5, TDBottomNavBarBasicType.iconText, context),
                  );
                },
              ),
              ExampleItem(
                desc: '纯图标标签栏',
                builder: _iconTypeNavBar,
              ),
              ExampleItem(
                builder: (BuildContext context) {
                  return TDBottomNavBar(
                    TDBottomNavBarBasicType.icon,
                    useVerticalDivider: true,
                    navigationTabs: _generateIconTextTabs(
                        3, TDBottomNavBarBasicType.icon, context),
                  );
                },
              ),
              ExampleItem(
                builder: (BuildContext context) {
                  return TDBottomNavBar(
                    TDBottomNavBarBasicType.icon,
                    useVerticalDivider: true,
                    navigationTabs: _generateIconTextTabs(
                        4, TDBottomNavBarBasicType.icon, context),
                  );
                },
              ),
              ExampleItem(
                builder: (BuildContext context) {
                  return TDBottomNavBar(
                    TDBottomNavBarBasicType.icon,
                    useVerticalDivider: true,
                    navigationTabs: _generateIconTextTabs(
                        5, TDBottomNavBarBasicType.icon, context),
                  );
                },
              ),
              ExampleItem(
                desc: '双层级文本标签栏',
                builder: _expansionPannelTypeNavBar,
              ),
            ],
          ),
          ExampleModule(title: '组件样式', children: [
            ExampleItem(
              desc: '弱选中标签栏',
              builder: _weakSelectTextNavBar,
            ),
            ExampleItem(
              builder: _weakSelectIconNavBar,
            ),
            ExampleItem(
              builder: _weakSelectIconTextNavBar,
            ),
            ExampleItem(
              desc: '悬浮胶囊标签栏',
              builder: _capsuleNavBar,
            ),
          ]),
        ]);
  }

  @Demo(group: 'bottomNavBar')
  Widget _iconTextTypeNavBar(BuildContext context) {
    return TDBottomNavBar(TDBottomNavBarBasicType.iconText,
        useVerticalDivider: false,
        navigationTabs: [
          TDBottomNavBarTabConfig(
            iconTextTypeConfig:
                IconTextTypeConfig(tabText: '标签', useDefaultIcon: true),
            onTap: () {
              onTapTab(context, '标签1');
            },
          ),
          TDBottomNavBarTabConfig(
            iconTextTypeConfig:
                IconTextTypeConfig(tabText: '标签', useDefaultIcon: true),
            onTap: () {
              onTapTab(context, '标签2');
            },
          ),
        ]);
  }

  @Demo(group: 'bottomNavBar')
  Widget _iconTypeNavBar(BuildContext context) {
    return TDBottomNavBar(TDBottomNavBarBasicType.icon,
        useVerticalDivider: true,
        navigationTabs: [
          TDBottomNavBarTabConfig(
              iconTypeConfig: IconTypeConfig(useDefaultIcon: true),
              onTap: () {
                onTapTab(context, '标签1');
              }),
          TDBottomNavBarTabConfig(
              iconTypeConfig: IconTypeConfig(useDefaultIcon: true),
              onTap: () {
                onTapTab(context, '标签2');
              })
        ]);
  }

  @Demo(group: 'bottomNavBar')
  Widget _expansionPannelTypeNavBar(BuildContext context) {
    return TDBottomNavBar(
      TDBottomNavBarBasicType.expansionPanel,
      useVerticalDivider: true,
      navigationTabs: [
        TDBottomNavBarTabConfig(
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(
              TDBadgeType.message,
              message: 'New',
            ),
            badgeTopOffset: -2,
            badgeRightOffset: -35,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签1');
          },
        ),
        TDBottomNavBarTabConfig(
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.message, count: '128'),
            badgeTopOffset: -2,
            badgeRightOffset: -28,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签2');
          },
        ),
        TDBottomNavBarTabConfig(
            badgeConfig: BadgeConfig(
              showBage: true,
              tdBadge: const TDBadge(TDBadgeType.redPoint),
              badgeTopOffset: -2,
              badgeRightOffset: -10,
            ),
            tabText: '展开项',
            onTap: () {
              onTapTab(context, '展开项');
            },
            popUpButtonConfig: TDBottomNavBarPopUpBtnConfig(
                popUpDialogConfig: TDBottomNavBarPopUpShapeConfig(
                  radius: 10,
                  arrowWidth: 16,
                  arrowHeight: 8,
                ),
                items: [
                  '展开项一',
                  '展开项二',
                  '展开项三',
                ]
                    .map((e) => PopUpMenuItem(
                          value: e,
                          itemWidget: SizedBox(
                            //height: 30,
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: TDTheme.of(context).grayColor7,
                                  fontSize: 16),
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (v) {
                  TDToast.showText('点击了 $v', context: context);
                })),
      ],
    );
  }

  @Demo(group: 'bottomNavBar')
  Widget _weakSelectTextNavBar(BuildContext context) {
    return TDBottomNavBar(
      TDBottomNavBarBasicType.text,
      componentType: TDBottomNavBarComponentType.normal,
      useVerticalDivider: true,
      navigationTabs: [
        TDBottomNavBarTabConfig(
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签1');
          },
        ),
        TDBottomNavBarTabConfig(
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签2');
          },
        ),
        TDBottomNavBarTabConfig(
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签3');
          },
        ),
      ],
    );
  }

  @Demo(group: 'bottomNavBar')
  Widget _weakSelectIconNavBar(BuildContext context) {
    return TDBottomNavBar(
      TDBottomNavBarBasicType.icon,
      componentType: TDBottomNavBarComponentType.normal,
      useVerticalDivider: false,
      navigationTabs: [
        TDBottomNavBarTabConfig(
          iconTypeConfig: IconTypeConfig(useDefaultIcon: true),
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签1');
          },
        ),
        TDBottomNavBarTabConfig(
          iconTypeConfig: IconTypeConfig(useDefaultIcon: true),
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签2');
          },
        ),
        TDBottomNavBarTabConfig(
          iconTypeConfig: IconTypeConfig(useDefaultIcon: true),
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签3');
          },
        ),
      ],
    );
  }

  @Demo(group: 'bottomNavBar')
  Widget _weakSelectIconTextNavBar(BuildContext context) {
    return TDBottomNavBar(
      TDBottomNavBarBasicType.iconText,
      componentType: TDBottomNavBarComponentType.normal,
      useVerticalDivider: false,
      navigationTabs: [
        TDBottomNavBarTabConfig(
          iconTextTypeConfig:
              IconTextTypeConfig(useDefaultIcon: true, tabText: '标签'),
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签1');
          },
        ),
        TDBottomNavBarTabConfig(
          iconTextTypeConfig:
              IconTextTypeConfig(useDefaultIcon: true, tabText: '标签'),
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签2');
          },
        ),
        TDBottomNavBarTabConfig(
          iconTextTypeConfig:
              IconTextTypeConfig(useDefaultIcon: true, tabText: '标签'),
          badgeConfig: BadgeConfig(
            showBage: true,
            tdBadge: const TDBadge(TDBadgeType.redPoint),
            badgeTopOffset: -2,
            badgeRightOffset: -10,
          ),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签3');
          },
        ),
      ],
    );
  }

  @Demo(group: 'bottomNavBar')
  Widget _capsuleNavBar(BuildContext context) {
    return TDBottomNavBar(
      TDBottomNavBarBasicType.iconText,
      componentType: TDBottomNavBarComponentType.label,
      outlineType: TDBottomNavBarOutlineType.capsule,
      useVerticalDivider: true,
      navigationTabs: [
        TDBottomNavBarTabConfig(
          iconTextTypeConfig:
              IconTextTypeConfig(useDefaultIcon: true, tabText: '标签'),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签1');
          },
        ),
        TDBottomNavBarTabConfig(
          iconTextTypeConfig:
              IconTextTypeConfig(useDefaultIcon: true, tabText: '标签'),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签2');
          },
        ),
        TDBottomNavBarTabConfig(
          iconTextTypeConfig:
              IconTextTypeConfig(useDefaultIcon: true, tabText: '标签'),
          tabText: '标签',
          onTap: () {
            onTapTab(context, '标签3');
          },
        ),
      ],
    );
  }
}
