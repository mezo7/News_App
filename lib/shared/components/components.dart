import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/wep_view_screen.dart';

Widget myDivaider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 2.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticalItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebviewScreen(article['url']),);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget articlelBuilder(list, BuildContext context,{isSearch=false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticalItem(list[index], context),
        separatorBuilder: (context, index) => myDivaider(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch ?Container(): Center(child: CircularProgressIndicator()),
    );

Widget defualtTextFormField({
  required controller,
  required TextInputType type,
  required FormFieldValidator validate,
  required String label,
  required IconData prefixIcon,
  IconButton? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed,
  Function()? onTap,
  ValueChanged<String>? onChange,
  bool isClicked = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClicked,
    );
void navigateTo(context, wedgit) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => wedgit,
    ));
