# frozen_string_literal: true

module View
  class Log < Snabberb::Component
    needs :log

    def render
      scroll_to_bottom = lambda do |vnode|
        elm = Native(vnode)['elm']
        elm.scrollTop = elm.scrollHeight
      end

      props = {
        key: 'log',
        hook: {
          postpatch: ->(_, vnode) { scroll_to_bottom.call(vnode) },
        },
        style: {
          overflow: 'auto',
          height: '200px',
          padding: '0.5rem',
          'background-color': 'lightgray',
          'word-break': 'break-word',
        },
      }

      lines = @log.map do |line|
        if line.is_a?(String)
          h(:div, line)
        elsif line.is_a?(Engine::Action::Message)
          h(:div, { style: { 'font-weight': 'bold' } }, "#{line.entity.name}: #{line.message}")
        end
      end

      h(:div, props, lines)
    end
  end
end
