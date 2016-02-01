user =
  User.create(
    name: 'Ryan Norman',
    email: 'rnorman@covermymeds.com',
    handle: 'RyanNorman'
  )

company =
  Company.create(
    name: 'CoverMyMeds',
    domain: 'covermymeds.com',
    owner: user
  )

user.update_attribute(:company, company)

repo =
  Repo.create(
    organization: 'PBM',
    description: 'PA approval and denials',
    url: 'https://git.innova-partners.com/cmm/central',
    owner: user,
    name: 'Central',
    company: company
  )

team =
  Team.create(
    name: 'Centinels',
    leader: user,
    company: company
  )

repo.teams << team
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
  TeamMembership.create(team: team, handle: handle)
end
