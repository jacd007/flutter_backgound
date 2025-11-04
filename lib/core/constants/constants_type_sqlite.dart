/// Class that defines constants for SQLite data types.
///
/// This class provides a set of static constants that represent the data
/// types supported by SQLite. Using these constants can improve the
/// readability and maintainability of your code when defining the database
/// schema.
///
/// For example, when creating tables or defining the schema for data migration.
///
/// ```
/// void main() {
/// //Print the constant for the INTEGER data type
///   print('INTEGER data type: ${SQLiteDataTypes.integer}');
/// //Print the constant for the TEXT data type
///   print('TEXT data type: ${SQLiteDataTypes.text}');
///
/// //Example usage for creating a table schema
///   final Map<String, String> tablaSchema = {
///     'id': SQLiteDataTypes.integer,
///     'name': SQLiteDataTypes.text,
///     'age': SQLiteDataTypes.integer,
///     'price': SQLiteDataTypes.real,
///     'creation_date': SQLiteDataTypes.date,
///     'creation_time': SQLiteDataTypes.dateTime,
///     'active': SQLiteDataTypes.boolean, //Use INTEGER for Booleans
///     'binary_data': SQLiteDataTypes.blob,
///   };
///
/// //Print the table schema
///   print('Table schema: $tablaSchema');
///
/// //Example usage of the data type map
///   print('Available data types: ${SQLiteDataTypes.dataTypes}');
///   print('Data type for VARCHAR: ${SQLiteDataTypes.dataTypes['VARCHAR']}');
/// }
/// ```
///
class SQLiteDataTypes {
  SQLiteDataTypes._();

  /// Data type for integer values.
  static const String integer = 'INTEGER';

  /// Data type for floating-point values.
  static const String real = 'REAL';

  /// Data type for text strings.
  static const String text = 'TEXT';

  /// Data type for blobs (binary data).
  static const String blob = 'BLOB';

  /// Data type for numeric values ​​(integer or real).
  static const String numeric = 'NUMERIC';

// Additional data types that are synonymous with the main types for better
// readability.
  static const String int = 'INTEGER';
  static const String unsignedBigInt = 'INTEGER';
  static const String tinyInt = 'INTEGER';
  static const String smallInt = 'INTEGER';
  static const String mediumInt = 'INTEGER';
  static const String bigInt = 'INTEGER';
  static const String int2 = 'INTEGER';
  static const String int8 = 'INTEGER';
  static const String character = 'TEXT';
  static const String varchar = 'TEXT';
  static const String varyingCharacter = 'TEXT';
  static const String nchar = 'TEXT';
  static const String nativeCharacter = 'TEXT';
  static const String nvarchar = 'TEXT';
  static const String clob = 'TEXT';
  static const String realDouble = 'REAL';
  static const String doublePrecision = 'REAL';
  static const String float = 'REAL';

  /// SQLite does not have a Boolean data type; INTEGER is used instead
  static const String boolean = 'INTEGER';

  /// Store dates as text in ISO8601 format
  static const String date = 'TEXT';

  /// Store dates and times as text in ISO8601 format
  static const String dateTime = 'TEXT';

  /// Map containing all data types as keys and their values ​​as values.
  /// This can be useful for introspection or dynamic schema generation.
  static const Map<String, String> dataTypes = {
    'INTEGER': integer,
    'REAL': real,
    'TEXT': text,
    'BLOB': blob,
    'NUMERIC': numeric,
    'INT': int,
    'UNSIGNED BIG INT': unsignedBigInt,
    'TINYINT': tinyInt,
    'SMALLINT': smallInt,
    'MEDIUMINT': mediumInt,
    'BIGINT': bigInt,
    'INT2': int2,
    'INT8': int8,
    'CHARACTER': character,
    'VARCHAR': varchar,
    'VARYING CHARACTER': varyingCharacter,
    'NCHAR': nchar,
    'NATIVE CHARACTER': nativeCharacter,
    'NVARCHAR': nvarchar,
    'CLOB': clob,
    'DOUBLE': realDouble,
    'DOUBLE PRECISION': doublePrecision,
    'FLOAT': float,
    'BOOLEAN': boolean,
    'DATE': date,
    'DATETIME': dateTime
  };
}
