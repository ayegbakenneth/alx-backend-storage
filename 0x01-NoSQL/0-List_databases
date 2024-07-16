// Get the list of databases
var databases = db.adminCommand({ listDatabases: 1 }).databases;

// Print the database names
print('List of databases:');
databases.forEach(function(database) {
  print(database.name);
});
