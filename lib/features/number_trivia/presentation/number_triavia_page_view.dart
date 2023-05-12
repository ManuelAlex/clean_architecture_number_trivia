import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/providers/loading_provider.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/providers/number_trivia_provider.dart';

import 'riverpod/providers/number_trivia_with_trivia_provider.dart';

class NumberTriviaPageView extends ConsumerStatefulWidget {
  const NumberTriviaPageView({super.key});

  @override
  ConsumerState<NumberTriviaPageView> createState() =>
      _NumberTriviaPageViewState();
}

class _NumberTriviaPageViewState extends ConsumerState<NumberTriviaPageView> {
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final triviaState = ref.watch(numberTriviaStateProvider);

    String absentText = 'Input a number';
    final trivia = ref.watch(providerWithTrivia);
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: Text(
                trivia?.triviaText ?? absentText,
                style: Theme.of(context).textTheme.headlineMedium,
              )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    hintText: 'Input a number to get the Trivia',
                  ),
                  controller: controller,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () async {
                    await ref
                        .read(numberTriviaStateProvider.notifier)
                        .getConcreteNuberTrivia(numString: controller.text);
                    controller.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Get Number Trivia'),
                )),
                Expanded(
                    child: TextButton(
                  onPressed: () async {
                    await ref
                        .read(numberTriviaStateProvider.notifier)
                        .getRandomNuberTrivia();
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Get Random Trivia'),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
