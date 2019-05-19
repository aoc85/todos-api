module RequestSpecHelper
  #Parse JSON to Ruby Hash
  def json
    JSON.parse(response.body)
  end
end
