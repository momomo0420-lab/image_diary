import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:image_diary/ui/add_page/add_page_view_model_state.dart';
import 'package:image_diary/ui/widget/image_container.dart';
import 'package:image_diary/ui/widget/multiple_lines_text_field.dart';
import 'package:image_diary/ui/widget/one_line_text_field.dart';
import 'package:loader_overlay/loader_overlay.dart';


/// ページ追加用スクリーンのメイン
class AddPageBody extends HookWidget {
  final AddPageViewModel _viewModel;
  final AddPageViewModelState _state;
  final Function()? _onWritingButtonPressed;

  /// コンストラクタ
  const AddPageBody({
    super.key,
    required AddPageViewModel viewModel,
    required AddPageViewModelState state,
    Function()? onWritingButtonPressed,
  }): _viewModel = viewModel,
        _state = state,
        _onWritingButtonPressed = onWritingButtonPressed;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageContainer(
          image: _state.image,
          onTap: () => _viewModel.pickImage(),
        ),
        const SizedBox(height: 10),

        // 題名の入力フォーム
        OneLineTextField(
          controller: useTextEditingController(),
          label: '題名',
          hint: 'ここに題名を入力してください。',
          onChanged: (title) => _viewModel.setTitle(title),
          onClear: () => _viewModel.setTitle(''),
        ),
        const SizedBox(height: 10),

        // 内容の入力フォーム
        MultipleLinesTextField(
          controller: useTextEditingController(),
          label: '内容',
          hint: 'ここに内容を入力してください。',
          onChanged: (content) => _viewModel.setContent(content),
        ),
        const SizedBox(height: 10),

        Center(
          child: ElevatedButton(
            onPressed: !_viewModel.isWritable() ? null :
              () => _viewModel.addPage(
                onLoading: () => context.loaderOverlay.show(),
                onSuccess: () {
                  context.loaderOverlay.hide();
                  if(_onWritingButtonPressed != null) _onWritingButtonPressed!();
                },
              ),
            child: const Text('書き込む'),
          ),
        )
      ],
    );
  }
}
