import 'package:core/components.dart';
import 'package:core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'home_links_loading_view.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverStickyHeader(
          header: const LmuTabBarLoading(
            hasDivider: true,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: LmuSizes.size_24),
                const HomeLinksLoadingView(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LmuSizes.size_16,
                    vertical: LmuSizes.size_16,
                  ),
                  child: LmuContentTile(
                    content: List.generate(3, (index) => 
                      const LmuListItemLoading(
                        titleLength: 2,
                        action: LmuListItemAction.toggle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}