guard 'minitest' do
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r|^test/minitest_helper\.rb|)    { "test" }
end
