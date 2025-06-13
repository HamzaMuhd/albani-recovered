import 'package:albani/common/helpers/is_dark_mode.dart';
import 'package:flutter/material.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;
  const BasicAppbar(
      {super.key,
      this.title,
      this.bottom,
      this.hideBack = false,
      this.action,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(""),
      actions: [action ?? Container()],
      leading: (hideBack || !(ModalRoute.of(context)?.canPop ?? false))
          ? null
          : IconButton(
              icon: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
