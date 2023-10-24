import 'package:image_diary/app_container.dart';
import 'package:image_diary/data/local_db/model/page_model.dart';
import 'package:image_diary/ui/add_page/add_page_view_model_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_page_view_model.g.dart';

@riverpod
class AddPageViewModel extends _$AddPageViewModel {
  @override
  AddPageViewModelState build() {
    return const AddPageViewModelState();
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  /// 端末に存在する画像を選択し、取得する。
  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    state = state.copyWith(image: image);
  }

  /// ページを登録する
  Future<void> addPage({
    Function()? onLoading,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final page = PageModel(
      title: state.title,
      content: state.content,
      date: DateTime.now().millisecondsSinceEpoch,
      imagePath: state.image?.path ?? "",
    );

    final repository = ref.read(pageRepositoryProvider);
    await repository.insert(page);

    if(onSuccess != null) onSuccess();
  }

  bool isWritable() {
    bool result = true;

    if((state.title == "") ||
        (state.content == "") ||
        (state.image == null)) {

      result = false;
    }

    return result;
  }
}
