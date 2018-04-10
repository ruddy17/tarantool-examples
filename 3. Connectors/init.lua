-- instance file for any of the two masters
box.cfg{
  listen      = 3300
}

box.once("schema", function()
  box.schema.user.create('me', {password = 'tsss'})
  box.schema.user.grant('me', 'read,write,execute', 'universe')
  box.schema.space.create("test")
  box.schema.sequence.create('S')
  box.space.test:create_index("primary", {sequence='S', parts = {1,'unsigned'}})
  print('========= box.once executed =========')
end)