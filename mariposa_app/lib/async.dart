import 'dart:async';

import 'package:mariposa/mariposa.dart';
import 'package:meta/meta.dart';

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Stream].
///
/// Widget rebuilding is scheduled by each interaction, using [State.setState],
/// but is otherwise decoupled from the timing of the stream.
///
/// As an example, when interacting with a stream producing the integers
/// 0 through 9, the [builder] may be called with any ordered sub-sequence
/// of the following snapshots that includes the last one (the one with
/// ConnectionState.done):
///
/// * `new AsyncSnapshot<int>.withData(ConnectionState.waiting, null)`
/// * `new AsyncSnapshot<int>.withData(ConnectionState.active, 0)`
/// * `new AsyncSnapshot<int>.withData(ConnectionState.active, 1)`
/// * ...
/// * `new AsyncSnapshot<int>.withData(ConnectionState.active, 9)`
/// * `new AsyncSnapshot<int>.withData(ConnectionState.done, 9)`
///
/// The stream may produce errors, resulting in snapshots of the form:
///
/// * `new AsyncSnapshot<int>.withError(ConnectionState.active, 'some error')`
///
/// The data and error fields of snapshots produced are only changed when the
/// state is `ConnectionState.active`.
///
/// The initial snapshot data can be controlled by specifying [initialData].
/// You would use this facility to ensure that if the [builder] is invoked
/// before the first event arrives on the stream, the snapshot carries data of
/// your choice rather than the default null value.
///
/// ## Sample code
///
/// This sample shows a [StreamBuilder] configuring a text label to show the
/// latest bid received for a lot in an auction. Assume the `_lot` field is
/// set by a selector elsewhere in the UI.
///
/// ```dart
/// // Displays a counter that increments every second
/// new StreamBuilder<int>(
///   initialData: 0,
///   stream: Stream.periodic(Duration(seconds: 1), (i) => ++i;),
///   builder: (RenderContext context, AsyncSnapshot<int> snapshot) {
///     return Text('${snapshot.data}');
///   },
/// )
/// ```
class StreamBuilder<T> extends StatefulWidget {
  /// Creates a new [StreamBuilder] that builds itself based on the latest
  /// snapshot of interaction with the specified [stream] and whose build
  /// strategy is given by [builder]. The [initialData] is used to create the
  /// initial snapshot. It is null by default.
  StreamBuilder({
    @required this.builder,
    @required this.stream,
    this.initialData,
  });

  /// Returns a Widget based on the latest value or error from the Stream
  /// in the form contained within an [AsyncSnapshot].
  final Node Function(RenderContext context, AsyncSnapshot<T> snapshot) builder;

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  final Stream<T> stream;

  /// The data that will be used to create the initial snapshot. Null by default.
  final T initialData;

  @override
  _StreamBuilderState createState() {
    return _StreamBuilderState<T>();
  }

  AsyncSnapshot<T> initial() =>
      new AsyncSnapshot<T>.withData(ConnectionState.none, initialData);

  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.waiting);

  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    return new AsyncSnapshot<T>.withData(ConnectionState.active, data);
  }

  AsyncSnapshot<T> afterError(AsyncSnapshot<T> current, Object error) {
    return new AsyncSnapshot<T>.withError(ConnectionState.active, error);
  }

  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.done);

  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) =>
      current.inState(ConnectionState.none);
}

class _StreamBuilderState<T> extends State<StreamBuilder<T>> {
  StreamSubscription<T> subscription;
  AsyncSnapshot<T> _summary;

  @override
  Node render() => Div(children: [widget.builder(renderContext, _summary)]);

  @override
  void initState() {
    super.initState();
    _summary = widget.initial();
    _subscribe();
  }

  @override
  void deactivate() {
    subscription?.cancel();
    super.deactivate();
  }

