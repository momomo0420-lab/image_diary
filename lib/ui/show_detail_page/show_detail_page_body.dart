import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_mode_state.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_model.dart';
import 'package:image_diary/ui/widget/image_container.dart';
import 'package:image_diary/ui/widget/multiple_lines_text_field.dart';
import 'package:image_diary/ui/widget/one_line_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends HookWidget {
  final ShowDetailPageViewModel _viewModel;
  final ShowDetailPageViewModelState _state;
  final Function()? _onUpdateButtonPressed;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required ShowDetailPageViewModel viewModel,
    required ShowDetailPageViewModelState state,
    Function()? onUpdateButtonPressed,
  }): _viewModel = viewModel,
        _state = state,
        _onUpdateButtonPressed = onUpdateButtonPressed;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageContainer(
          image: (_state.image == null) ? XFile(_state.page.imagePath) : _state.image,
          onTap: () => _viewModel.pickImage(),
        ),
        const SizedBox(height: 16,),

        OneLineTextField(
          controller: useTextEditingController(),
          hint: _state.page.title,
          onChanged: (title) => _viewModel.setTitle(title),
          onClear: () => _viewModel.setTitle(''),
        ),
        const SizedBox(height: 16,),

        MultipleLinesTextField(
          controller: useTextEditingController(),
          hint: _state.page.content,
          onChanged: (content) => _viewModel.setContent(content),
        ),
        const SizedBox(height: 16,),

        Center(
          child: ElevatedButton(
            onPressed: !_viewModel.isUpdatable() ? null :
              () => _viewModel.update(
                onLoading: () => context.loaderOverlay.show(),
                onSuccess: () {
                  context.loaderOverlay.hide();
                  if(_onUpdateButtonPressed != null) _onUpdateButtonPressed!();
                }
              ),
            child: const Text('更新する'),
          ),
        )
      ],
    );
  }
}
