module ActiveAdmin
  module Views
    class Footer < Component
      def build(param)
        super :id => "footer"
        super :style => "text-align: left;"
        div do
          small "Powered by Gallery Proofing #{Date.today.year}"
        end
      end
    end
  end
end
