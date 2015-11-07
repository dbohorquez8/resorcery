# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.any?
  user = User.create(email: "user@example.com", password: "password")
  p user.email
  p "password"

  p ""
  p ""
  p ""
  workspace = user.workspaces.create

  5.times do |n|
    workspace.resources.build(name: Bazaar.super_object).save
    workspace.resources.build(name: Bazaar.super_object).save
    workspace.resources.build(name: Bazaar.super_object).save
    workspace.resources.build(name: Bazaar.super_object).save
    workspace.resource_groups.build(name: Bazaar.super_object).save
    workspace.resource_groups.build(name: Bazaar.super_object).save
    workspace.resource_groups.build(name: Bazaar.super_object).save
    workspace.resource_groups.build(name: Bazaar.super_object).save
    workspace.resource_groups.build(name: Bazaar.super_object).save

    workspace = user.workspaces.create
  end

  p "created resources and groups"

  workspace.resources.each do |resource|
    workspace.resource_groups.each do |group|

      number_of_weeks = rand(1..10)
      start_date = Date.current - number_of_weeks.weeks
      date = start_date

      10.times do |n|
        # create the allocations
        allocation_params = {
          start_date: date,
          end_date: date + rand(3..7).days,
          resource_id: resource.id,
          resource_group_id: group.id,
          workspace_id: workspace.id
        }
        allocation = workspace.allocations.build(allocation_params)
        allocation.save
        date = date + 7.days
      end

    end
  end

end
