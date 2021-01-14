require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'display users' do
    it 'can query all users' do
      create_list(:user, 2)

      post graphql_path, params: { query: query }
      result = JSON.parse(response.body)

      expect(result['data']['getUsers'].count).to eq(2)

      users = User.all

      expect(result.dig('data', 'getUsers')).to match_array(
        users.map do |user|
          { 'id' => user.id.to_s, 'email' => user.email }
        end
      )
    end
  end

  def query
    <<~GQL
      {
        getUsers {
          id
          email
        }
      }
    GQL
  end
end
