

box.cfg{
  listen      = 3303,
  replication = {'replicator:password@127.0.0.1:3301',  -- master1 URI
                 'replicator:password@127.0.0.1:3302', -- master2 URI
                 'replicator:password@127.0.0.1:3303'}, -- slave URI,
  read_only   = true,
  hot_standby = true
}

