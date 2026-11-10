# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

require "spec_helper"

describe PeopleController do
  let(:user) { people(:admin) }

  before { sign_in(user) }

  def filter_params(key, role_types, range)
    type_ids = role_types.collect(&:type_id).join(Person::Filter::Base::ID_URL_SEPARATOR)
    {name: I18n.t("filter_navigation/people.#{key}"),
     range: range, filters: {role: {role_type_ids: type_ids}}}
  end

  context "group with a BdP default filter" do
    let(:group) { groups(:oberbayern_mauersegler_gruppen) }

    it "redirects to it when no filter is chosen yet" do
      get :index, params: {group_id: group.id}

      params = filter_params(:alle_gruppenleitungen,
        Bdp::FilterNavigation::People::GRUPPENLEITUNG_ROLES, "deep")
      expect(response).to redirect_to(group_people_path(group, params))
    end

    it "does not redirect once a filter is already selected" do
      params = filter_params(:alle_gruppenleitungen,
        Bdp::FilterNavigation::People::GRUPPENLEITUNG_ROLES, "deep")
      get :index, params: {group_id: group.id}.merge(params)

      expect(response).to have_http_status(:ok)
    end

    it "does not redirect for a differently named custom filter" do
      get :index,
        params: {group_id: group.id, name: "Custom", filters: {role: {role_type_ids: "1"}}}

      expect(response).to have_http_status(:ok)
    end
  end

  context "Group::Stamm" do
    let(:group) { groups(:oberbayern_mauersegler) }

    it "redirects to Funktionsträger*innen when no filter is chosen yet" do
      get :index, params: {group_id: group.id}

      params = filter_params(:funktionstraeger,
        Bdp::FilterNavigation::People::FUNKTIONSTRAEGER_ROLES, "layer")
      expect(response).to redirect_to(group_people_path(group, params))
    end
  end

  context "group without a BdP default filter" do
    let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

    it "does not redirect" do
      get :index, params: {group_id: group.id}

      expect(response).to have_http_status(:ok)
    end
  end
end
