import 'package:basic_project/base/theme/spacing.dart';
import 'package:basic_project/base/logger.dart';
import 'package:basic_project/base/ui/components/app_app_bar.dart';
import 'package:basic_project/base/ui/components/page_title.dart';
import 'package:basic_project/base/ui/components/primary_button.dart';
import 'package:basic_project/base/ui/components/app_text_field.dart';
import 'package:basic_project/presentation/todo/todo_providers.dart';
import 'package:basic_project/presentation/todo/todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logI('Enter TodoPage');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoViewModelProvider);
    final vm = ref.read(todoViewModelProvider.notifier);
    return Scaffold(
      appBar: AppAppBar(titleText: 'TODO'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Insets.xl, Insets.xl, Insets.xl, Insets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageTitle(text: '할 일 목록', subtitle: '간단한 TODO 예제'),
                const SizedBox(height: Insets.lg),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _ctrl,
                        hintText: '할 일을 입력하세요',
                        onSubmitted: (v) {
                          if (v.trim().isEmpty) return;
                          vm.add(v.trim());
                          _ctrl.clear();
                        },
                      ),
                    ),
                    const SizedBox(width: Insets.md),
                    PrimaryButton(
                      label: '추가',
                      icon: Icons.add,
                      onPressed: () {
                        final v = _ctrl.text.trim();
                        if (v.isEmpty) return;
                        vm.add(v);
                        _ctrl.clear();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (state.isLoading) const LinearProgressIndicator(),
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(Insets.md),
              child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: ListView.separated(
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Dismissible(
                  key: ValueKey('todo_${item.id}'),
                  background: Container(color: Colors.redAccent),
                  onDismissed: (_) => vm.remove(item.id),
                  child: ListTile(
                    title: Text(item.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditDialog(context, vm, item.id, item.title),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => vm.remove(item.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, TodoViewModel vm, int id, String title) async {
    final controller = TextEditingController(text: title);
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('제목 수정'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: '새 제목'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('취소')),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(controller.text.trim()), child: const Text('저장')),
          ],
        );
      },
    );
    if (result != null && result.isNotEmpty) {
      await vm.updateTitle(id, result);
    }
  }
}


