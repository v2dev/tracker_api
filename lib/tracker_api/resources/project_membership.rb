module TrackerApi
  module Resources
    class ProjectMembership
      include Virtus.model

      attribute :id, Integer
      attribute :person_id, Integer
      attribute :project_id, Integer
      attribute :role, String
      attribute :project_color, String
      attribute :wants_comment_notification_emails, Boolean
      attribute :kind, String
      attribute :person, TrackerApi::Resources::Person

      def required_attributes_hash
        {role: 'member'}.merge(self.person.required_attributes_hash)
      end
    end
  end
end
