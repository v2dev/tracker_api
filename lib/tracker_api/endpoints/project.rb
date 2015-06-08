module TrackerApi
  module Endpoints
    class Project
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      def get(id, params={})
        data = client.get("/projects/#{id}", params: params).body

        Resources::Project.new({ client: client }.merge(data))
      end

      def post(params={})
        begin
          data = client.post("/projects", params: params).body

          Resources::Project.new({ client: client }.merge(data))
        rescue TrackerApi::Error => e
          eval(e.message)[:body]["general_problem"]
        rescue Exception => e
          e.message
        end
      end
    end
  end
end
