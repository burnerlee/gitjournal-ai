/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'package:hive/hive.dart';
import 'package:mutex/mutex.dart';
import 'package:path/path.dart' as p;

import 'package:gitjournal/core/note.dart';
import 'package:gitjournal/logger/logger.dart';

typedef NotesViewComputer<T> = Future<T> Function(Note note);

class NotesMaterializedView<T> {
  Box? storageBox;
  late final String name;

  final NotesViewComputer<T> computeFn;

  final _readMutex = ReadWriteMutex();
  final _writeMutex = Mutex();

  NotesMaterializedView({
    required String name,
    required this.computeFn,
    required String repoId,
  }) {
    this.name = "${repoId}_${name}_v2";
  }

  // FIXME: The return value doesn't need to be optional
  // FIXME: Use a LazyBox instead and add a cache on top?
  // FIXME: Maybe removing all the old keys after each put is too expensive?

  Future<T> fetch(Note note) async {
    assert(!note.filePath.startsWith(p.separator));
    assert(!note.filePath.endsWith(p.separator));
    assert(note.oid.isNotEmpty);

    var ts = note.fileLastModified.toUtc().millisecondsSinceEpoch ~/ 1000;
    var key = '${note.oid}_$ts';

    // Open the Box
    await _readMutex.protectRead(() async {
      if (storageBox != null) return;

      await _writeMutex.protect(() async {
        if (storageBox != null) return;

        var stopwatch = Stopwatch()..start();
        try {
          storageBox = await Hive.openBox<T>(name);
        } on HiveError catch (ex, st) {
          Log.e("HiveError $name", ex: ex, stacktrace: st);

          // Get the file Path
          await Hive.deleteBoxFromDisk(name);
          storageBox = await Hive.openBox<T>(name);
        }

        Log.i("Loading View $name: ${stopwatch.elapsed}");
      });
    });

    var box = storageBox!;

    T? val = box.get(key, defaultValue: null);
    if (val == null) {
      val = await computeFn(note);
      box.put(key, val);
    }

    return val!;
  }
}
