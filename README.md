# Debugger over TCP mruby gem (mrbgem)

TCP-based mruby CLI debugger.

Similar in usage to [mruby-irb_like_debugger](https://github.com/Dan2552/mruby-irb_like_debugger/blob/main/README.md) but over TCP, utilizing Ruby (CRuby) to run as an additional server for the CLI side.

Because of the separation of process for the CLI and that TCP socket, it can also be used as a non-blocking debugger. This is useful e.g. in the case of an application with a UI, to be able to debug without blocking the rendering thread.

Warning: By definition, this gem allows remote code execution.

# Installation

Put the following into your `Mundlefile`([?](https://github.com/Dan2552/mundler)) or `build_config.rb`:
``` ruby
conf.gem :git => 'https://github.com/Dan2552/mruby-debugger_over_tcp.git', :branch => 'main'
```

# Usage

Running the debugger server:

``` ruby

```

On the mruby app side:

``` ruby
# Blocking
eval(TCP_DEBUGGER)

# Or non-blocking
loop do
  # ...
  eval(NB_TCP_DEBUGGER)
  # ...
end
```

