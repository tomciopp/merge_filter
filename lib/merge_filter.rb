require "merge_filter/version"

module MergeFilter
  attr_reader :filter

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def default_scope &block
      define_method :default_scope do
        if block_given?
          yield
        else
          fail NotImplementedError, "You need to supply a default_scope."
        end
      end
    end

    def filter_by column, &block
      define_method column do |*args|
        if block_given?
          yield args, default_scope
        else
          default_scope.where(column => args)
        end
      end
    end
  end

  def initialize filter = {}
    @filter = filter
  end

  def records
    filter.inject(default_scope) do |scope, (key, value)|
      scope.merge(__send__(key, value))
    end
  end
end
