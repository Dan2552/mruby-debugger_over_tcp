MRuby::Gem::Specification.new("mruby-irb_like_debugger") do |spec|
  spec.license = "MIT"
  spec.authors = "Daniel Inkpen"
  spec.add_dependency("mruby-sleep")
  spec.add_dependency("mruby-eval")
  spec.add_dependency("mruby-io")
  spec.add_dependency("mruby-bin-mruby")
  spec.add_dependency("mruby-kernel-ext")
  spec.add_dependency("mruby-simple_tcp_client", github: "Dan2552/mruby-simple_tcp_client", branch: "main")
end
