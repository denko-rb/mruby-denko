MRuby::Gem::Specification.new('picoruby-stubs') do |spec|
  spec.license = 'MIT'
  spec.authors = 'vickash'
  spec.version = '0.0.0'

  spec.rbfiles += Dir.glob("#{dir}/mrblib/*")
end
