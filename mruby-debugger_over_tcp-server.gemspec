lib = File.expand_path("../serverlib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mruby-debugger_over_tcp/server/version"

Gem::Specification.new do |spec|
  spec.name          = "mundler"
  spec.version       = DebuggerOverTCP::Server::VERSION
  spec.authors       = ["Daniel Inkpen"]
  spec.email         = ["dan2552@gmail.com"]

  spec.summary       = %q{Server for mruby-debugger_over_tcp}
  spec.description   = %q{Server for mruby-debugger_over_tcp}
  spec.homepage      = "https://github.com/Dan2552/mruby-debugger_over_tcp"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["serverlib"]
end
