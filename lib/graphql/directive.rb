# frozen_string_literal: true
module GraphQL
  # Directives are server-defined hooks for modifying execution.
  #
  # Two directives are included out-of-the-box:
  # - `@skip(if: ...)` Skips the tagged field if the value of `if` is true
  # - `@include(if: ...)` Includes the tagged field _only_ if `if` is true
  #
  class Directive
    include GraphQL::Define::InstanceDefinable
    accepts_definitions :locations, :name, :description, :arguments, argument: GraphQL::Define::AssignArgument

    attr_accessor :locations, :arguments, :name, :description
    ensure_defined(:locations, :arguments, :name, :description)

    LOCATIONS = [
      QUERY =                  :QUERY,
      MUTATION =               :MUTATION,
      SUBSCRIPTION =           :SUBSCRIPTION,
      FIELD =                  :FIELD,
      FRAGMENT_DEFINITION =    :FRAGMENT_DEFINITION,
      FRAGMENT_SPREAD =        :FRAGMENT_SPREAD,
      INLINE_FRAGMENT =        :INLINE_FRAGMENT,
      SCHEMA =                 :SCHEMA,
      SCALAR =                 :SCALAR,
      OBJECT =                 :OBJECT,
      FIELD_DEFINITION =       :FIELD_DEFINITION,
      ARGUMENT_DEFINITION =    :ARGUMENT_DEFINITION,
      INTERFACE =              :INTERFACE,
      UNION =                  :UNION,
      ENUM =                   :ENUM,
      ENUM_VALUE =             :ENUM_VALUE,
      INPUT_OBJECT =           :INPUT_OBJECT,
      INPUT_FIELD_DEFINITION = :INPUT_FIELD_DEFINITION,
    ]

    DEFAULT_DEPRECATION_REASON = 'No longer supported'
    LOCATION_DESCRIPTIONS = {
      QUERY:                    'Location adjacent to a query operation.',
      MUTATION:                 'Location adjacent to a mutation operation.',
      SUBSCRIPTION:             'Location adjacent to a subscription operation.',
      FIELD:                    'Location adjacent to a field.',
      FRAGMENT_DEFINITION:      'Location adjacent to a fragment definition.',
      FRAGMENT_SPREAD:          'Location adjacent to a fragment spread.',
      INLINE_FRAGMENT:          'Location adjacent to an inline fragment.',
      SCHEMA:                   'Location adjacent to a schema definition.',
      SCALAR:                   'Location adjacent to a scalar definition.',
      OBJECT:                   'Location adjacent to an object type definition.',
      FIELD_DEFINITION:         'Location adjacent to a field definition.',
      ARGUMENT_DEFINITION:      'Location adjacent to an argument definition.',
      INTERFACE:                'Location adjacent to an interface definition.',
      UNION:                    'Location adjacent to a union definition.',
      ENUM:                     'Location adjacent to an enum definition.',
      ENUM_VALUE:               'Location adjacent to an enum value definition.',
      INPUT_OBJECT:             'Location adjacent to an input object type definition.',
      INPUT_FIELD_DEFINITION:   'Location adjacent to an input object field definition.',
    }

    def initialize
      @arguments = {}
    end

    def to_s
      "<GraphQL::Directive #{name}>"
    end

    def on_field?
      locations.include?(FIELD)
    end

    def on_fragment?
      locations.include?(FRAGMENT_SPREAD) && locations.include?(INLINE_FRAGMENT)
    end

    def on_operation?
      locations.include?(QUERY) && locations.include?(MUTATION) && locations.include?(SUBSCRIPTION)
    end
  end
end

require "graphql/directive/include_directive"
require "graphql/directive/skip_directive"
require "graphql/directive/deprecated_directive"
