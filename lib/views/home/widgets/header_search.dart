import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/text_input_search.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextInputSearch(
            labelText: 'Buscar articulo',
            controller: searchController,
            inputType: TextInputType.emailAddress,
            visibleText: false,
            isPass: false,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          child: SvgPicture.asset('assets/user-circle.svg'),
        ),
      ],
    );
  }
}
