# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

module Dropdown
  class ExternalMembershipActions < Base
    # Ability required to see the full-access variant of each action, for viewers who are
    # neither the person themselves nor a registered manager (PeopleManager) of them.
    FULL_ACCESS_ABILITIES = {
      mitgliedsbescheinigung: :show_full,
      austritt: :update,
      stammeswechsel: :update,
      zweitmitgliedschaft: :update,
      mitgliedsart: :update
    }.freeze

    def initialize(template, person)
      super(template, translate(:button), "external-link-alt")
      @person = person
      @normal_access = person == template.current_user ||
        template.current_user&.manageds&.include?(person) || false

      init_items
    end

    private

    def init_items
      return unless active_membership_role?

      FULL_ACCESS_ABILITIES.each do |key, full_ability|
        if @normal_access
          add_report_item(key, Settings.external_actions.person, key.to_s)
        elsif template.can?(full_ability, @person)
          add_report_item(key, Settings.external_actions.person_full, "#{key}_full")
        end
      end
    end

    def active_membership_role?
      membership_role_types = Role.all_types.select(&:membership_role).map(&:sti_name)
      # @person may be a PersonDecorator, whose #roles returns a plain Array rather
      # than a Relation, so filter in Ruby instead of chaining #where.
      @person.roles.any? { |role| membership_role_types.include?(role.type) }
    end

    def add_report_item(key, settings, translation_key)
      url = settings.public_send(:"#{key}_url")
      return if url.blank?

      add_item(translate(".#{translation_key}"), "#{url}?personId=#{@person.id}", target: :_blank)
    end
  end
end
