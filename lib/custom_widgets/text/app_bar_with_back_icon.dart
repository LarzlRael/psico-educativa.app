part of '../custom_widgets.dart';

class AppBarWithBackIcon extends StatelessWidget
    implements PreferredSizeWidget {
  final AppBar appBar;
  final String? title;
  final bool centerTitle;
  final bool showIconApp;
  final double appIconSize;
  final List<Widget>? actions;
  const AppBarWithBackIcon({
    super.key,
    required this.appBar,
    this.centerTitle = false,
    this.showIconApp = false,
    this.appIconSize = 70,
    this.title,
    this.actions,
  });
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineSmall;
    return AppBar(
      elevation: 0,
      centerTitle: centerTitle,
      actions: actions,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showIconApp
              ? Image.asset(appIcon, width: appIconSize, height: appIconSize)
              : const SizedBox(),
          title != null ? Text(title!, style: style) : const SizedBox(),
        ],
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.chevron_left,
          size: 35,
        ),
        onPressed: context.pop,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
