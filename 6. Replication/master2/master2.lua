box.cfg{
  listen      = 3302,
  replication = {'replicator:password@127.0.0.1:3301',  -- master1 URI
                 'replicator:password@127.0.0.1:3302'}, -- master2 URI

  read_only   = false,
  hot_standby = true
}

box.once("schema", function()
   box.schema.user.create('replicator', {password = 'password'})
   box.schema.user.grant('guest', 'read,write,execute', 'universe')
   box.schema.user.grant('replicator', 'replication') -- grant replication role
   box.schema.space.create("test")
   box.space.test:create_index("primary", {type = 'hash', parts = {1,'string'}})
   print('box.once executed')
end)

local uuid = require('uuid')
function insert(...)
  box.space.test:insert({uuid.str(), ...})
end

