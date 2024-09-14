part of '../services.dart';

class CameraGalleryServiceImp extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<String?> selectOneImageFromGallery() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    // Verifica si se seleccionó una imagen y devuelve la ruta de la imagen
    return photo?.path;
  }

  @override
  Future<List<String>?> selectMultipleImagesFromGallery() async {
    final List<XFile> photos = await _picker.pickMultiImage(
      imageQuality: 80,
    );

    if (photos.isEmpty) {
      return null;
    }

    final List<String> photoPaths = photos.map((photo) => photo.path).toList();
    return photoPaths;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;
    return photo.path;
  }
}
