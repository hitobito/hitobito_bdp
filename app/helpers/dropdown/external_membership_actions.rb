# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

module Dropdown
  class ExternalMembershipActions < Base
    # Ability required to perform each action; self and managed people always have it.
    FULL_ACCESS_ABILITIES = {
      mitgliedsbescheinigung: :show_full,
      austritt: :update,
      stammeswechsel: :update,
      zweitmitgliedschaft: :update,
      mitgliedsart: :update
    }.freeze

    def initialize(template, person, group = nil)
      super(template, translate(:button), "external-link-alt")
      @person = person
      @group = group

      init_items
    end

    private

    def init_items
      return unless active_membership_role?

      FULL_ACCESS_ABILITIES.each do |key, full_ability|
        next unless template.can?(full_ability, @person)

        if self_or_managed?
          add_action_item(key, Settings.external_actions.person, key.to_s)
        else
          add_action_item(key, Settings.external_actions.person_full, "#{key}_full")
        end
      end
    end

    def self_or_managed?
      @person == template.current_user || template.current_user&.manageds&.include?(@person)
    end

    def active_membership_role?
      @person.roles.any? { |role| role.class.membership_role }
    end

    def add_action_item(key, settings, translation_key)
      url = settings.public_send(:"#{key}_url")
      return if url.blank?

      add_item(translate(".#{translation_key}"),
        format(url, person_id: @person.id, group_id: @group&.id, layer_id: @group&.layer_group_id),
        target: :_blank)
    end
  end
end
