part of '../custom_widgets.dart';

class BackgroundWithBlurredCircles extends StatelessWidget {
  final Widget child;

  const BackgroundWithBlurredCircles({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        // Fondo negro
        Container(color: Colors.black),

        // Círculo difuminado en la esquina superior izquierda
        Positioned(
          top: -175,
          left: -175,
          child: CircleBlurred(
            radius: 250,
            colors: [colorScheme.primary.withOpacity(0.5), Colors.transparent],
          ),
        ),

        // Círculo difuminado en el centro-derecha
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          right: -150,
          child: CircleBlurred(
            radius: 200,
            colors: [
              colorScheme.secondary.withOpacity(0.30),
              Colors.transparent
            ],
            blurAmount: 20,
          ),
        ),

        // Círculo difuminado en la esquina inferior izquierda
        Positioned(
          bottom: -200,
          left: -200,
          child: CircleBlurred(
            radius: 200,
            colors: [Color(0xffB4AAFF).withOpacity(0.25), Colors.transparent],
          ),
        ),
        /*  Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: BottomNavigationFLoating()),
        ), */
        // Child que pasa el contenido encima del fondo
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}

class CircleBlurred extends StatelessWidget {
  final double radius;
  final List<Color> colors;
  final double blurAmount;

  const CircleBlurred({
    super.key,
    required this.radius,
    required this.colors,
    this.blurAmount = 10.0, // Valor del desenfoque por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // El círculo con gradiente
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: colors,
              center: Alignment.center,
              radius: 1,
            ),
          ),
        ),

        // Aplicación del efecto de blur
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurAmount, // Desenfoque en el eje X
              sigmaY: blurAmount, // Desenfoque en el eje Y
            ),
            child: Container(
              color: Colors.transparent, // Fondo transparente para ver el blur
            ),
          ),
        ),
      ],
    );
  }
}

class BottomNavigationFLoating extends StatelessWidget {
  const BottomNavigationFLoating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<MenuCustomButton> items = [
      MenuCustomButton(
        icon: Icons.home,
        appRoute: HomeScreen.routeName,
      ),
      MenuCustomButton(
        icon: Icons.search,
        appRoute: HomeScreen.routeName,
      ),
      MenuCustomButton(
        icon: Icons.notifications,
        appRoute: NotificationsScreen.routeName,
      ),
      MenuCustomButton(
        icon: Icons.account_circle,
        appRoute: UserProfileScreen.routeName,
      ),
    ];

    return _FloatingMenuBackground(child: _MenuItems(menuItems: items));
  }
}

class _FloatingMenuBackground extends StatelessWidget {
  final Widget child;
  const _FloatingMenuBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color(0xff2c2c2c),
        boxShadow: const [
          BoxShadow(
            color: Colors.white38,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
      ),
      child: child,
    );
  }
}

class MenuCustomButton {
  final IconData icon;
  /* final Function onPressed; */
  final String appRoute;
  MenuCustomButton({
    required this.icon,
    /* required this.onPressed, */
    required this.appRoute,
  });
}

class _MenuItems extends StatelessWidget {
  const _MenuItems({
    required this.menuItems,
  });
  final List<MenuCustomButton> menuItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        menuItems.length,
        (index) => _MenuItemButton(
          item: menuItems[index],
          index: index,
        ),
      ),
    );
  }
}

class _MenuItemButton extends ConsumerWidget {
  final int index;
  final MenuCustomButton item;
  const _MenuItemButton({
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selectedIndex =
        ref.watch(menuProvider); // Observamos el índice actual

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        ref.read(menuProvider.notifier).selectItem(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          item.icon,
          size: (selectedIndex == index) ? 35 : 25,
          color: selectedIndex == index
              ? Theme.of(context).colorScheme.secondary
              : Colors.blueGrey,
        ),
      ),
    );
  }
}
