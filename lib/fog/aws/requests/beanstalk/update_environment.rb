module Fog
  module AWS
    class ElasticBeanstalk
      class Real

        require 'fog/aws/parsers/beanstalk/update_environment'

        # Updates the environment description, deploys a new application version, updates the configuration settings
        # to an entirely new configuration template, or updates select configuration option values in
        # the running environment.
        #
        # ==== Options
        # * ApplicationName<~String>: If specified, AWS Elastic Beanstalk restricts the returned descriptions
        #   to include only those that are associated with this application.
        # * EnvironmentIds
        # * EnvironmentNames
        # * IncludeDeleted
        # * IncludedDeletedBackTo
        # * VersionLabel<~String>:
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #
        # ==== See Also
        # http://docs.amazonwebservices.com/elasticbeanstalk/latest/api/API_CreateEnvironment.html
        #
        def update_environment(options={})
          if option_settings = options.delete('OptionSettings')
            options.merge!(AWS.indexed_param('OptionSettings.member.%d', [*option_settings]))
          end
          if options_to_remove = options.delete('OptionsToRemove')
            options.merge!(AWS.indexed_param('OptionsToRemove.member.%d', [*options_to_remove]))
          end
          request({
                      'Operation'    => 'UpdateEnvironment',
                      :parser     => Fog::Parsers::AWS::ElasticBeanstalk::UpdateEnvironment.new
                  }.merge(options))
        end
      end
    end
  end
end
