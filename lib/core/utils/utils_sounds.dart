/* // utils_sounds.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// Enum para los tipos de sonido, se mantiene igual
enum SoundsType {
  assets,
  network,
  file,
  liveStream, // audioplayers no tiene un tipo 'liveStream' directo
}

// No es necesario declarar el reproductor como 'late' si se inicializa directamente
class UtilsSounds {
  // Instancia del reproductor de audio, puede ser final
  final AudioPlayer _audioPlayer;

  String path;
  SoundsType soundsType;
  double? playSpeed;
  // No hay un equivalente directo para 'Metas' en audioplayers,
  // la información del audio se maneja de forma diferente.
  bool autoStart;
  double? volume;

  UtilsSounds({
    required this.path,
    this.playSpeed,
    this.soundsType = SoundsType.assets,
    // 'metas' ya no se usa, lo he comentado
    this.autoStart = true,
    this.volume,
  }) : _audioPlayer = AudioPlayer() {
    // Escucha el estado para saber cuándo ha terminado
    // y liberar recursos si es necesario.
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        // Por ejemplo, aquí podrías liberar el reproductor
        // _audioPlayer.dispose();
      }
    });
  }

  UtilsSounds copyWith({
    String? path,
    SoundsType? soundsType,
    double? playSpeed,
    bool? autoStart,
    double? volume,
  }) => UtilsSounds(
    path: path ?? this.path,
    soundsType: soundsType ?? this.soundsType,
    playSpeed: playSpeed ?? this.playSpeed,
    autoStart: autoStart ?? this.autoStart,
    volume: volume ?? this.volume,
  );

  AudioPlayer get audioPlayer => _audioPlayer;

  /// Reproduce o pausa el sonido.
  Future<void> playOrPause() async {
    // audioplayers no tiene un método directo playOrPause()
    // en su lugar, se verifica el estado actual
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  /// Reproduce el sonido.
  Future<void> play() async => await _audioPlayer.resume();

  /// Pausa el sonido.
  Future<void> pause() async => await _audioPlayer.pause();

  /// Detiene el sonido.
  Future<void> stop() async => await _audioPlayer.stop();

  /// Establece el volumen (0.0 a 1.0).
  Future<void> setVolume(double vol) async {
    await _audioPlayer.setVolume(vol.clamp(0.0, 1.0));
  }

  /// Mueve la posición de reproducción a una duración específica.
  Future<void> seek(Duration to) async {
    await _audioPlayer.seek(to);
  }

  // audioplayers no tiene un método directo seekBy(). Se puede emular
  // obteniendo la posición actual y sumando/restando.
  //
  // Future<void> seekBy(Duration by) async {
  //   final currentPosition = await _audioPlayer.getCurrentPosition();
  //   if (currentPosition != null) {
  //     await _audioPlayer.seek(currentPosition + by);
  //   }
  // }
  //
  // No hay un equivalente directo para forwardOrRewind. Se puede
  // emular con 'seekBy' como se muestra arriba.

  /// Abre el sonido según el tipo especificado.
  Future<void> openSound() async {
    Source source;
    if (soundsType == SoundsType.network) {
      source = UrlSource(path);
    } else if (soundsType == SoundsType.file) {
      source = DeviceFileSource(path);
    } else {
      // liveStream no tiene un tipo directo, se usa UrlSource para streaming
      // de red. En 'assets' se usa AssetSource.
      source = AssetSource(path);
    }

    try {
      await _audioPlayer.setSource(source);
      if (volume != null) await _audioPlayer.setVolume(volume!);
      if (autoStart) await _audioPlayer.resume();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  // ======

  ///
  /// Crea, abre, reproduce y libera el reproductor al finalizar.
  void playAndForget() {
    // audioplayers no tiene un método playAndForget directo,
    // se puede implementar creando una instancia temporal.
    final player = AudioPlayer();
    Source source;
    if (soundsType == SoundsType.network) {
      source = UrlSource(path);
    } else if (soundsType == SoundsType.file) {
      source = DeviceFileSource(path);
    } else {
      source = AssetSource(path);
    }

    player.play(source, volume: volume);
    // El 'player' se debe liberar cuando termine la reproducción.
    // Esto se puede hacer escuchando el estado 'completed'.
  }

  ///
  /// audioplayers no tiene un concepto de 'Playlist' tan directo como
  /// assets_audio_player. Para reproducir una lista, necesitas manejar
  /// la lógica de forma manual o usar la librería just_audio que está
  /// más enfocada en playlists. Aquí se muestra una forma básica.
  Future<void> openPlaylist(List<String> paths) async {
    // Tendrías que iterar sobre los paths y reproducirlos secuencialmente.
    // Aquí solo se reproduce el primer audio de la lista como ejemplo.
    if (paths.isNotEmpty) {
      path = paths.first;
      soundsType = SoundsType.assets; // O el tipo que corresponda
      await openSound();
    }
  }
} // ----

// La clase AudioListOption de la librería original no tiene un
// equivalente directo en audioplayers. Las funciones de siguiente,
// anterior, etc., se deben manejar con la lógica de tu propia clase
// UtilsSounds y la lista de reproducción.

// Por ejemplo, para reproducir el siguiente audio de una lista:
//
// int _currentPlaylistIndex = 0;
//
// Future<void> playNextInPlaylist(List<String> paths) async {
//   if (_currentPlaylistIndex < paths.length - 1) {
//     _currentPlaylistIndex++;
//     await _audioPlayer.setSource(AssetSource(paths[_currentPlaylistIndex]));
//     await _audioPlayer.resume();
//   }
// }
//
 */
