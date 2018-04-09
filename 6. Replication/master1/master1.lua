-- instance file for any of the two masters
replica = 1
box.cfg{
  listen      = 3301,
  replication = {'replicator:password@127.0.0.1:3301',  -- master1 URI
                 'replicator:password@127.0.0.1:3302'}, -- master2 URI

  read_only   = false
}
box.once("schema", function()
   box.schema.user.create('replicator', {password = 'password'})
   box.schema.user.grant('replicator', 'replication') -- grant replication role
   box.schema.space.create("test")
   box.schema.sequence.create('S')
   box.space.test:create_index("primary", {sequence='S', parts = {1,'unsigned', 2, 'unsigned'}})
   print('box.once executed on master #1')
end)
local console = require('console')
console.start()