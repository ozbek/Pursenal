abstract class BaseRepository<T, C> {
  Future<int> delete(int id);
  Future<T?> getById(int id);
}
