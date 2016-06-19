module WillPaginateHelper
  class WillPaginateJSLinkRenderer < WillPaginate::ActionView::LinkRenderer
    ELLIPSIS = "&hellip;"

    def prepare(collection, options, template)
      options[:params] ||= {}
      options[:params]['_'] = nil
      super(collection, options, template)
    end

    def to_html
      list_items = pagination.map do |item|
        case item
          when Fixnum
            page_number(item)
          else
            send(item)
        end
      end.join(@options[:link_separator])

      tag("ul", list_items, class: ul_class)
    end

    def container_attributes
      super.except(*[:link_options])
    end

    protected

    def page_number(page)
      link_options = @options[:link_options] || {}

      if page == current_page
        tag("li", tag("span", page), class: "active")
      else
        tag("li", link(page, page, link_options.merge(rel: rel_value(page))))
      end
    end

    def previous_or_next_page(page, text, classname)
      link_options = @options[:link_options] || {}

      if page
        tag("li", link(text, page, link_options), class: classname)
      else
        tag("li", tag("span", text), class: "%s disabled" % classname)
      end
    end

    def gap
      tag("li", tag("span", ELLIPSIS), class: "disabled")
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, "Trước", "prev")
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page(num, "Sau", "next")
    end

    def ul_class
      ["pagination", @options[:class]].compact.join(" ")
    end

    protected
    def link(text, target, attributes = {})
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end

      @template.link_to(target, attributes.merge(remote: true)) do
        text.to_s.html_safe
      end
    end


  end

  def js_will_paginate(collection, options = {})
    # will_paginate(collection, options.merge(renderer: WillPaginateHelper::WillPaginateJSLinkRenderer,previous_label: '<span class="glyph glyph-prev">Trước</span>', next_label: '<span class="glyph glyph-prev">Sau</span>'))
    options[:renderer] ||= WillPaginateHelper::WillPaginateJSLinkRenderer
    will_paginate(collection, options)
  end
end