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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: backgroundColor,
          elevation: 3,
          child: ListTile(
            trailing: trailingWidget ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey,
                ),
            leading: leadingWidget,
            title: Text(title,
                style: textTheme.bodyMedium!.copyWith(color: textColor)),
          ),
        ),
      ),
    );
  }
}
