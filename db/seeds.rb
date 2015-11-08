puts "Creating guest user"
@guest = User.find_or_create_by!(email: "guest@resorcery.co")
puts "Creating workspace..."
@guest.workspaces.first.update_attribute "name", "RailsRumble!"

# Sample Resources
resource_names = [
  "Jose",
  "Miguel",
  "Lacide",
  "David",
  "Icas",
  "Juandres",
  "Zorro",
  "Charly",
  "Bbto",
  "Edgar",
  "Diego",
  "Monseñor",
  "Mayo",
  "Richard",
  "Moises",
  "Lumir",
  "Carlos",
  "Juan",
]

resource_groups_names = [
  "RailsRumble",
  "StartIt",
  "RaceRumble",
  "QADesk",
  "Trello Timeline",
  "Resorcery"
]

allocations_attributes = [
  {:resource=>"Jose", :start_date=>"Wed, 01 Apr 2015", :end_date=>"Sat, 01 Aug 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Jose", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Miguel", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Lacide", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"David", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Icas", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"StartIt"},
  {:resource=>"Juandres", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Zorro", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Charly", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"StartIt"},
  {:resource=>"Juandres", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"StartIt"},
  {:resource=>"Zorro", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"StartIt"},
  {:resource=>"Charly", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Bbto", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RaceRumble"},
  {:resource=>"Edgar", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RaceRumble"},
  {:resource=>"Diego", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RaceRumble"},
  {:resource=>"Monseñor", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RaceRumble"},
  {:resource=>"Bbto", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Edgar", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Diego", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Monseñor", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Icas", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Mayo", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"QADesk"},
  {:resource=>"Richard", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Moises", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Lumir", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Richard", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"QADesk"},
  {:resource=>"Moises", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"QADesk"},
  {:resource=>"Lumir", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"QADesk"},
  {:resource=>"Carlos", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"Trello Timeline"},
  {:resource=>"Juan", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"Trello Timeline"},
  {:resource=>"Carlos", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Juan", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"RailsRumble"},
  {:resource=>"Jose", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"Resorcery"},
  {:resource=>"Miguel", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"Resorcery"},
  {:resource=>"Lacide", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"Resorcery"},
  {:resource=>"David", :start_date=>"Fri, 06 Nov 2015", :end_date=>"Sun, 08 Nov 2015", :resource_group=>"Resorcery"}
]

ActiveRecord::Base.transaction do
  @workspace = @guest.workspaces.find_by_name("RailsRumble!")

  puts "Allocating!"
  allocations_attributes.each do |allocation|
    resource_group = @workspace.resource_groups.find_or_create_by(name: allocation[:resource_group])
    resource = @workspace.resources.find_or_create_by(name: allocation[:resource])

    @workspace.allocations.create(resource: resource,
                      resource_group: resource_group,
                      start_date: allocation[:start_date],
                      end_date: allocation[:end_date])
  end
  puts "Done. Use demo via Landing page link or resorcery.co/demo"
end
