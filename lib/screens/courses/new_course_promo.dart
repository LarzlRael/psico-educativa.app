part of '../screens.dart';

class NewCoursePromoScreen extends HookConsumerWidget {
  final int idCourse;
  static const routeName = "/new-course-promo";

  const NewCoursePromoScreen({super.key, required this.idCourse});

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
        /* appBar: AppBar(
        title: Text('Promoción'),
      ), */
        child: SizedBox.expand(
      child: Stack(
        children: [
          courseState.isLoading
              ? SizedBox.expand(
                  child: Center(child: CircularProgressIndicator()))
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInImage(
                        placeholder: const AssetImage(appIcon),
                        image: NetworkImage(
                          (courseState.courseSelected?.imageUrl == null ||
                                  courseState.courseSelected!.imageUrl!.isEmpty)
                              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBu0USCFZwKnomMof7OSN2zIbPlEiV-bmMAw&s'
                              : courseState.courseSelected!.imageUrl!,
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SimpleText(
                              '${courseState.courseSelected?.courseName}',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            SizedBox(height: 15),
                            SimpleText(
                              'SU NOMBRE COMPLETO TAL COMO SALDRÁ EN SU CERTIFICADO:',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () =>
                                    context.push(UserProfileScreen.routeName),
                                child: Card(
                                  child: SimpleText(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    '${userInfoState.user?.firstName} ${userInfoState.user?.lastName}'
                                        .toTitleCase(),
                                    style: textTheme.titleSmall!.copyWith(
                                        color: colorScheme.secondary,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            const SimpleText(
                              'Si desea que su nombre aparezca de otra forma, por favor ve a tu perfil y modifícalo*',
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                            ),
                            SizedBox(height: 15),
                            SimpleText(
                              '${courseState.courseSelected?.courseDescription}'
                                  .toCapitalize(),
                              fontSize: 14,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              lineHeight: 1.7,
                              fontWeight: FontWeight.w400,
                            ),
                            /* TODO add condiction to show 'S' */
                            SimpleText(
                              hasMultipleProfessors
                                  ? 'Especialistas invitados'
                                  : 'Especialista invitado',
                              fontSize: 16,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              fontWeight: FontWeight.w600,
                            ),
                            if (courseState.courseSelected?.professors != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: courseState.courseSelected!.professors
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
                                    trailing: isValidateString(e.user!.urlImage) ?  CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                         e.user!.urlImage!
                                      ),
                                    ) : const SizedBox(),
                                  );
                                }).toList(),
                              ),
                            DataTable(
                              rows: [
                                customDataRow('Modadidad',
                                    '${courseState.courseSelected?.modality}'),
                                customDataRow('Inversión',
                                    '${courseState.courseSelected?.coursePrice}'),
                                customDataRow('Material',
                                    '${courseState.courseSelected?.material}'),
                                customDataRow('Más información',
                                    '${courseState.courseSelected?.informationContact}'),
                                customDataRow('Notas',
                                    '${courseState.courseSelected?.notes}'),
                              ],
                              columns: [
                                DataColumn(label: Text('')),
                                DataColumn(label: Text('')),
                              ],
                            ),
                            SizedBox(
                              height: 250,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LoginButton(
              showIcon: false,
              text: ('Registrarse'),
              onPressed: () {
                print(
                    "Estado después de limpiar: ${courseState.courseSelected}");
              },
            ),
          )
        ],
      ),
    ));
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
