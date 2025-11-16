import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warn, error, none }

class Logger {
  Logger._(this.tag);

  static LogLevel minLevel = LogLevel.debug;
  static bool showCaller = true;
  static bool useDebugPrint = true;

  final String? tag;

  static Logger withTag(String tag) => Logger._(tag);

  static final Logger _root = Logger._(null);

  void d(Object? message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  void i(Object? message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, error: error, stackTrace: stackTrace);
  }

  void w(Object? message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warn, message, error: error, stackTrace: stackTrace);
  }

  void e(Object? message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  void _log(LogLevel level, Object? message,
      {Object? error, StackTrace? stackTrace}) {
    if (level.index < minLevel.index || minLevel == LogLevel.none) return;
    final caller = showCaller ? _callerInfo(stackTrace ?? StackTrace.current) : '';
    final levelStr = _levelLabel(level);
    final tagStr = tag != null ? '[$tag] ' : '';
    final msg = '$levelStr $tagStr${message ?? ''}${caller.isNotEmpty ? '  $caller' : ''}'
        '${error != null ? ' | error: $error' : ''}';
    if (useDebugPrint) {
      debugPrint(msg);
    } else {
      developer.log(msg,
          name: tag ?? 'app',
          level: _developerLevel(level),
          error: error,
          stackTrace: stackTrace);
    }
  }

  static String _levelLabel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '[D]';
      case LogLevel.info:
        return '[I]';
      case LogLevel.warn:
        return '[W]';
      case LogLevel.error:
        return '[E]';
      case LogLevel.none:
        return '';
    }
  }

  static int _developerLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warn:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.none:
        return 0;
    }
  }

  static String _callerInfo(StackTrace stack) {
    // Try to find the first non-logger frame
    final frames = stack.toString().split('\n');
    for (final f in frames) {
      if (f.contains('logger.dart')) continue;
      // Example frame format (VM): #1      Class.method (package:path/file.dart:12:34)
      final idx = f.indexOf('(package:');
      if (idx != -1) {
        final sub = f.substring(idx + 1, f.length - 1); // remove parentheses
        return '($sub)';
      }
      // Web format or others may differ; provide minimal fallback
      if (f.contains('package:')) {
        final start = f.indexOf('package:');
        final end = f.indexOf(')', start);
        final slice = end != -1 ? f.substring(start, end) : f.substring(start);
        return '($slice)';
      }
    }
    return '';
  }
}

// Root logger convenience
void logD(Object? message, {Object? error, StackTrace? stackTrace}) =>
    Logger._root.d(message, error: error, stackTrace: stackTrace);
void logI(Object? message, {Object? error, StackTrace? stackTrace}) =>
    Logger._root.i(message, error: error, stackTrace: stackTrace);
void logW(Object? message, {Object? error, StackTrace? stackTrace}) =>
    Logger._root.w(message, error: error, stackTrace: stackTrace);
void logE(Object? message, {Object? error, StackTrace? stackTrace}) =>
    Logger._root.e(message, error: error, stackTrace: stackTrace);


