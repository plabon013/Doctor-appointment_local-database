import 'package:doctor_appointment/views/pages/search_page.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
      Navigator.pushNamed(context, SearchPage.routeName);
    },
      child:  Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10,),
            const Icon(Icons.search, color: Colors.grey,),
            const SizedBox(width: 20,),
            CustomText(text: 'Search a doctor', isTitle: false, color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