  void _subscribe() {
    if (widget.stream != null) {
      subscription = widget.stream.listen((T data) {
        setState(() {
          _summary = widget.afterData(_summary, data);
        });
      }, onError: (Object error) {
        setState(() {
          _summary = widget.afterError(_summary, error);
        });
      }, onDone: () {
        setState(() {
          _summary = widget.afterDone(_summary);
        });
      });
      _summary = widget.afterConnected(_summary);
    }
  }
}

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Future].
///
/// The [future] must have been obtained earlier, e.g. during [State.initState],
/// [State.didUpdateConfig], or [State.didChangeDependencies]. It must not be
/// created during the [State.build] or [StatelessWidget.build] method call when
/// constructing the [FutureBuilder]. If the [future] is created at the same
/// time as the [FutureBuilder], then every time the [FutureBuilder]'s parent is
/// rebuilt, the asynchronous task will be restarted.
///
/// A general guideline is to assume that every `build` method could get called
/// every frame, and to treat omitted calls as an optimization.
///
/// ## Timing
///
/// Widget rebuilding is scheduled by the completion of the future, using
/// [State.setState], but is otherwise decoupled from the timing of the future.
/// The [builder] callback is called at the discretion of the Flutter pipeline, and
/// will thus receive a timing-dependent sub-sequence of the snapshots that
/// represent the interaction with the future.
///
/// A side-effect of this is that providing a new but already-completed future
/// to a [FutureBuilder] will result in a single frame in the
/// [ConnectionState.waiting] state. This is because there is no way to
/// synchronously determine that a [Future] has already completed.
///
/// ## Builder contract
///
/// For a future that completes successfully with data, assuming [initialData]
/// is null, the [builder] will be called with either both or only the latter of
/// the following snapshots:
///
/// * `new AsyncSnapshot<String>.withData(ConnectionState.waiting, null)`
/// * `new AsyncSnapshot<String>.withData(ConnectionState.done, 'some data')`
///
/// If that same future instead completed with an error, the [builder] would be
/// called with either both or only the latter of:
///
/// * `new AsyncSnapshot<String>.withData(ConnectionState.waiting, null)`
/// * `new AsyncSnapshot<String>.withError(ConnectionState.done, 'some error')`
///
/// The initial snapshot data can be controlled by specifying [initialData]. You
/// would use this facility to ensure that if the [builder] is invoked before
/// the future completes, the snapshot carries data of your choice rather than
/// the default null value.
///
/// The data and error fields of the snapshot change only as the connection
/// state field transitions from `waiting` to `done`, and they will be retained
/// when changing the [FutureBuilder] configuration to another future. If the
/// old future has already completed successfully with data as above, changing
/// configuration to a new future results in snapshot pairs of the form:
///
/// * `new AsyncSnapshot<String>.withData(ConnectionState.none, 'data of first future')`
/// * `new AsyncSnapshot<String>.withData(ConnectionState.waiting, 'data of second future')`
///
/// In general, the latter will be produced only when the new future is
/// non-null, and the former only when the old future is non-null.
///
/// A [FutureBuilder] behaves identically to a [StreamBuilder] configured with
/// `future?.asStream()`, except that snapshots with `ConnectionState.active`
/// may appear for the latter, depending on how the stream is implemented.
///
/// ## Sample code
///
/// This sample shows a [FutureBuilder] configuring a text label to show the
/// state of an asynchronous calculation returning a string. Assume the
/// `_calculation` field is set by pressing a button elsewhere in the UI.
///
/// ```dart
/// new FutureBuilder<String>(
///   future: _calculation, // a previously-obtained Future<String> or null
///   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
///     switch (snapshot.connectionState) {
///       case ConnectionState.none:
///         return new Text('Press button to start.');
///       case ConnectionState.active:
///       case ConnectionState.waiting:
///         return new Text('Awaiting result...');
///       case ConnectionState.done:
///         if (snapshot.hasError)
///           return new Text('Error: ${snapshot.error}');
///         return new Text('Result: ${snapshot.data}');
///     }
///     return null; // unreachable
///   },
/// )
/// ```
class FutureBuilder<T> extends StatefulWidget {
  /// Creates a widget that builds itself based on the latest snapshot of
  /// interaction with a [Future].
  ///
  /// The [builder] must not be null.
  FutureBuilder({
    @required this.builder,
    @required this.future,
    this.initialData,
  });

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  ///
  /// If no future has yet completed, including in the case where [future] is
  /// null, the data provided to the [builder] will be set to [initialData].
  final Future<T> future;

  /// The build strategy currently used by this builder.
  ///
  /// The builder is provided with an [AsyncSnapshot] object whose
  /// [AsyncSnapshot.connectionState] property will be one of the following
  /// values:
  ///
  ///  * [ConnectionState.none]: [future] is null. The [AsyncSnapshot.data] will
  ///    be set to [initialData], unless a future has previously completed, in
  ///    which case the previous result persists.
  ///
  ///  * [ConnectionState.waiting]: [future] is not null, but has not yet
  ///    completed. The [AsyncSnapshot.data] will be set to [initialData],
  ///    unless a future has previously completed, in which case the previous
  ///    result persists.
  ///
  ///  * [ConnectionState.done]: [future] is not null, and has completed. If the
  ///    future completed successfully, the [AsyncSnapshot.data] will be set to
  ///    the value to which the future completed. If it completed with an error,
  ///    [AsyncSnapshot.hasError] will be true and [AsyncSnapshot.error] will be
  ///    set to the error object.
  final Node Function(RenderContext context, AsyncSnapshot<T> snapshot) builder;

  /// The data that will be used to create the snapshots provided until a
  /// non-null [future] has completed.
  ///
  /// If the future completes with an error, the data in the [AsyncSnapshot]
  /// provided to the [builder] will become null, regardless of [initialData].
  /// (The error itself will be available in [AsyncSnapshot.error], and
  /// [AsyncSnapshot.hasError] will be true.)
  final T initialData;

