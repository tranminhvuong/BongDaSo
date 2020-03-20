Role.create(name: 'admin')
Role.create(name: 'ctv')
User.create(name: 'Ho Sy Ty', email: 'admin01@gmail.com', password: '12345678', password_confirmation: '12345678', role_id: Role.first.id)
