import 'package:core/components.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/benefits/benefits.dart';
import '../widgets/benefits/benefits.dart';

class BenefitsPage extends StatefulWidget {
  const BenefitsPage({super.key});

  @override
  State<BenefitsPage> createState() => _BenefitsPageState();
}

class _BenefitsPageState extends State<BenefitsPage> {
  @override
  void initState() {
    super.initState();
    final benefitsCubit = GetIt.I.get<BenefitsCubit>();
    if (benefitsCubit.state is! BenefitsLoadSuccess) {
      benefitsCubit.getBenefits();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LmuMasterAppBar(
      largeTitle: "Benefits",
      leadingAction: LeadingAction.back,
      body: BlocBuilder<BenefitsCubit, BenefitsState>(
        bloc: GetIt.I.get<BenefitsCubit>(),
        builder: (context, state) {
          return LmuPageAnimationWrapper(
            child: state is BenefitsLoadSuccess
                ? BenefitsContentView(key: const ValueKey("benefitsContent"), benefits: state.benefits)
                : const BenefitsLoadingView(key: ValueKey("benefitsLoading")),
          );
        },
      ),
    );
  }
}
