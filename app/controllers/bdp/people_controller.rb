# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

# Some group types have a BdP-specific default filter (see Bdp::FilterNavigation::People) that
# should already be applied when the people list is opened without an explicit filter choice,
# instead of showing plain members. Mirrors how core redirects to an adjusted default filter for
# archived groups (see PeopleController#index_archived).
module Bdp::PeopleController
  extend ActiveSupport::Concern

  included do
    before_action :redirect_to_bdp_default_filter,
      only: :index, if: :bdp_default_filter_redirect_needed?
  end

  private

  def redirect_to_bdp_default_filter
    key, role_types, range = Bdp::FilterNavigation::People.default_filter(group.class)
    type_ids = role_types.collect(&:type_id).join(Person::Filter::Base::ID_URL_SEPARATOR)
    redirect_to(
      name: I18n.t("filter_navigation/people.#{key}"),
      range: range,
      filters: {role: {role_type_ids: type_ids}}
    )
  end

  def bdp_default_filter_redirect_needed?
    html_request? &&
      !group.archived? &&
      params[:name].blank? && params[:filters].blank? && params[:filter_id].blank? &&
      Bdp::FilterNavigation::People.default_filter(group.class).present?
  end
end
