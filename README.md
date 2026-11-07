# Hitobito BdP

This hitobito wagon defines the organization hierarchy with groups and roles
of BdP.


## BdP Organization Hierarchy

<!-- roles:start -->
    * Bundesebene
      * Bundesebene
        * MV-Administrator*in: 2FA [:layer_and_below_full, :admin, :layer_and_below_finance, :impersonation, :assign_restricted_fee_kinds, :delete_efz, :create_membership_roles]
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_read_details, :layer_and_below_efz]
        * Kassenprüfer*in: []
        * Datenschutzbeauftragte*r: []
        * Bundesmitarbeiter*in: []
      * Kursteams
      * Gilwellkurs
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * IB-Seminar
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Bundesvorstand
        * Bundesvorsitzende*r: 2FA [:layer_and_below_full, :contact_data, :assign_restricted_fee_kinds]
        * Stv. Bundesvorsitzende*r: 2FA [:layer_and_below_full, :contact_data, :assign_restricted_fee_kinds]
        * Bundesschatzmeister*in: 2FA [:layer_and_below_full, :contact_data, :layer_and_below_finance, :assign_restricted_fee_kinds]
        * Stv. Bundesschatzmeister*in: 2FA [:layer_and_below_full, :contact_data, :layer_and_below_finance, :assign_restricted_fee_kinds]
        * Empfänger*in Aufnahmeantrag Über18: []
      * Bundesgeschäftsstelle
        * Bundesgeschäftsführer*in: 2FA [:layer_and_below_full, :admin, :contact_data, :layer_and_below_finance, :assign_restricted_fee_kinds, :create_membership_roles]
        * Mitgliederverwalter*in Bund: 2FA [:layer_and_below_full, :admin, :contact_data, :layer_and_below_finance, :assign_restricted_fee_kinds, :create_membership_roles]
        * Hauptamtliche Sachbearbeiter*in: 2FA [:layer_and_below_full, :contact_data, :assign_restricted_fee_kinds]
        * Hauptamtliche Referent*in: 2FA [:layer_and_below_read_details, :contact_data, :assign_restricted_fee_kinds]
        * Hauptamtliche*r: 2FA [:contact_data, :assign_restricted_fee_kinds]
      * Ombudsrat
        * Mitglied: []
      * Betrieb
        * Geschäftsführer*in: []
      * Versammlung
        * Versammlungsleitung: []
        * Protokollführung: []
        * Technik: []
      * Arbeitsbereiche
      * Stufen
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wölflingsstufe
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Pfadfinder*innenstufe
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ranger/Rover-Stufe
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Erwachsenenarbeit
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ausbildung
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Internationales
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Prävention und Intervention
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - psychische Gesundheit
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Macht und Miteinander
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Öffentlichkeitsarbeit/Medien
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Politische Bildung/Politik und Gesellschaft
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * IT
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Findungskommission
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Rainbow
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Inklusion
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wachstum und Stämme
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Sonstiger Arbeitsbereich
        * Bundesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
    * Landesverband < Bundesebene
      * Landesverband
        * Landesmitgliederverwalter*in: 2FA [:layer_and_below_full, :layer_and_below_finance, :contact_data, :assign_restricted_fee_kinds]
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_read_details, :layer_and_below_efz]
        * Kassenprüfer*in: []
        * Datenschutzbeauftragte*r: []
        * Stammeskompass-Moderator*in: []
        * Landesmitarbeiter*in: []
        * Materialwart*in: []
        * Bundesdelegierte*r: []
        * Ersatz-Bundesdelegierte*r: []
        * Bundeslager Unterlagerleiter*in: []
        * Bundeslager Unterlagerbereichsleiter*in: []
        * Bundeslager Mitarbeiter*in Unterlager: []
        * Landeswahlobmensch: []
        * Zuschussbeauftragte*r: []
      * Kursteams
      * Landesvorstand
        * Landesvorsitzende*r: 2FA [:layer_and_below_read, :contact_data]
        * Stv. Landesvorsitzende*r: 2FA [:layer_and_below_read, :contact_data]
        * Landesschatzmeister*in: 2FA [:layer_and_below_read, :contact_data, :layer_and_below_finance, :assign_restricted_fee_kinds]
        * Stv. Landesschatzmeister*in: 2FA [:layer_and_below_read, :contact_data, :layer_and_below_finance, :assign_restricted_fee_kinds]
        * Empfänger*in Aufnahmeantrag LV Unter18: []
        * Empfänger*in Aufnahmeantrag LV Über18: []
      * Landesgeschäftsstelle
        * Landesgeschäftsführer*in: 2FA [:layer_and_below_full, :contact_data, :layer_and_below_finance]
        * Hauptamtliche Sachbearbeiter*in: 2FA [:layer_and_below_read, :contact_data]
        * Hauptamtliche Referent*in: 2FA [:layer_and_below_read, :contact_data]
        * Hauptamtliche*r: 2FA [:contact_data]
      * Landesversammlung
        * Versammlungsleiter*in: []
        * Protokollführer*in: []
        * Techniker*in: []
      * Arbeitsbereiche
      * Stufen
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wölflingsstufe
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Pfadfinder*innenstufe
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ranger/Rover-Stufe
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Erwachsenenarbeit
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ausbildung
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Internationales
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Prävention und Intervention
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - psychische Gesundheit
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Macht und Miteinander
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Öffentlichkeitsarbeit/Medien
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Politische Bildung/Politik und Gesellschaft
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * IT
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Findungskommission
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Rainbow
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Inklusion
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wachstum und Stämme
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Sonstiger Arbeitsbereich
        * Landesbeauftragte*r: [:layer_and_below_read_details, :contact_data]
        * AK Leiter*in: [:group_and_below_read, :contact_data]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
    * Bezirk < Landesverband
      * Bezirk
        * Bezirkssprecher*in: 2FA [:layer_and_below_read_details, :contact_data]
        * Stv. Bezirkssprecher*in: 2FA [:layer_and_below_read_details, :contact_data]
        * Bezirksschatzmeister*in: 2FA [:layer_and_below_read_details, :contact_data]
        * Stv. Bezirksschatzmeister*in: 2FA [:layer_and_below_read_details, :contact_data]
        * Bezirksbeauftragte*r: []
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_efz]
        * Kassenprüfer*in: []
      * Kursteams
      * Bezirksgeschäftsstelle
        * Hauptamtliche*r: 2FA [:group_read]
      * Bezirksversammlung
        * Versammlungsleiter*in: []
        * Protokollführer*in: []
        * Techniker*in: []
      * Arbeitsbereiche
      * Stufen
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wölflingsstufe
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Pfadfinder*innenstufe
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ranger/Rover-Stufe
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Erwachsenenarbeit
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ausbildung
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Internationales
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Prävention und Intervention
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - psychische Gesundheit
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Macht und Miteinander
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Öffentlichkeitsarbeit/Medien
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Politische Bildung/Politik und Gesellschaft
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * IT
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Findungskommission
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Rainbow
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Inklusion
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wachstum und Stämme
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Sonstiger Arbeitsbereich
        * Bezirksbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
    * Stamm < Bezirk, Landesverband
      * Stamm
        * Stammesführer*in: [:layer_and_below_read]
        * Stv. Stammesführer*in: [:layer_and_below_read]
        * Stammesschatzmeister*in: [:layer_and_below_read, :finance]
        * Stv. Stammesschatzmeister*in: [:layer_and_below_read, :finance]
        * Empfänger*in Aufnahmeantrag in Stammesführung: []
        * Stammesmitgliederverwalter*in: 2FA [:layer_and_below_full, :finance]
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_read_details, :layer_and_below_efz]
        * Kassenprüfer*in: []
        * Zuschussbeauftragte*r: []
        * Ansprechperson Bundeslager: []
        * Stammeskämmerer*in: []
        * Materialwart*in: []
        * Ansprechperson Heimvermietung: []
        * Heimwart*in: []
        * Stammesbeauftragte*r: []
        * Landesdelegierte*r: []
        * Ersatz-Landesdelegierte*r: []
        * Bezirksdelegierte*r: []
        * Stammesgeschäftsstelle: []
      * Arbeitsbereiche
      * Stufen
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wölflingsstufe
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Pfadfinder*innenstufe
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ranger/Rover-Stufe
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Erwachsenenarbeit
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Ausbildung
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Internationales
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Prävention und Intervention
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - psychische Gesundheit
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * intakt - Macht und Miteinander
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Öffentlichkeitsarbeit/Medien
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Politische Bildung/Politik und Gesellschaft
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * IT
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Findungskommission
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Rainbow
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Inklusion
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Wachstum und Stämme
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Sonstiger Arbeitsbereich
        * Stammesbeauftragte*r: [:layer_and_below_read_details]
        * AK Leiter*in: [:group_and_below_read]
        * AK Mitarbeiter*in: [:group_and_below_read]
        * AK Freie*r Mitarbeiter*in: []
      * Eltern
        * Adressverwaltung: [:group_and_below_full]
        * Elternteil: []
      * Gruppen
      * Gilde
        * Gildenführer*in: [:group_and_below_read]
        * Stv. Gildenführer*in: [:group_and_below_read]
      * Meute
        * Meutenführer*in: [:group_read]
        * Stv. Meutenführer*in: [:group_read]
        * Wölfling: []
      * Sippe
        * Sippenführer*in: [:group_read]
        * Stv. Sippenführer*in: [:group_read]
        * Pfadfinder*in: []
      * Runde
        * Rundensprecher*in: [:group_read]
        * Stv. Rundensprecher*in: [:group_read]
        * Ranger/Rover: []
    * Global
      * Basiskurs
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Kurs für Meutenführungen
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Kurs für Sippenführungen
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Kurs für Gildenführungen
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Kurs für Ranger/Rover
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Grundkurs
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Querkurs
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Sonstiger Kurs
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * LV-spezifische Ausbildung
        * Kursleiter*in: [:group_read, :contact_data]
        * Kursteamer*in: [:group_read]
        * Referent*in: []
        * Mitarbeiter*in: []
        * Kurs-Küchenteamer*in: []
      * Mitglieder
        * Ordentliche Mitgliedschaft: []
        * Fördermitgliedschaft: []
        * Zweitmitgliedschaft: []
      * Heim/Zeltplatz/Liegenschaft
        * Ansprechperson Vermietung: []
        * Heim-/Hauswart*in: []
        * Vorstandsmitglied Hausverein: []
      * Gruppierungsspezifisches Gremium
        * Leiter*in: [:group_and_below_full]
        * Mitglied: [:group_read]
      * Förderverein
        * Vorsitzende*r: []
        * Stv. Vorsitzende*r: []
        * Schatzmeister*in: []
        * Geschäftsstelle: []
      * Kontakte
        * Adressverwaltung: [:group_and_below_full]
        * Kontakt: []
      * Projekt
        * Lagerleiter*in: [:group_read, :contact_data]
        * Stv. Lagerleiter*in: [:group_read, :contact_data]
        * Mitarbeiter*in: []
        * Beauftragte*r: []
        * Mitgliederverwalter*in Großprojekt: 2FA [:group_full]
        * Zugriffsberechtigte*r Mitgliederverwaltung Großprojekt: 2FA [:layer_and_below_read_details]
      * Bereich
        * Bereichsleitung: [:group_read, :contact_data]
        * Mitarbeiter*in: []

(Output of rake app:hitobito:roles)
<!-- roles:end -->
