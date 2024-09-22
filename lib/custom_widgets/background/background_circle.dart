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
        icon: Icons.home_outlined,
        label: 'Inicio',
        appRoute: HomeScreen.routeName,
      ),
      MenuCustomButton(
        icon: Icons.search,
        label: 'Buscar',
        appRoute: HomeScreen.routeName,
      ),
      MenuCustomButton(
        icon: Icons.notifications,
        appRoute: NotificationsScreen.routeName,
        label: 'Notificaciones',
      ),
      MenuCustomButton(
        icon: Ionicons.person_outline,
        appRoute: UserProfileScreen.routeName,
        label: 'Perfil',
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }
}

class MenuCustomButton {
  final IconData icon;
  final String label;
  final String appRoute;
  MenuCustomButton({
    required this.icon,
    required this.label,
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
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        ref.read(menuProvider.notifier).selectItem(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: (selectedIndex == index)
                ? colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: (selectedIndex == index) ? 30 : 25,
                color: selectedIndex == index ? Colors.white : Colors.black45,
              ),
              const SizedBox(width: 5),
              if (selectedIndex == index)
                SimpleText(
                  item.label,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: selectedIndex == index ? Colors.white : Colors.black45,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundOneCircle extends StatelessWidget {
  final Widget child;
  final Widget? customShapeBackground;
  const BackgroundOneCircle({
    super.key,
    required this.child,
    this.customShapeBackground,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        // Fondo negro
        /* Container(color: Colors.black), */
        customShapeBackground != null
            ? customShapeBackground!
            :
            // Círculo difuminado en la esquina superior izquierda
            Positioned(
                top: -175,
                left: -175,
                child: CircleBlurred(
                  blurAmount: 0,
                  radius: 275,
                  colors: [colorScheme.primary, colorScheme.primary],
                ),
              ),

        // Círculo difuminado en el centro-derecha

        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
