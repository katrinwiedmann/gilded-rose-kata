class GildedRose

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_items
    @items.each do |item|
      update_days_left_to_sell(item)
      update_quality(item)
    end
  end

  def update_quality(item)
    case item.name
    when "Sulfuras, Hand of Ragnaros"
      return
    when "Aged Brie"
      update_quality_of_aged_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_quality_of_backstage_pass(item)
    when "Conjured Mana Cake"
      update_quality_of_conjured_item(item)
    else
      update_quality_of_normal_item(item)
    end
  end

  def update_quality_of_aged_brie(item)
    if item.quality >= MAX_QUALITY
      return
    end

    if expired?(item)
      increase_quality_by(2, item)
    else
      increase_quality_by(1, item)
    end
  end

  def update_quality_of_backstage_pass(item)
    if item.quality >= MAX_QUALITY
      return
    end

    if item.sell_in < 5
      increase_quality_by(3, item)
    elsif item.sell_in < 10
      increase_quality_by(2, item)
    else
      increase_quality_by(1, item)
    end

    if expired?(item)
      item.quality = 0
    end
  end

  def update_quality_of_normal_item(item)
    if item.quality <= MIN_QUALITY
      return
    end

    if expired?(item)
      decrease_quality_by(2, item)
    else
      decrease_quality_by(1, item)
    end
  end

  def update_quality_of_conjured_item(item)
    if item.quality <= MIN_QUALITY
      return
    end

    if expired?(item)
      decrease_quality_by(4, item)
    else
      decrease_quality_by(2, item)
    end
  end

  def decrease_quality_by(value, item)
    max_quality_to_decrease = item.quality - MIN_QUALITY
    if max_quality_to_decrease >= value
      item.quality = item.quality - value
    else
      item.quality = item.quality - max_quality_to_decrease
    end
  end

  def increase_quality_by(value, item)
    max_quality_to_increase = MAX_QUALITY - item.quality
    if max_quality_to_increase >= value
      item.quality = item.quality + value
    else
      item.quality = item.quality + max_quality_to_increase
    end
  end

  def update_days_left_to_sell(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
  end

  def expired?(item)
    item.sell_in < 0
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name:, sell_in:, quality:)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

