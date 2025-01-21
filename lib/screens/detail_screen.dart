import 'package:contactapp/main.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key,required this.detailScn});

  final ContactModel detailScn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Detail',),
        actions: [
          TextButton(onPressed: (){}, child: Text('Edit',style: theme.textTheme.titleLarge,))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(//show picture in detailscreen
                    backgroundImage: FileImage(detailScn.image),
                    radius: 70,
                  ),
                  const SizedBox(height: 10,),
                  //show name in detailscreen
                  Text(detailScn.name,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.surface,letterSpacing: 0.5,fontWeight: FontWeight.normal
                  ),),
                  SizedBox(height: 10,),
                  //show phone in detailscreen
                  Text(detailScn.phone,style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,letterSpacing: 0.5,fontWeight: FontWeight.normal
                  ),),
                    const SizedBox(height: 10,),
                   const  Divider(height: 10,thickness: 3,)
                ],
              ),
            ),
            const SizedBox(height: 30,),
            Text(detailScn.email,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.surface,letterSpacing: 0.5,fontWeight: FontWeight.normal,
            ),)

          ],
        ),
      ),
    );
  }
}
