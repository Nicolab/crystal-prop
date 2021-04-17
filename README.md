# Prop

[![CI Status](https://github.com/Nicolab/crystal-prop/workflows/CI/badge.svg?branch=master)](https://github.com/Nicolab/crystal-prop/actions) [![GitHub release](https://img.shields.io/github/release/Nicolab/crystal-prop.svg)](https://github.com/Nicolab/crystal-prop/releases) [![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://nicolab.github.io/crystal-prop/)

Properties utilities for Crystal.

Mixin module that should be included in a class or a struct.
This module improves the std's accessor macros (`getter`, `getter!`, `getter?`, `property`, ...).

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
   dependencies:
     prop:
       github: nicolab/crystal-prop
```

2. Run `shards install`

## Usage

📘 [API doc](https://nicolab.github.io/crystal-prop/).

## Development

Install dev dependencies:

```sh
shards install
```

Run:

```sh
crystal spec
```

Clean before commit:

```sh
crystal tool format
./bin/ameba
```

## Contributing

1. Fork it (https://github.com/Nicolab/crystal-prop/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## LICENSE

[MIT](https://github.com/Nicolab/crystal-prop/blob/master/LICENSE) (c) 2021, Nicolas Talle.

## Author

| [![Nicolas Tallefourtane - Nicolab.net](https://www.gravatar.com/avatar/d7dd0f4769f3aa48a3ecb308f0b457fc?s=64)](https://github.com/sponsors/Nicolab) |
|---|
| [Nicolas Talle](https://github.com/sponsors/Nicolab) |
| [![Make a donation via Paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PGRH4ZXP36GUC) |
