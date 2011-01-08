module FlowPagination

  # FlowPagination renderer for (Mislav) WillPaginate Plugin
  class LinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

    # Render flow navigation
    def to_html
      flow_pagination = ''

      if self.current_page < self.last_page

        @template_params = @template.params.clone
        @template_params.delete(:controller)
        @template_params.delete(:action)
        @template_params.delete(:page)

        @url_params = {
          :controller => @template.controller_name,
          :action     => @template.action_name,
          :page       => self.next_page
        }

        stringified_merge @url_params, @template_params if @template.request.get?
        stringified_merge @url_params, @options[:params] if @options[:params]

        flow_pagination = @template.button_to_remote(
            @template.t('flow_pagination.button', :default => 'More'),
            :url    => @url_params.flatten_for_url,
            :method => @template.request.request_method)

      end

      @template.content_tag(:div, flow_pagination, :id => 'flow_pagination')

    end

    protected

      # Get current page number
      def current_page
        @collection.current_page
      end

      # Get last page number
      def last_page
        @last_page ||= WillPaginate::ViewHelpers.total_pages_for_collection(@collection)
      end

      # Get next page number
      def next_page
        @collection.next_page
      end

  end

end
