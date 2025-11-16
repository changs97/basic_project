import 'package:basic_project/presentation/home/home_providers.dart';
import 'package:basic_project/base/logger.dart';
import 'package:basic_project/base/ui/components/app_app_bar.dart';
import 'package:basic_project/base/ui/components/primary_button.dart';
import 'package:basic_project/base/ui/components/secondary_button.dart';
import 'package:basic_project/base/ui/components/page_title.dart';
import 'package:basic_project/base/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerStatefulWidget {
  const CounterPage({super.key});

  @override
  ConsumerState<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends ConsumerState<CounterPage> {
  @override
  void initState() {
    super.initState();
    logI('Enter CounterPage');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(counterViewModelProvider);
    final vm = ref.read(counterViewModelProvider.notifier);

    return Scaffold(
      appBar: AppAppBar(titleText: '카운트 화면'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.xl),
              child: PageTitle(text: '카운트', subtitle: '간단한 카운터 데모'),
            ),
            const SizedBox(height: Insets.lg),
            if (state.isLoading) const CircularProgressIndicator(),
            if (!state.isLoading) ...[
              Text(
                'Counter: ${state.counter.value}',
                key: const ValueKey('counter_value'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(label: '증가', icon: Icons.add, onPressed: vm.increment),
                const SizedBox(width: Insets.lg),
                SecondaryButton(label: '리셋', icon: Icons.refresh, onPressed: vm.reset),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


