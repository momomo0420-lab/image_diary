import 'dart:io';

abstract class ImageDao {
  Future<String> save(File file);
  Future<String> update(String url);
  Future<void> delete(String fileName);
  Future<String> loadFrom(String url);
}