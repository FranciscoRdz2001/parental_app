import 'package:flutter/material.dart';

class CustomScaffoldWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool hasScroll;
  final Widget child;
  final Widget? drawer;
  final Widget? persistentFooterButton;
  final EdgeInsets padding;
  const CustomScaffoldWidget({
    super.key,
    required this.child,
    this.scaffoldKey,
    this.hasScroll = false,
    this.persistentFooterButton,
    this.drawer,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 0),
  });

  @override
  Widget build(BuildContext context) {
    final newChild = hasScroll
        ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: padding,
              child: child,
            ),
          )
        : Padding(
            padding: padding,
            child: child,
          );
    final structure = Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
          space: 0,
          thickness: 0,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        persistentFooterButtons: [
          if (persistentFooterButton != null) persistentFooterButton!,
        ],
        body: SafeArea(
          bottom: false,
          child: newChild,
        ),
      ),
    );
    return structure;
  }
}
