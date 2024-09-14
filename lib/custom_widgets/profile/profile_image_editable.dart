part of '../custom_widgets.dart';

class ProfileImageEdit extends HookWidget {
  final bool editable;
  final UserApi user;
  final double radius;
  const ProfileImageEdit({
    super.key,
    required this.user,
    this.editable = true,
    this.radius = 40,
  });

  @override
  Widget build(BuildContext context) {
    final selectedImage = useState<File?>(null);

    void selectGalleryPhoto() async {
      final pickedFile =
          await CameraGalleryServiceImp().selectOneImageFromGallery();
      if (pickedFile == null) return;
      selectedImage.value = File(pickedFile);
    }

    return GestureDetector(
      onTap: () async {
        if (!editable) return;
        selectGalleryPhoto();

        /* await showDialog(context: context, builder: (_) => PublicProfilePage()); */
      },
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Stack(
          children: [
            UserAvatar(
              username: user.username,
              firstName: user.firstName,
              lastName: user.lastName,
              radius: radius,
              customWidget:
                  user.profileImageUrl == null && selectedImage.value == null
                      ? null
                      : selectedImage.value == null
                          ? FadeInImage(
                              placeholder: const AssetImage(appIcon),
                              image: NetworkImage(
                                user.profileImageUrl!,
                              ),
                            )
                          : Image.file(
                              selectedImage.value!,
                              fit: BoxFit.cover,
                            ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: editable
                  ? const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14.0,
                      child: Icon(
                        Icons.camera_alt,
                        size: 16.0,
                        color: Color(0xFF404040),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
