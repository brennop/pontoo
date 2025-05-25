local client = {}
local http = require "socket.http"

function client:load()
  --self.handle = io.popen("s3270 127.0.0.1:3270 -httpd :8080")
end

function client:exec(command)
  local response, code = http.request("http://localhost:8080/3270/rest/text/" .. command)

  -- if response == nil then error(code) end

  print(response, code)

  return response
end

function client:close()
  self.handle:close()
end

return client
