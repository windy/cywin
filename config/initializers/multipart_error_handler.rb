module Rack
  module Multipart
    class << self
      alias_method :original_parse_multipart, :parse_multipart
      def parse_multipart(env)
        begin
          original_parse_multipart(env)
        rescue EOFError => e
          nil
        end
      end
    end
  end
end