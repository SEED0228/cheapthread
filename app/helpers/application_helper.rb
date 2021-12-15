# frozen_string_literal: true

module ApplicationHelper
  def text_anker_to_link(text)
    text.scan(/>>(\d+)/).flatten.each do |n|
      text.gsub!(">>#{n}", "<a href=\##{n}>>>#{n}</a>")
    end
    text
  end
end
