import 'package:image_diary/app_container.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_mode_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_detail_page_view_model.g.dart';

@riverpod
class ShowDetailPageViewModel extends _$ShowDetailPageViewModel {
  @override
  ShowDetailPageViewModelState build(PageModel page) {
    return ShowDetailPageViewModelState(page: page);
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
        imageQuality: 50
    );

    state = state.copyWith(image: image);
  }

  bool isUpdatable() {
    var result = false;

    if((state.title != '') ||
        (state.content != '') ||
        (state.image != null)) {
      result = true;
    }
    return result;
  }

  Future<void> delete({
    Function()? onLoading,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = ref.read(pageRepositoryProvider);
    await repository.delete(state.page);

    if(onSuccess != null) onSuccess();
  }

  Future<void> update({
    Function()? onLoading,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    // if(onLoading != null) onLoading();
    // await _delete();
    // await _insert();
    // if(onSuccess != null) onSuccess();
  }

  // Future<void> _delete() async {
  //   final oldPageData = state.page;
  //   final repo = ref.read(pageRepositoryProvider);
  //   await repo.delete(oldPageData);
  // }
  //
  // Future<void> _insert() async {
  //   final title = state.title;
  //   final content = state.content;
  //   final image = state.image;
  //
  //   final page = PageModel(
  //     title: (title != '') ? title : state.page.title,
  //     content: (content != '') ? content : state.page.content,
  //     date: DateTime.now().millisecondsSinceEpoch,
  //     imagePath: (image != null) ? image.path : state.page.imagePath,
  //   );
  //
  //   final repository = ref.read(pageRepositoryProvider);
  //   await repository.insert(page);
  // }
}