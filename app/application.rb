require 'pry'
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match (/items/)
      item = req.path.split("/items/").last
      @@items.find do |i|
        if i.name == item
          resp.write i.price
        else
          resp.write "Item not found"
          resp.status = 400
        end
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
