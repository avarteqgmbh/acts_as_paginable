module Avarteq
  module Paginator

    def self.included(base)      
      base.extend(ClassMethods)
      
      # Named scope so that records can be ordered like this: MyClass.scoped_by_attr.order("id DESC")
      #base.send(:scope, :order, lambda {|order| { :order => order } })
    end

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
          param_name = scope_name.to_s + self.paginable_params_suffix.to_s          
          param_name = param_name.to_sym
          if params[param_name] && !params[param_name].blank? then
            args    = params[param_name]
            scope   = (self.paginable_scope_prefix + scope_name.to_s ).to_sym
            result  = result.send(scope, args)
          end
        end
        result = result.order(params[:order]) if params[:order] && !params[:order].empty?
        result
      end
    end
  end
end

ActiveRecord::Base.send :include, Avarteq::Paginator
