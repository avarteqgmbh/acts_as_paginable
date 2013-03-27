module Avarteq
  module Paginator
    extend ActiveSupport::Concern

    module ClassMethods

      # +options[:scopes]+:: List with paginable scopes
      def acts_as_paginable(options = {})

        # Accessors for class (static) variables
        cattr_accessor :paginable_scopes, :paginable_scope_prefix, :paginable_params_suffix

        self.paginable_scopes         = options[:scopes] || []
        self.paginable_scope_prefix   = options[:scope_prefix] || "scoped_by_"
        self.paginable_params_suffix  = options[:params_suffix] || ""
      end      

      #
      # == Parameter
      # * <tt>params</tt>     Parameters which should be try to paginate
      # * <tt>per_page</tt>   count of entries per page
      # * <tt>options</tt>    additional options for the will_paginate plugin
      def atq_paginate(params, per_page, options = {})
        result = chain_scopes(params, per_page)
        result.paginate(:page => params[:page], :per_page => per_page)

        will_paginate_arguments = options.merge({
          :page     => params[:page],
          :per_page => per_page
        })
        result.paginate(will_paginate_arguments)
      end

      # Chains scopes as given by params but does not invoke paginate.
      def chain_scopes(params, per_page)
        result = self
        self.paginable_scopes.each do |scope_name|
          params = params.with_indifferent_access
          param_name = scope_name.to_s + self.paginable_params_suffix.to_s          
          param_name = param_name.to_sym
          if params[param_name] && !params[param_name].blank? then
            args    = params[param_name]

            if self.column_names.include?(param_name.to_s)
              result = chain_attribute_query(result, param_name, args)
            else
              result = chain_scope_query(result, scope_name, args)
            end           
          end
        end
        result = result.order(params[:order]) if params[:order] && !params[:order].empty?
        result
      end # #chain_scopes

      def chain_attribute_query(result, scope_name, args)
        result  = result.where(scope_name.to_sym => args)
      end # #chain_attribute_query

      def chain_scope_query(result, scope_name, args)
        scope   = (self.paginable_scope_prefix + scope_name.to_s ).to_sym
        return result.send(scope, args)
      end # #chain_scope_query
    end # ClassMethods
  end # Paginator 
end # Avarteq

ActiveRecord::Base.send :include, Avarteq::Paginator

