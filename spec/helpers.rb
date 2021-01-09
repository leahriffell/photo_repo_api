module Helpers
  # ----- API consumption helper methods -----
  def photo_search_response_structure(response)
    expect(response[:results]).to be_an(Array)
    expect(response[:results].count).to eq(10)

    first_result = response[:results][0]
    expect(first_result).to be_a(Hash)

    expect(first_result).to have_key(:description)
    expect(first_result[:description]).to be_a(String).or eq(nil)

    expect(first_result).to have_key(:urls)
    expect(first_result[:urls]).to be_a(Hash)

    expect(first_result[:urls]).to have_key(:regular)
    expect(first_result[:urls][:regular]).to be_a(String)

    expect(first_result).to have_key(:user)
    expect(first_result[:user]).to be_a(Hash)

    expect(first_result[:user]).to have_key(:username)
    expect(first_result[:user][:username]).to be_a(String)

    expect(first_result[:user]).to have_key(:name)
    expect(first_result[:user][:name]).to be_a(String)

    expect(first_result[:user]).to have_key(:links)
    expect(first_result[:user][:links]).to be_a(Hash)

    expect(first_result[:user][:links]).to have_key(:html)
    expect(first_result[:user][:links][:html]).to be_a(String)
  end
end
