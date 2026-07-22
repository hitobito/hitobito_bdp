# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp
  class MembershipRegistrationResource < ::ApplicationResource
    self.model = ::Person
    self.type = "membership_registrations"

    primary_endpoint "membership_registrations", [:create]

    self.description = <<~DESC
      Registers a person with a membership role in an active Group::Mitglieder group.

      Required token permission:
      - a write permission for the target group's layer (e.g. layer_and_below_full)

      Required service token scopes:
      - register_people
      - create_membership_roles
    DESC

    ALLOWED_ROLE_TYPES = [
      "Group::Mitglieder::OrdentlicheMitgliedschaft",
      "Group::Mitglieder::Foerdermitgliedschaft"
    ].freeze

    with_options filterable: false, sortable: false do
      attribute :first_name, :string
      attribute :last_name, :string
      attribute :company_name, :string if FeatureGate.enabled? :self_registration_company
      attribute :company, :boolean if FeatureGate.enabled? :self_registration_company
      attribute :email, :string
      attribute :group_id, :integer, writable: true, readable: false
      attribute :role_type, :string, writable: true, readable: false
    end

    before_attributes :extract_membership_attributes
    before_save :build_role
    after_save :enqueue_duplicate_locator_job
    after_save :send_password_reset_email

    # Required to build new records even though we don't have readable_class defined
    def base_scope
      Person.none
    end

    private

    def extract_membership_attributes(attributes)
      @role_type = attributes.delete(:role_type)
      @group_id = attributes.delete(:group_id)
    end

    def authorize_create(_model)
      validate_role_type
      validate_group_id
      current_ability.authorize!(:register_people, group)
      current_ability.authorize!(:create_membership_roles, group)
    end

    def validate_role_type
      invalid_request!(:role_type, :blank) if @role_type.blank?
      invalid_request!(:role_type, :invalid) unless ALLOWED_ROLE_TYPES.include?(@role_type)
    end

    def validate_group_id
      invalid_request!(:group_id, :blank) if @group_id.blank?
      invalid_request!(:group_id, :invalid) if group.nil?
    end

    def build_role(model)
      model.roles.build(group_id: group.id, type: role_type)
    end

    attr_reader :role_type

    def group
      @group ||= ::Group.find_by(id: @group_id)
    end

    def enqueue_duplicate_locator_job(model)
      Person::DuplicateLocatorJob.new(model.id).enqueue!
    end

    def send_password_reset_email(model)
      return if model.email.blank?

      Person.send_reset_password_instructions(email: model.email)
    end
  end
end
