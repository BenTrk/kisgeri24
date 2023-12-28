abstract class CrudRepository<T> {
  Future<List<T>> fetchAll();

  Future<List<T>> fetchAllByYear(String year);

  Future<T?> getById(String id);

  Future<void> save(T entity);

  Future<void> delete(String id);

  Future<void> update(T event);
}
