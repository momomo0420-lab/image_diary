abstract class PageDao {
  Future<void> insert(Map<String, dynamic> page);
  Future<void> update(int id, Map<String, dynamic> page);
  Future<void> deleteBy(int id);
  Future<List<Map<String, dynamic>>> findAll();
}