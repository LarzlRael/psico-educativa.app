part of '../custom_widgets.dart';

class MenuProfileOption extends StatelessWidget {
  final String title;
  final Widget? trailingWidget;
  final Widget? leadingWidget;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onTap;

  const MenuProfileOption({
    required this.title,
    super.key,
    this.onTap,
    this.trailingWidget,
    this.leadingWidget,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: ListTile(
          leading: leadingWidget,
          title: SimpleText(
            title,
            fontSize: 16,
            color: textColor ?? Color(0xff0E1B1A),
            fontWeight: FontWeight.w500,
          ),
          trailing: trailingWidget ??
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Color(0xff0E1B1A),
              ),
        ),
      ),
    );
  }
}
