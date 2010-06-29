require 'readline'
require 'pp'

module Google
  module Chrome
    class REPL
      def create_client(port)
        Google::Chrome::Client.open('localhost', port)
      end

      def initialize(port, extension_id)
        @client = create_client(port)
        @extension = @client.extension(extension_id)
      end


      def print_log_and_error(data)
        if data['error']
          puts data['error']['stack']
        elsif data['log']
          if data['log'].kind_of?(String)
            puts data['log']
          else
            pp data['log']
          end
        end
      end

      def print_response(data)
        if data.empty?
          puts 'nil'
        elsif data['success']
          pp data['success']
        else
          print_log_and_error(data)
        end
      end

      def eval_string(script)
        @extension.connect do |port|
          @extension.post(port, script)
          @client.read_all_response.each do |header, resp|
            print_log_and_error(resp['data'])
          end
        end
      end

      def eval_file(path)
        open(path) do |f|
          eval_string(f.read)
        end
      end

      def interactive
        @extension.connect do |port|
          puts "Protocol version: %s" % @client.server_version
          while ln = Readline.readline('> ', true)
            @extension.post(port, ln)
            @client.read_all_response.each do |header, resp|
              print_response(resp['data'])
            end
          end
        end
      end
    end
  end
end
