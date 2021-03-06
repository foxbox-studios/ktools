module KTools
  module Tools
    class Spy
      def self.start(args)
        self.new(args).start
      end

      def initialize(args)
        @args = args
        @action = "#{args[0]} #{args[1]}"
        @subject = args[2]
        @env = args[3]
        @cfg = KTools::KDB.read
      end

      def start
        case @action
        when 'drop registry'
          puts "Deleting Docker Registry for #{@subject}..."
          puts ""

          registry_name = "#{@subject}-registry"

          Sh.ell("kubectl delete secret #{registry_name} -n foxbox")
        when 'create registry'
          puts "Creating Docker Registry for #{@subject}..."
          puts ""

          registry_name = "#{@subject}-registry"
          env_path = "#{@cfg["secrets"]}/#{@env}/#{@subject}"
          registry_file = "#{env_path}/create_registry.json"

          puts Sh.ellb!("kubectl create -f #{registry_file} -n foxbox")
        when 'drop config'
          puts "Deleting configMap for #{@subject}..."
          puts ""

          config_name = "#{@subject}-config-map"

          Sh.ell("kubectl delete configMap #{config_name} -n foxbox")
        when 'apply config'
          puts "Updating/Creating configMap for #{@subject}..."

          unless @env
            puts ""
            puts "Please, express the environment."
            puts "It can be 'production' or 'staging', like:"
            puts "$ kt spy apply config appslug staging"
            exit 1
          end

          env_path = "#{@cfg["secrets"]}/#{@env}/#{@subject}"
          config_map_file = "#{env_path}/config_map.yml"

          Sh.ell("kubectl apply -f #{config_map_file} -n foxbox")
        when 'drop ingress'
          puts "Deleting ingress for #{@subject}..."
          puts ""

          ingress_name = "#{@subject}-ingress"

          Sh.ell("kubectl delete ingress #{ingress_name} -n foxbox")
        when 'apply ingress'
          puts "Updating/Creating ingress for #{@subject}..."

          unless @env
            puts ""
            puts "Please, express the environment."
            puts "It can be 'production' or 'staging', like:"
            puts "$ kt spy apply ingress appslug staging"
            exit 1
          end

          env_path = "#{@cfg["secrets"]}/#{@env}/#{@subject}"
          ingress_file = "#{env_path}/ingress.yml"

          Sh.ell("kubectl apply -f #{ingress_file} -n foxbox")
        when 'drop all'
          puts "Deleting ALL Kubernetes resources of #{@subject}..."

          puts ""
          puts "Ctrl-C to cancel in 5 seconds..."
          sleep 5
          puts "Starting..."

          drop_cmd = <<~HEREDOC
            kubectl delete deployment #{@subject}-deployment -n foxbox &&
            kubectl delete configMap #{@subject}-config-map -n foxbox &&
            kubectl delete ingress #{@subject}-ingress -n foxbox &&
            kubectl delete service #{@subject}-service -n foxbox &&
            kubectl delete secret #{@subject}-registry -n foxbox
          HEREDOC

          Sh.ellb!(drop_cmd)
        else
          Help.display
        end
      end
    end
  end
end
