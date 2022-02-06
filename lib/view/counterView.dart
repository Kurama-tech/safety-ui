import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_safety/provider/counter.dart';
import 'package:provider/provider.dart';

class Count extends StatelessWidget {
  const Count({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

        /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
        '${context.watch<Counter>().count}',
        key: const Key('counterState'),
        style: Theme.of(context).textTheme.headline4);
  }
}
