puts 'Create Admin'
admin =
  User.create(
    name: 'Admin',
    email: 'admin@agileshuffle.com',
    handle: 'admin',
    role: 'Admin',
    password: 'changeme'
  )

puts 'Create Company'
company =
  Company.create(
    name: 'CoverMyMeds',
    domain: 'covermymeds.com',
    owner: admin
  )

puts 'Create User'
user =
  User.create(
    name: 'Ryan Norman',
    email: 'rnorman@covermymeds.com',
    handle: 'RyanNorman',
    company: company,
    password: 'changeme'
  )

puts 'Assign user as owner of company'
company.update_attribute(:owner, user)

puts 'Create Repo'
repo =
  Repo.create(
    organization: 'PBM',
    description: 'PA approval and denials',
    url: 'https://git.innova-partners.com/cmm/central',
    owner: user,
    name: 'Central',
    company: company
  )

puts 'Create Team'
team =
  Team.create(
    name: 'Centinels',
    leader: user,
    company: company
  )

puts 'Add team to repo'
repo.teams << team

puts 'Add user to team members'
team.users << user

%w(
  lscott3
  SarahReid
  JoelByler
  ScottMascio
  ShaunHardin
  JoelHelbling
  AmberConville
  SteveKirby
  JeffVanGrimbergen
  GabrielEscamilla
  AustenMadden
  DanThompson
  AlexBurkhart
  BenBeckwith
).each do |handle|
  puts "Create team membership for #{handle}"
  TeamMembership.create(team: team, handle: handle)
end
