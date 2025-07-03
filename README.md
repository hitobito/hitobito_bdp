# Hitobito Bdp

This hitobito wagon defines the organization hierarchy with groups and roles
of Bdp.


## Bdp Organization Hierarchy

<!-- roles:start -->
    * Bundesebene
      * Bundesebene
        * MV-Administrator*in: 2FA [:layer_and_below_full, :admin, :impersonation]
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_read, :group_and_below_efz]
        * Kassenprüfer*in: []
        * Bundesmitarbeiter*in: []
      * Bundesvorstand
        * Bundesvorsitzende*r: 2FA [:layer_and_below_full, :contact_data]
        * Stv. Bundesvorsitzende*r: 2FA [:layer_and_below_full, :contact_data]
        * Bundesschatzmeister*in: 2FA [:layer_and_below_full, :contact_data, :finance]
        * Stv. Bundesschatzmeister*in: 2FA [:layer_and_below_full, :contact_data, :finance]
        * Empfänger*in Aufnahmeantrag Über18: []
      * Bundesgeschäftsstelle
        * Bundesgeschäftsführer*in: 2FA [:layer_and_below_full, :admin, :contact_data, :finance]
        * Mitgliederverwalter*in Bund: 2FA [:layer_and_below_full, :admin, :contact_data, :finance]
        * Hauptamtliche Sachbearbeiter*in: 2FA [:layer_and_below_full, :contact_data]
        * Hauptamtliche Referent*in: 2FA [:layer_and_below_read, :contact_data]
        * Hauptamtliche*r: 2FA [:contact_data]
      * Ombudsrat
        * Mitglied: []
      * Betrieb
        * Geschäftsführer*in: []
      * Versammlung
        * Versammlungsleitung: []
        * Protokollführung: []
        * Technik: []
      * Projekt
        * Lagerleiter*in: [:group_read, :contact_data]
        * Stv. Lagerleiter*in: [:group_read, :contact_data]
        * Mitarbeiter*in: []
        * Beauftragte*r: []
        * Mitgliederverwalter*in Großprojekt: 2FA [:group_full]
        * Zugriffsberechtige*r Mitgliederverwaltung Großprojekt: 2FA [:layer_and_below_read]
      * Bereich
        * Bereichsleitung: [:group_read, :contact_data]
        * Mitarbeiter*in: []
    * Landesverband < Bundesebene
      * Landesverband
        * Landesmitgliederverwalter*in: 2FA [:layer_and_below_full, :contact_data]
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_read, :group_and_below_efz]
        * Kassenprüfer*in: []
        * Stammeskompass-Moderator*in: []
        * Landesmitarbeiter*in: []
        * Juleica-Inhaber*in: []
        * Materialwart*in: []
        * Bundesdelegierte*r: []
        * Ersatz-Bundesdelegierte*r: []
        * Bundeslager Unterlagerleiter*in: []
        * Bundeslager Unterlagerbereichsleiter*in: []
        * Bundeslager Mitarbeiter*in Unterlager: []
        * Landeswahlobmensch: []
        * Zuschussbeauftrage*r: []
      * Landesvorstand
        * Landesvorsitzende*r: 2FA [:layer_and_below_read, :contact_data]
        * Stv. Landesvorsitzende*r: 2FA [:layer_and_below_read, :contact_data]
        * Landesschatzmeister*in: 2FA [:layer_and_below_read, :contact_data, :finance]
        * Stv. Landesschatzmeister*in: 2FA [:layer_and_below_read, :contact_data, :finance]
        * Empfänger*in Aufnahmeantrag LV Unter18: []
        * Empfänger*in Aufnahmeantrag LV Über18: []
      * Landesgeschäftsstelle
        * Landesgeschäftsführer*in: 2FA [:layer_and_below_full, :contact_data, :finance]
        * Hauptamtliche Sachbearbeiter*in: 2FA [:layer_and_below_read, :contact_data]
        * Hauptamtliche Referent*in: 2FA [:layer_and_below_read, :contact_data]
        * Hauptamtliche*r: 2FA [:contact_data]
      * Landesversammlung
        * Versammlungsleiter*in: []
        * Protokollführer*in: []
        * Techniker*in: []
    * Bezirk < Landesverband
      * Bezirk
        * Bezirkssprecher*in: 2FA [:layer_and_below_read, :contact_data]
        * Stv. Bezirkssprecher*in: 2FA [:layer_and_below_read, :contact_data]
        * Bezirksschatzmeister*in: 2FA [:layer_and_below_read, :contact_data]
        * Stv. Bezirksschatzmeister*in: 2FA [:layer_and_below_read, :contact_data]
        * Bezirksbeautragte*r: []
        * Erfasser*in Führungszeugnis: 2FA [:group_and_below_efz]
        * Kassenprüfer*in: []
      * Bezirksgeschäftsstelle
        * Hauptamtliche*r: 2FA [:group_read]
    * Stamm < Bezirk, Landesverband
      * Stamm
        * Stammesführer*in: [:group_read]
        * Stv. Stammesführer*in: [:group_read]
        * Stammesschatzmeister*in: [:group_read]
        * Stv. Stammesschatzmeister*in: [:group_read]
        * Empfänger*in Aufnahmeantrag in Stammesführung: []
        * Stammesmitgliederverwalter*in: 2FA [:layer_and_below_full]
        * Erfasser*in Führungszeugnis: 2FA [:layer_and_below_read, :group_and_below_efz]
        * Kassenprüfer*in: []
        * Zuschussbeauftrage*r: []
        * Ansprechperson Bundeslager: []
        * Stammeskämmerer*in: []
        * Materialwart*in: []
        * Ansprechperson Heimvermietung: []
        * Heimwart*in: []
        * Juleica-Inhaber*in: []
        * Stammesbeauftragte*r: []
        * Landesdelegierte*r: []
        * Ersatz-Landesdelegierte*r: []
        * Bezirksdelegierte*r: []
        * Stammesgeschäftsstelle: []
      * Meute
        * Meutenführer*in: [:group_read]
        * Stv. Meutenführer*in: [:group_read]
        * Wölfling: []
      * Gilde
        * Gildenführer*in: [:group_read]
        * Stv. Gildenführer*in: [:group_read]
      * Sippe
        * Sippenführer*in: [:group_read]
        * Stv. Sippenführer*in: [:group_read]
        * Pfadfinder*in: []
      * Runde
        * Rundensprecher*in: [:group_read]
        * Stv. Rundensprecher*in: [:group_read]
        * Ranger/Rover: []
    * Global
      * Mitglieder
        * Adressverwaltung: []
        * Fördermitgliedschaft: []
        * Zweitmitgliedschaft: []
      * Heim/Zeltplatz/Liegenschaft
        * Ansprechperson Vermietung: []
        * Heim-/Hauswart: []
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
      * Global
        * Beauftragte*r: [:group_read]
        * AK Leiter*in: [:group_read]
        * AK Mitarbeiter*in: [:group_read]
        * AK Freie*r Mitarbeiter*in: []
        * Beauftragte*r: [:group_read, :contact_data]
        * AK Leiter*in: [:group_read, :contact_data]
        * AK Mitarbeiter*in: [:group_read]
        * AK Freie*r Mitarbeiter*in: []

(Output of rake app:hitobito:roles)
<!-- roles:end -->