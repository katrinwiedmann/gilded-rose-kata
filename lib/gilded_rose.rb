class GildedRose

  DEGRADATION_VALUE = 1
  EXPIRED_DEGRADATION_FACTOR = 2
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
    if item.quality + DEGRADATION_VALUE > MAX_QUALITY
      return
    end

    if expired?(item) && item.quality <= MAX_QUALITY - EXPIRED_DEGRADATION_FACTOR * DEGRADATION_VALUE
      item.quality = item.quality + EXPIRED_DEGRADATION_FACTOR * DEGRADATION_VALUE
    else
      item.quality = item.quality + DEGRADATION_VALUE
    end
  end

  def update_quality_of_backstage_pass(item)
    if item.quality >= MAX_QUALITY
      return
    end

    if item.sell_in < 5 && item.quality <= MAX_QUALITY - 3
      item.quality = item.quality + 3
    elsif item.sell_in < 10 && item.quality <= MAX_QUALITY - 2
      item.quality = item.quality + 2
    else
      item.quality = item.quality + 1
    end

    if expired?(item)
      item.quality = 0
    end
  end

  def update_quality_of_normal_item(item)
    if item.quality - DEGRADATION_VALUE <= MIN_QUALITY
      return
    end

    if expired?(item)
      item.quality = item.quality - EXPIRED_DEGRADATION_FACTOR * DEGRADATION_VALUE
    else
      item.quality = item.quality - DEGRADATION_VALUE
    end
  end

  def update_quality_of_conjured_item(item)
    if item.quality - DEGRADATION_VALUE < MIN_QUALITY
      return
    end

    if expired?(item)
      item.quality = item.quality - 2 * EXPIRED_DEGRADATION_FACTOR * DEGRADATION_VALUE
    else
      item.quality = item.quality - EXPIRED_DEGRADATION_FACTOR * DEGRADATION_VALUE
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

