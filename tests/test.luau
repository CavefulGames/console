local console = require('../src')

console.log('log', 1)
console.error('error', 2)
console.warn('warn', 3)
console.assert(false, 'assert', 4)
console.count('count')
console.countReset('count')
console.debug('debug', 5)
console.dir({ q = 'w' }, { colors = false })
console.log("This is the outer level %s", 2);
console.group('tt');
console.log("Level 2");
console.group('wwrr');
console.error("Level 3");
console.warn("More of level 3");
console.groupEnd();
console.groupEnd();
console.time()
console.timeLog()
console.timeEnd()
console.tree('test', { a = 't' })
