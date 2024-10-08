
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

Job.create! name:'Set EHS Goals', account_id:1, notes:'Add notes here', sequence:1, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Determine Hazards', account_id:1, notes:'Add notes here', sequence:2, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Mitigate Hazards', account_id:1, notes:'Add notes here', sequence:3, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Develop Policies', account_id:1, notes:'Add notes here', sequence:4, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Select Needed Tools', account_id:1, notes:'Add notes here', sequence:5, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Implement Tools', account_id:1, notes:'Add notes here', sequence:6, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Develop Rollout Process', account_id:1, notes:'Add notes here', sequence:7, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Train Employees on Process and Tools', account_id:1, notes:'Add notes here', sequence:8, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Rollout Processes and Tools', account_id:1, notes:'Add notes here', sequence:9, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Monitor Results', account_id:1, notes:'Add notes here', sequence:10, description:Faker::Lorem.sentence(word_count: rand(2..10))
Job.create! name:'Manage EHS Progress', account_id:1, notes:'Add notes here', sequence:11, description:Faker::Lorem.sentence(word_count: rand(2..10))

puts ' '
puts '      -- Adding `steps`'

jobs = Job.all
jobs.each_with_index do |j, i|
    if i == 2
        Step.create! name: 'Perform Gap Analysis', account_id:1, job_id:3, notes:'Add notes here', sequence:1, description:Faker::Lorem.sentence(word_count: rand(2..10))
        Step.create! name: 'Choose Mitigation Path', account_id:1, job_id:3, notes:'Add notes here', sequence:2, description:Faker::Lorem.sentence(word_count: rand(2..10))
        Step.create! name: 'Set Benchmarks and Measureables', account_id:3, job_id:1, notes:'Add notes here', sequence:3, description:Faker::Lorem.sentence(word_count: rand(2..10))
        Step.create! name: 'Estimate Tools and Needs', account_id:1, job_id:3, notes:'Add notes here', sequence:4, description:Faker::Lorem.sentence(word_count: rand(2..10))
        Step.create! name: 'Get Approval', account_id:1, job_id:3, notes:'Add notes here', sequence:5, description:Faker::Lorem.sentence(word_count: rand(2..10))
    else
        Step.create! name: Faker::Lorem.sentence(word_count: rand(1..3)), account_id:1, job_id: j.id, sequence:1, notes: 'Add notes here', description: Faker::Lorem.sentence(word_count: rand(2..10))
        Step.create! name: Faker::Lorem.sentence(word_count: rand(1..3)), account_id:1, job_id: j.id, sequence:2, notes: 'Add notes here', description: Faker::Lorem.sentence(word_count: rand(2..10))
        Step.create! name: Faker::Lorem.sentence(word_count: rand(1..3)), account_id:1, job_id: j.id, sequence:3, notes: 'Add notes here', description: Faker::Lorem.sentence(word_count: rand(2..10))
    end
end

puts ' '
puts '      -- Adding `guides`'

steps = Step.where(account_id: 1)
steps.each do |s|
    
    # add a Guide
    guide1 = Guide.new name: Faker::Lorem.sentence(word_count: rand(2..5)), account_id: 1, step_id: s.id, description: Faker::Lorem.sentence(word_count: rand(2..10))

    # attach a dummy doc
    guide1.doc.attach(
        io:  File.open(File.join(Rails.root,'app/assets/dummy_docs/SampleSafetyDoc.docx')),
        filename: 'guide-' + guide1.id.to_s + '.docx'
    )
    guide1.save!

    # add another Guide
    guide2 = Guide.new name: Faker::Lorem.sentence(word_count: rand(2..5)), account_id: 1, step_id: s.id, description: Faker::Lorem.sentence(word_count: rand(2..10))

    # attach a dummy doc
    guide2.doc.attach(
        io:  File.open(File.join(Rails.root,'app/assets/dummy_docs/SampleSafetyDoc.docx')),
        filename: 'guide-' + guide2.id.to_s + '.docx'
    )
    guide2.save!
end

puts ' '
puts '      -- Adding `placeholders`'

steps = Step.all
steps.each do |s|
    p = Placeholder.new
    p.account_id = s.account_id
    p.step_id = s.id
    p.name = "Coming soon"
    p.save!
end

puts ' '
puts '-- Flusing Redis cache -------------------------'.green

