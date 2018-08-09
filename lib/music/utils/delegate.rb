module Music
  module Utils
    module Delegate
      def self.included(base)
        base.class.define_method :delegate do |*methods, to_object|
          methods.each do |method|
            base.define_method method do |*args|
              self.send(to_object[:to]).public_send(method, args)
            end
          end
        end
      end
    end
  end
end
