require 'benchmark'

STRING_HASH = { 'foo' => 'bar' }
SYMBOLE_HASH = { foo: 'bar' }
NUMBER_HASH = { 100 => 'bar' }
str = 'foo'
sym = :foo
num = 100

n = 100_000_000
Benchmark.bmbm do |x| # bmbm計測しますよメソッド
  x.report('String Key:') { n.times { STRING_HASH[str] } }
  x.report('Symbol Key:') { n.times { SYMBOLE_HASH[sym] } }
  x.report('Number Key:') { n.times { NUMBER_HASH[num] } }
end
