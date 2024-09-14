part of '../services.dart';

abstract class CameraGalleryService {
  Future<String?> takePhoto();
  Future<String?> selectOneImageFromGallery();
  Future<List<String>?> selectMultipleImagesFromGallery();
}
