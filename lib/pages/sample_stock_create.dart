import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';

import '../router/app_router.dart';
import '../widgets/localized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class SampleStockCreatePage extends LocalizedStatefulWidget {
  const SampleStockCreatePage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<SampleStockCreatePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends LocalizedState<SampleStockCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ReactiveFormBuilder(
            form: () => buildForm(),
            builder: (context, form, child) => ScrollableContent(
                  enableFixedDigitButton: true,
                  header: Text('Heading'),
                  footer: DigitCard(
                    children: [
                      DigitButton(
                        label: 'Submit',
                        onPressed: () {
                          // final memberCount = form.control('_memberCountKey').value as int?  ;
                        },
                        type: DigitButtonType.primary,
                        size: DigitButtonSize.large,
                      )
                    ],
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: DigitCard(
                        children: [],
                      ),
                    )
                  ],
                )));
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{
      '_memberCountKey': FormControl<int>(),
      '_stockHeadNameKey': FormControl<String>()
    });
  }
}
