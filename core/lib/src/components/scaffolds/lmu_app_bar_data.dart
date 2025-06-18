import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'leading_action.dart';

class LmuAppBarData {
  factory LmuAppBarData({
    required String largeTitle,
    Widget? customLargeTitleWidget,
    String? collapsedTitle,
    LeadingAction? leadingAction,
    void Function()? onLeadingActionTap,
    List<Widget>? trailingWidgets,
    Widget? largeTitleTrailingWidget,
    MainAxisAlignment largeTitleTrailingWidgetAlignment = MainAxisAlignment.spaceBetween,
  }) {
    return LmuAppBarData._(
      largeTitle: largeTitle,
      customLargeTitleWidget: customLargeTitleWidget,
      collapsedTitle: collapsedTitle,
      leadingAction: leadingAction,
      onLeadingActionTap: onLeadingActionTap,
      trailingWidgets: trailingWidgets,
      largeTitleTrailingWidget: largeTitleTrailingWidget,
      largeTitleTrailingWidgetAlignment: largeTitleTrailingWidgetAlignment,
    );
  }

  factory LmuAppBarData.image({
    String? largeTitle,
    Widget? customLargeTitleWidget,
    String? collapsedTitle,
    LeadingAction? leadingAction,
    void Function()? onLeadingActionTap,
    List<Widget>? trailingWidgets,
    List<String>? imageUrls,
    Widget? largeTitleTrailingWidget,
    MainAxisAlignment largeTitleTrailingWidgetAlignment = MainAxisAlignment.spaceBetween,
  }) {
    return LmuAppBarData._(
      largeTitle: largeTitle,
      customLargeTitleWidget: customLargeTitleWidget,
      collapsedTitle: collapsedTitle,
      leadingAction: leadingAction,
      onLeadingActionTap: onLeadingActionTap,
      trailingWidgets: trailingWidgets,
      imageUrls: imageUrls,
      largeTitleTrailingWidget: largeTitleTrailingWidget,
      largeTitleTrailingWidgetAlignment: largeTitleTrailingWidgetAlignment,
    );
  }

  factory LmuAppBarData.custom({
    Widget? customLargeTitleWidget,
    String? collapsedTitle,
    LeadingAction? leadingAction,
    void Function()? onLeadingActionTap,
    List<Widget>? trailingWidgets,
  }) {
    return LmuAppBarData._(
      customLargeTitleWidget: customLargeTitleWidget,
      collapsedTitle: collapsedTitle,
      leadingAction: leadingAction,
      onLeadingActionTap: onLeadingActionTap,
      trailingWidgets: trailingWidgets,
    );
  }
  LmuAppBarData._({
    this.largeTitle,
    this.customLargeTitleWidget,
    this.collapsedTitle,
    this.leadingAction,
    this.onLeadingActionTap,
    this.trailingWidgets,
    this.imageUrls,
    this.largeTitleTrailingWidget,
    this.largeTitleTrailingWidgetAlignment = MainAxisAlignment.spaceBetween,
  });

  final String? largeTitle;
  final Widget? customLargeTitleWidget;
  final String? collapsedTitle;
  final LeadingAction? leadingAction;
  final void Function()? onLeadingActionTap;
  final List<Widget>? trailingWidgets;
  final Widget? largeTitleTrailingWidget;
  final MainAxisAlignment largeTitleTrailingWidgetAlignment;
  final List<String>? imageUrls;
}
