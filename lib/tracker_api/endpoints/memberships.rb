module TrackerApi
  module Endpoints
    class Memberships
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(project_id, params={})
        data = client.paginate("/projects/#{project_id}/memberships", params: params)
        raise TrackerApi::Errors::UnexpectedData, 'Array of memberships expected' unless data.is_a? Array

        data.map do |membership|
          Resources::ProjectMembership.new({ project_id: project_id }.merge(membership))
        end
      end

      def add_member(project_id, params={})
        project_member = Resources::ProjectMembership.new(person: Resources::Person.new)
        required_attributes_hash = project_member.required_attributes_hash
        data = client.post("/projects/#{project_id}/memberships", params: params.merge(required_attributes_hash)).body

        { client: client, project_id: project_id }.merge(data)
      end

      def get_member(project_id, person_id)
        data = client.get("/projects/#{project_id}/memberships/#{person_id}").body

        Resources::ProjectMembership.new({ client: client, project_id: project_id, person_id: person_id }.merge(data))
      end

      def delete_member(project_id, person_id)
        client.delete("/projects/#{project_id}/memberships/#{person_id}").body
      end

    end
  end
end
