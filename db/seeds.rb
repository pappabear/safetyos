
20.times do
    puts ' '
end
  
puts '================================================'
puts '== Loading seed data ==========================='.bold.yellow
puts '================================================'
puts ' '

puts '-- Truncating old data -------------------------'.green
  # --- not needed right now since we are rebuilding the db each time
  # User.destroy_all
  # Gender.destroy_all
  # ...
puts ' '
  
puts '-- Creating admin users ------------------------------'.green
puts ' '
    spadmin = User.create(
                        name: "SPAdmin",
                        email: "spadmin@spw.com",
                        password: "lollip0p",
                        password_confirmation: "lollip0p",
                        terms_of_service: true
                    )
  Jumpstart.grant_system_admin!(spadmin)
  puts ' '
  
  puts '-- Adding global data -------------------------'.green
  puts ' '
  
  #puts '         ... Adding `genders`'
  #Gender.create!(name: 'Male', code: 'M')
  #Gender.create!(name: 'Female', code: 'F')
  #Gender.create!(name: 'Other', code: 'O')
  
  
puts '-- Adding customers as built-in Accounts -------------------------'.green
puts ' '
  
15.times do |i|
    company_name = Faker::Company.name
    puts ' '
    puts '      -- Adding account ' + company_name.cyan
    # create an account associated with this company
    acct = Account.create name: company_name, owner_id: spadmin.id
    
    # attach a random logo
    url = URI.parse(Faker::Company.logo)
    filename = File.basename(url.path)
    file = URI.open(url)
    acct.avatar.attach(
        io: file,
        filename: 'acct-' + acct.id.to_s + '-logo'
    )

    # always add SPAdmin to each company
    AccountUser.create! account_id: acct.id, user_id: spadmin.id, roles: '{"admin": true}'
end



