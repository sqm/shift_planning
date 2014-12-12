class ShiftPlanning::ApiModule
  attr_reader :name

  def initialize(connection, name)
    @name = name
    @connection = connection
  end

  class << self
    %w[get create update delete].each do |method|
      define_method(method) do |endpoint, params = []|
        define_method("#{ method }_#{ endpoint }") do |*args|
          if params.length > args.length
            raise ArgumentError.new("Wrong number of arguments (#{ args.length } for #{ params.length })")
          end
          params_hash = {}
          params.each_with_index { |p, i| params_hash[p] = args[i] }
          params_hash = args[params.length].merge(params_hash) if args[params.length]
          @connection.call(method.upcase, "#{ name }.#{ endpoint }", params_hash)
        end
      end
    end
  end
end
