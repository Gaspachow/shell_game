# Change log

## [v0.10.1] - 2017-02-06

### Fixed
* Fix File namespacing

## [v0.10.0] - 2017-01-01

### Added
* Add :enable_color option for toggling colors support

### Changed
* Update pastel dependency version

## [v0.9.0] - 2016-12-20

### Added
* Add ability to paginate choices list for #select, #multi_select & #enum_select
  with :per_page, :page_info and :default options
* Add ability to switch through options in #select & #multi_select using the tab key

### Fixed
* Fix readers to accept multibyte characters reported by Jaehyun Shin(@keepcosmos)

## [v0.8.0] - 2016-11-29

### Added
* Add ability to publish custom key events for VIM keybindings customisations etc...

### Fixed
* Fix Reader#read_char to use Ruby internal buffers instead of direct system call by @kke(Kimmo Lehto)
* Fix issue with #ask required & validate checks to take into account required when validating values
* Fix bug with #read_keypress to handle function keys and meta navigation keys
* Fix issue with default messages not displaying for `range`, `required` and `validate`

## [v0.7.1] - 2016-08-07

### Fixed
* Fix Reader::Mode to include standard io library

## [v0.7.0] - 2016-07-17

### Added
* Add :interrupt_handler option to customise keyboard interrupt behaviour

### Changed
* Remove tty-platform dependency

### Fixed
* Fix Reader#read_keypress issue when handling interrupt signal by Ondrej Moravcik(@ondra-m)
* Fix raw & echo modes to use standard library support by Kim Burgestrand(@Burgestrand)

## [v0.6.0] - 2016-05-21

### Changed
* Upgrade tty-cursor dependency

### Fixed
* Fix issue with reader trapping signals by @kylekyle
* Fix expand to use new prev_line implementation

## [v0.5.0] - 2016-03-28

### Added
* Add ConfirmQuestion for #yes? & #no? calls
* Add ability to collect more than one answer through #collect call
* Add Choices#find_by for selecting choice based on attribute
* Add Prompt#expand for expanding key options
* Add :active_color, :help_color, :prefix options for customizing prompts display

### Changed
* Change Choice#from to allow for coersion of complex objects with keys
* Change Choices#pluck to search through object attributes
* Change #select :enum option help text to display actual numbers range

### Fixed
* Fix #no? to correctly ask negative question by @ondra-m
* Fix #ask :default option to handle nil or empty string
* Fix #multi_select :default option and color changing

## [v0.4.0] - 2016-02-08

### Added
* Add :enum option for #select & #multi_select to allow for numerical selection by @rtoshiro
* Add new key event types to KeyEvent
* Add #slider for picking values from range of numbers
* Add #enum_select for selecting option from enumerated list
* Add ability to configure error messages for #ask call
* Add new ConversionError type

### Changed
* Move #blank? to Utils
* Update pastel dependency

## [v0.3.0] - 2015-12-28

### Added
* Add prefix option to prompt to customize #ask, #select, #multi_select
* Add default printing to #ask
* Add #yes?/#no? boolean queries
* Add Evaluator and Result for validation checking to Question
* Add ability for #ask to display error messages on failed validation
* Add ability to specify in-built names for validation e.i. :email
* Add KeyEvent for keyboard events publishing to Reader
* Add #read_multiline to Reader
* Add :convert option for ask configuration
* Add ability to specify custom proc converters
* Add #ask_keypress to gather character input
* Add #ask_multiline to gather multiline input
* Add MaskedQuestion & #mask method for masking input stream characters

### Changed
* Change Reader#read_keypress to be robust and read correctly byte sequences
* Change Reader#getc to #read_line and extend arguments with echo option
* Extract cursor movement to dependency tty-cursor
* Change List & MultiList to subscribe to keyboard events
* Change to move mode inside reader namespace
* Remove Response & Error objects
* Remove :char option from #ask
* Change :read option to specify mode of reading out of :line, :multiline, :keypress
* Rename #confirm to #ok

## [v0.2.0] - 2015-11-23

### Added
* Add ability to select choice form list #select
* Add ability to select multiple options #multi_select
* Add :read option to #ask for reading specific type input

### Changed
* Change #ask api to be similar to #select and #multi_select behaviour
* Change #ask :argument option to be :required
* Remove :valid option from #ask as #select is a better solution

## [v0.1.0] - 2015-11-01

* Initial implementation and release

[v0.10.1]: https://github.com/piotrmurach/tty-prompt/compare/v0.10.0...v0.10.1
[v0.10.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.9.0...v0.10.0
[v0.9.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.8.0...v0.9.0
[v0.8.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.7.1...v0.8.0
[v0.7.1]: https://github.com/piotrmurach/tty-prompt/compare/v0.7.0...v0.7.1
[v0.7.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.6.0...v0.7.0
[v0.6.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/piotrmurach/tty-prompt/compare/v0.1.0
