adminUser = User.new(
    user_type: 1, 
    name: "Julio",
    last_name: "Narvaez Pardabe",
    document: 20136424867,
    password: "123456",
    document_type: 1
  );

if adminUser.save
  puts "El usuario administrador fue creado"
else
  puts adminUser.errors.full_messages
end
