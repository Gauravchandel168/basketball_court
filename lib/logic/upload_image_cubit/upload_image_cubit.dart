import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../presentation/routers/app_routers.dart';

class UploadImageCubit extends Cubit<ImageClass> {
  UploadImageCubit() : super(ImageClass());
  init(String networkImage) {
    emit(ImageClass(networkImage: networkImage));
    // print(state.networkImage);
  }

  onImageChange(String imagePath) {
    ImageClass model = ImageClass(localImage: imagePath).changeImage(true);
    emit(model);
  }

  delete() {
    emit(ImageClass(networkImage: state.networkImage).changeImage(false));
  }

  selectImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      final file = File(
        pickedFile.path,
      );
      emit(ImageClass(localImage: file.path, networkImage: state.networkImage)
          .changeImage(true));
      AppRouter.navigatorKey.currentState?.pop();
    } else {
      emit(ImageClass(networkImage: state.networkImage));
      AppRouter.navigatorKey.currentState?.pop();
    }
  }

  closeCubit() {
    emit(ImageClass());
  }

}

class ImageClass {
  final String? networkImage;
  final String? localImage;
  bool hasLocalImage = false;

  ImageClass({this.networkImage, this.localImage});
  changeImage(bool value) {
    hasLocalImage = value;
    return this;
  }
}
