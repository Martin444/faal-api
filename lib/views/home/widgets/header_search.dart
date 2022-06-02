import 'package:flutter/material.dart';

import '../../../widgets/text_input_search.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextInputSearch(
      labelText: 'Buscar articulo',
      controller: searchController,
      inputType: TextInputType.emailAddress,
      visibleText: false,
      isPass: false,
    );
  }
}
