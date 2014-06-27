require_relative 'haml/filters/kramdown'

# Determines the output format.
Haml::Options.defaults[:format] = :xhtml

# The character that should wrap element attributes.
Haml::Options.defaults[:attr_wrapper] = '"'

# Properly indent or format the HTML output, makes viewing the source pleasant.
Haml::Options.defaults[:ugly] = false