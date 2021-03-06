import tarantool
from pprint import pprint

connection = tarantool.connect(host='127.0.0.1', port=3300, user='me', password='tsss')

space = connection.space('test')

for i in range(10):
	space.insert((None, i, 'hello'+str(i)))

print(space.select())

pprint(space.eval('return box.schema').data)

connection.eval('box.space.test:create_index("value", {unique = false, parts = {2,"unsigned"}})')

print(space.select(index=1))

space.update(2, [('=',2, 'bye')])

space.upsert((25,1,'hi'), [('=', 2, 'bye')])
space.upsert((1,1,'hi'), [('=', 2, 'bye')])

space.delete(1)
space.replace((3,111,'changed'))