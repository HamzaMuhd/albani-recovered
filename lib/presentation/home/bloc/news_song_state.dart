abstract class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewSongsLoaded extends NewsSongsState {
  // final List<SongEntity> songs;
  // NewSongsLoaded({required this.songs})
}

class NewSongsLoadFailure extends NewsSongsState {}
