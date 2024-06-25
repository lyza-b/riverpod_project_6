import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
void main() {
runApp(
const ProviderScope(child: MyApp()),
);
}
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
 theme: ThemeData(
),
  home: const HomePage(),
 );
}
}
class HomePage extends ConsumerWidget {
 const HomePage({super.key
});
@override
 Widget build(BuildContext context, WidgetRef ref) {
 return Scaffold(
 appBar: AppBar(
 backgroundColor: Theme.of(context).colorScheme.inversePrimary,
title: Text('Hooks Riverpod'),
 centerTitle: true,
 ),
  );
}
}