module TrackerApi
  module Resources
    class Person
      include Virtus.model

      attribute :kind, String
      attribute :id, Integer
      attribute :name, String
      attribute :email, String
      attribute :initials, String
      attribute :username, String

      def required_attributes_hash
        {name: 'V2 Employee', initials: 'V2'}
      end
    end
  end
end
