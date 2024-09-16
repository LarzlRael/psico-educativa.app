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

    return SizedBox(
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
                    : InstaImageViewer(
                      child: selectedImage.value == null
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
                      radius: iconCameraSize-5,
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
