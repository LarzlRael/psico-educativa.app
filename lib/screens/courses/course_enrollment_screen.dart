part of '../screens.dart';

class CourseEnrollmentScreen extends HookConsumerWidget {
  final int idCourse;
  static const routeName = "/course_enrollment";

  const CourseEnrollmentScreen({super.key, required this.idCourse});

  @override
  Widget build(BuildContext context, ref) {
    final courseNotifierProviderN = ref.read(courseNotifierProvider.notifier);
    final courseState = ref.watch(courseNotifierProvider);
    final userInfoState = ref.watch(authNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    useEffect(() {
      Future.microtask(
          () => courseNotifierProviderN.getCourseDetails(idCourse));
      /* return () => courseNotifierProviderN.clearCurrentCourse(); */
    }, []);
    final hasMultipleProfessors =
        courseState.courseSelected?.professors != null &&
            courseState.courseSelected!.professors.length > 1;

    return ScaffoldWithBackground(
        appBar: AppBar(
          leading: BackIcon(
            size: 20,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                /*     Share.share(
                  'Mira este curso: ${courseState.courseSelected?.courseName}',
                ); */
              },
            ),
          ],
        ),
        child: SizedBox.expand(
          child: Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            child: Stack(
              children: [
                /* TODO Improve this part of the code */
                courseState.isLoading
                    ? ListView(
                        children: [
                          const ShimmerWidget(
                            height: 200,
                          ),
                          const ShimmerWidget(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              height: 25,
                              shape: ShimmerShape.rounded),
                          ...List.generate(5, (index) {
                            return ShimmerWidget(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              height: 15,
                              shape: ShimmerShape.rounded,
                            );
                          }),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInImage(
                              placeholder: const AssetImage(appIcon),
                              image: NetworkImage(
                                (courseState.courseSelected?.imageUrl == null ||
                                        courseState
                                            .courseSelected!.imageUrl!.isEmpty)
                                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBu0USCFZwKnomMof7OSN2zIbPlEiV-bmMAw&s'
                                    : courseState.courseSelected!.imageUrl!,
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SimpleText(
                                    '${courseState.courseSelected?.courseName}'
                                        .toCapitalize(),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                  /* SignatureChangeName(
                                    userInfoState: userInfoState,
                                  ), */
                                  const SizedBox(height: 15),
                                  SimpleText(
                                    '${courseState.courseSelected?.courseDescription}'
                                        .toCapitalize(),
                                    fontSize: 14,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    lineHeight: 1.7,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  /* TODO add condiction to show 'S' */
                                  SimpleText(
                                    hasMultipleProfessors
                                        ? 'Especialistas invitados'
                                        : 'Especialista invitado',
                                    fontSize: 16,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  if (courseState.courseSelected?.professors !=
                                      null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: courseState
                                          .courseSelected!.professors
                                          .map((e) {
                                        return ListTile(
                                          contentPadding: EdgeInsets
                                              .zero, // Elimina el padding adicional de ListTile
                                          title: SimpleText(
                                            '${e.professionalTitle} ${e.user?.firstName} ${e.user?.lastName}'
                                                .trim()
                                                .toTitleCase(), // Conviertes a título capitalizado

                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: colorScheme.secondary,
                                          ),
                                          subtitle: SimpleText(
                                            e.expertise
                                                .toCapitalize(), // Convierte a mayúscula inicial
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          trailing: isValidateString(
                                                  e.user!.profileImageUrl)
                                              ? CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      e.user!.profileImageUrl!),
                                                )
                                              : null,
                                        );
                                      }).toList(),
                                    ),
                                  InfoRow(
                                    title: 'Modalidad',
                                    content:
                                        courseState.courseSelected?.modality ==
                                                'VIRTUAL'
                                            ? Row(
                                                children: [
                                                  SimpleText(
                                                    '${courseState.courseSelected?.modality}'
                                                        .toLowerCase()
                                                        .toCapitalize(),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Image.asset(
                                                    logoByType(courseState
                                                            .courseSelected
                                                            ?.virtualPlatform ??
                                                        'ZOOM'),
                                                    width: 40,
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                  ),
                                  InfoRow(
                                      title: 'Material',
                                      content: courseState
                                                  .courseSelected?.material ==
                                              null
                                          ? null
                                          : SimpleText(
                                              '${courseState.courseSelected?.material}')),
                                  InfoRow(
                                      title: 'Más informacion',
                                      content: courseState.courseSelected
                                                  ?.informationContact ==
                                              null
                                          ? null
                                          : InkWell(
                                              onTap: () => startWhatsapp(
                                                context,
                                                courseState.courseSelected
                                                        ?.informationContact ??
                                                    '',
                                                'Hola, me gustaría obtener más información sobre el curso ${courseState.courseSelected?.courseName}',
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    FontAwesomeIcons.whatsapp,
                                                    color: Color(0xFF25D366),
                                                  ),
                                                  SizedBox(width: 10),
                                                  SimpleText(
                                                    '${courseState.courseSelected?.informationContact}',
                                                    color:
                                                        colorScheme.secondary,
                                                    textDecoration:
                                                        TextDecoration
                                                            .underline,
                                                  ),
                                                ],
                                              ),
                                            )),
                                  InfoRow(
                                      title: 'Notas',
                                      content: courseState
                                                  .courseSelected?.notes ==
                                              null
                                          ? null
                                          : Column(
                                              children: courseState
                                                      .courseSelected?.notes
                                                      ?.split(',')
                                                      .map((e) {
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        bottom: 10,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 5,
                                                            height: 5,
                                                            decoration: BoxDecoration(
                                                                color: colorScheme
                                                                    .secondary,
                                                                shape: BoxShape
                                                                    .circle),
                                                          ),
                                                          SizedBox(width: 5),
                                                          Expanded(
                                                              child: SimpleText(
                                                                  e)),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList() ??
                                                  [],
                                            )),
                                  SizedBox(height: 100),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: EnrollButton(
                    isLoading: courseState.isLoading,
                    priceAndCurrency:
                        'Bs. ${courseState.courseSelected?.coursePrice}',
                    onPressed: () {
                      /* if (userInfoState.user?.isAuthenticated == true) {
                        context.push(
                          PaymentScreen.routeName,
                          arguments: PaymentScreenArguments(
                            course: courseState.courseSelected!,
                          ),
                        );
                      } else {
                        context.push(LoginScreen.routeName);
                      } */
                    },
                  
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class SignatureChangeName extends StatelessWidget {
  const SignatureChangeName({
    super.key,
    required this.userInfoState,
  });

  final AuthState userInfoState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        SimpleText(
          'SU NOMBRE COMPLETO TAL COMO SALDRÁ EN SU CERTIFICADO:',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => context.push(UserUpdateProfileInfoScreen.routeName),
            child: LetterNameLikeSignature(
              userInfoState.user?.username ?? '',
              firstName: userInfoState.user?.firstName,
              lastName: userInfoState.user?.lastName,
            ),
          ),
        ),
        const SimpleText(
          'Si desea que su nombre aparezca de otra forma, por favor ve a tu perfil y modifícalo*',
          fontSize: 11,
          fontWeight: FontWeight.w300,
        ),
      ],
    );
  }
}

class LetterNameLikeSignature extends StatelessWidget {
  final String username;
  final String? firstName;
  final String? lastName;
  const LetterNameLikeSignature(
    this.username, {
    super.key,
    this.firstName,
    this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final signature = firstName != null && lastName != null
        ? '$firstName $lastName'
        : username;
    return Card(
      child: SimpleText(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        signature.toCapitalize().toTitleCase(),
        style: textTheme.titleSmall!
            .copyWith(color: colorScheme.secondary, fontSize: 22),
      ),
    );
  }
}

class TitleLabel extends StatelessWidget {
  const TitleLabel({
    super.key,
    required this.label,
    required this.content,
  });

  final String label;
  final String? content;

  @override
  Widget build(BuildContext context) {
    if (content == null || content!.isEmpty) {
      return const SizedBox();
    }
    return Row(
      children: [
        SimpleText(
          label,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        SimpleText(
          content!,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

String logoByType(String platformName) {
  //use map
  final Map<String, String> logos = {
    'ZOOM': 'assets/logos/logo_zoom.png',
    'GOOGLE_MEET': 'assets/logos/logo_meet.png',
  };
  return logos[platformName] ?? 'assets/logos/logo_zoom.png';
}

class InfoRow extends StatelessWidget {
  final String title;
  final Widget? content;

  const InfoRow({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    if (content == null) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100, // Controla el ancho del título
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20), // Espacio entre el título y el contenido
          Expanded(
            child: content!,
          ),
        ],
      ),
    );
  }
}

class EnrollButton extends StatelessWidget {
  const EnrollButton({
    super.key,
    required this.isLoading,
    required this.priceAndCurrency,
    this.onPressed,
    this.height = 100,
  });
  final bool isLoading;
  final String priceAndCurrency;
  final double height;
  final void Function()? onPressed;

  static const routeName = "";
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return isLoading
        ? const ShimmerWidget(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            shape: ShimmerShape.rounded)
        : Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.onSurface.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Row(
              children: [
                SimpleText(
                  priceAndCurrency,
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: LoginButton(
                    child: SimpleText(
                      'Inscribirme',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    borderRadius: 5,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          );
  }
}
