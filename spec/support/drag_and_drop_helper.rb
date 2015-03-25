module DragAndDropHelper
  def position(selector)
    coordinates = page.evaluate_script("$('#{selector}').position()")
    OpenStruct.new(coordinates)
  end

  def height(selector)
    page.evaluate_script("$('#{selector}').height()")
  end

  def width(selector)
    page.evaluate_script("$('#{selector}').width()")
  end

  def drag_and_drop(source_selector, target_selector)
    source = find(source_selector)
    target = find(target_selector)
    source.drag_to(target)
  end

  def drag_and_drop_below(source_selector, target_selector)
    source_pos = position(source_selector)
    target_pos = position(target_selector)

    offset_x = 1
    offset_y = target_pos.top - source_pos.top + height(target_selector)/2 + 1

    find(source_selector).native.drag_by(offset_x, offset_y)
  end
end
