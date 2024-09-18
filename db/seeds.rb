
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
  
  puts '         ... Adding `frequencies`'
  Frequency.create!(name: 'Daily', code: 'D')
  Frequency.create!(name: 'Weekly', code: 'W')  
  Frequency.create!(name: 'Quarterly', code: 'Q')
  Frequency.create!(name: 'Annually', code: 'Y')

  TodoStatus.create!(name: 'New')
  TodoStatus.create!(name: 'In Progress')
  TodoStatus.create!(name: 'Done')


puts ' '
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

puts ' '
puts '-- Adding template data -------------------------'.green
puts ' '

puts '      -- Adding `jobs`'

Job.create! name:'Set EHS Goals', account_id:1, notes:'Add notes here', sequence:1, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Determine Hazards', account_id:1, notes:'Add notes here', sequence:2, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Mitigate Hazards', account_id:1, notes:'Add notes here', sequence:3, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Develop Policies', account_id:1, notes:'Add notes here', sequence:4, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Select Needed Tools', account_id:1, notes:'Add notes here', sequence:5, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Implement Tools', account_id:1, notes:'Add notes here', sequence:6, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Develop Rollout Process', account_id:1, notes:'Add notes here', sequence:7, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Train Employees on Process and Tools', account_id:1, notes:'Add notes here', sequence:8, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Rollout Processes and Tools', account_id:1, notes:'Add notes here', sequence:9, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Monitor Results', account_id:1, notes:'Add notes here', sequence:10, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'
Job.create! name:'Manage EHS Progress', account_id:1, notes:'Add notes here', sequence:11, description:'Loren ipsun dolor sit anet, consectetur adipisci elit, sed eiusnod tenpor incidunt ut labore et dolore nagna aliqua.'


