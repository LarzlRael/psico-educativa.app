part of '../custom_widgets.dart';

class ProfileImageEdit extends HookWidget {
  final bool editable;
  final UserApi user;
  final double radius;
  final double iconCameraSize;
  final Function(String filePath) onImageSelected;

  const ProfileImageEdit({
    super.key,
    required this.user,
    required this.onImageSelected,
    this.editable = true,
    this.iconCameraSize = 16.0,
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
      onImageSelected(pickedFile);
    }

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        /* boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ], */
      ),
      child: Stack(
        children: [
          UserAvatar(
            username: user.username,
            firstName: user.firstName,
            lastName: user.lastName,
            radius: radius,
            customWidget: !isValidateString(user.profileImageUrl) &&
                    selectedImage.value == null
                ? null
                : InstaImageViewer(
                    child: selectedImage.value == null
                        ? FadeInImage(
                            fit: BoxFit.cover,
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
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: editable
                ? GestureDetector(
                    onTap: () {
                      if (!editable) return;

                      selectGalleryPhoto();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: iconCameraSize - 5,
                      child: Icon(
                        Icons.camera_alt,
                        size: iconCameraSize,
                        color: const Color(0xFF404040),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