  @override
  State<FutureBuilder<T>> createState() => new _FutureBuilderState<T>();
}

/// State for [FutureBuilder].
class _FutureBuilderState<T> extends State<FutureBuilder<T>> {
  AsyncSnapshot<T> _snapshot;

  @override
  void initState() {
    super.initState();
    _snapshot =
        new AsyncSnapshot<T>.withData(ConnectionState.none, widget.initialData);
    _subscribe();
  }

  void _subscribe() {
    if (widget.future != null) {
      widget.future.then<void>((T data) {
        setState(() {
          _snapshot = new AsyncSnapshot<T>.withData(ConnectionState.done, data);
        });
      }, onError: (Object error) {
        setState(() {
          _snapshot =
              new AsyncSnapshot<T>.withError(ConnectionState.done, error);
        });
      });
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  @override
  Node render() {
    return Div(children: [widget.builder(renderContext, _snapshot)]);
  }
}

/// The state of connection to an asynchronous computation.
///
/// See also:
///
/// * [AsyncSnapshot], which augments a connection state with information
/// received from the asynchronous computation.
enum ConnectionState {
  /// Not currently connected to any asynchronous computation.
  ///
  /// For example, a [FutureBuilder] whose [FutureBuilder.future] is null.
  none,

  /// Connected to an asynchronous computation and awaiting interaction.
  waiting,

  /// Connected to an active asynchronous computation.
  ///
  /// For example, a [Stream] that has returned at least one value, but is not
  /// yet done.
  active,

  /// Connected to a terminated asynchronous computation.
  done,
}

/// Immutable representation of the most recent interaction with an asynchronous
/// computation.
///
/// See also:
///
/// * [StreamBuilder], which builds itself based on a snapshot from interacting
///   with a [Stream].
/// * [FutureBuilder], which builds itself based on a snapshot from interacting
///   with a [Future].
@immutable
class AsyncSnapshot<T> {
  /// Creates an [AsyncSnapshot] with the specified [connectionState],
  /// and optionally either [data] or [error] (but not both).
  const AsyncSnapshot._(this.connectionState, this.data, this.error)
      : assert(connectionState != null),
        assert(!(data != null && error != null));

  /// Creates an [AsyncSnapshot] in [ConnectionState.none] with null data and error.
  const AsyncSnapshot.nothing() : this._(ConnectionState.none, null, null);

  /// Creates an [AsyncSnapshot] in the specified [state] and with the specified [data].
  const AsyncSnapshot.withData(ConnectionState state, T data)
      : this._(state, data, null);

  /// Creates an [AsyncSnapshot] in the specified [state] and with the specified [error].
  const AsyncSnapshot.withError(ConnectionState state, Object error)
      : this._(state, null, error);

  /// Current state of connection to the asynchronous computation.
  final ConnectionState connectionState;

  /// The latest data received by the asynchronous computation.
  ///
  /// If this is non-null, [hasData] will be true.
  ///
  /// If [error] is not null, this will be null. See [hasError].
  ///
  /// If the asynchronous computation has never returned a value, this may be
  /// set to an initial data value specified by the relevant widget. See
  /// [FutureBuilder.initialData] and [StreamBuilder.initialData].
  final T data;

  /// Returns latest data received, failing if there is no data.
  ///
  /// Throws [error], if [hasError]. Throws [StateError], if neither [hasData]
  /// nor [hasError].
  T get requireData {
    if (hasData) return data;
    if (hasError) throw error;
    throw new StateError('Snapshot has neither data nor error');
  }

  /// The latest error object received by the asynchronous computation.
  ///
  /// If this is non-null, [hasError] will be true.
  ///
  /// If [data] is not null, this will be null.
  final Object error;

  /// Returns a snapshot like this one, but in the specified [state].
  ///
  /// The [data] and [error] fields persist unmodified, even if the new state is
  /// [ConnectionState.none].
  AsyncSnapshot<T> inState(ConnectionState state) =>
      new AsyncSnapshot<T>._(state, data, error);

  /// Returns whether this snapshot contains a non-null [data] value.
  ///
  /// This can be false even when the asynchronous computation has completed
  /// successfully, if the computation did not return a non-null value. For
  /// example, a [Future<void>] will complete with the null value even if it
  /// completes successfully.
  bool get hasData => data != null;

  /// Returns whether this snapshot contains a non-null [error] value.
  ///
  /// This is always true if the asynchronous computation's last result was
  /// failure.
  bool get hasError => error != null;

  @override
  String toString() => '$runtimeType($connectionState, $data, $error)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AsyncSnapshot &&
          runtimeType == other.runtimeType &&
          connectionState == other.connectionState &&
          data == other.data &&
          error == other.error;

  @override
  int get hashCode => connectionState.hashCode ^ data.hashCode ^ error.hashCode;
}
