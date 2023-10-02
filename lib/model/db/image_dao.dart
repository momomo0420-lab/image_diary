import 'dart:io';

abstract class ImageDao {
  Future<String> save(File file);
  Future<String> update(String url);
  Future<String> deleteBy(int id);
  Future<String> loadFrom(String url);
}