import 'package:faal/controllers/search_controller.dart';
import 'package:faal/widgets/anim/delayed_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../widgets/text_input_search.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(builder: (_) {
      return DelayedReveal(
        delay: const Duration(milliseconds: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextInputSearch(
                  labelText: 'Buscar articulo',
                  controller: searchController,
                  inputType: TextInputType.emailAddress,
                  visibleText: false,
                  isPass: false,
                  functionSubmited: (value) {
                    _.search(value);
                  }),
            ),
            const SizedBox(width: 10),
            SizedBox(
              child: SvgPicture.asset('assets/user-circle.svg'),
            ),
          ],
        ),
      );
    });
  }
}
