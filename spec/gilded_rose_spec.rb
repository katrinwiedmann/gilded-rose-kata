require "spec_helper"

require_relative "../lib/gilded_rose"

RSpec.describe Item do
  context "Normal Item" do
    it "before sell date" do
      item = Item.new(name: "Normal Item", sell_in: 5, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 9)
    end

    it "very close to sell date" do
      item = Item.new(name: "Normal Item", sell_in: 1, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 0, quality: 9)
    end

    it "on sell date" do
      item = Item.new(name: "Normal Item", sell_in: 0, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 8)
    end

    it "after sell date" do
      item = Item.new(name: "Normal Item", sell_in: -10, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 8)
    end

    it "of zero quality" do
      item = Item.new(name: "Normal Item", sell_in: 5, quality: 0)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 0)
    end
  end

  context "Aged Brie" do
    it "before sell date" do
      item = Item.new(name: "Aged Brie", sell_in: 5, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 11)
    end

    it "with max quality" do
      item = Item.new(name: "Aged Brie", sell_in: 5, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 50)
    end

    it "on sell date" do
      item = Item.new(name: "Aged Brie", sell_in: 0, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 12)
    end

    it "on sell date near max quality" do
      item = Item.new(name: "Aged Brie", sell_in: 0, quality: 49)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 50)
    end

    it "on sell date with max quality" do
      item = Item.new(name: "Aged Brie", sell_in: 0, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 50)
    end

    it "after sell date" do
      item = Item.new(name: "Aged Brie", sell_in: -10, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 12)
    end

    it "after sell date with max quality" do
      item = Item.new(name: "Aged Brie", sell_in: -10, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 50)
    end
  end

  context "Sulfuras" do
    it "before sell date" do
      item = Item.new(name: "Sulfuras, Hand of Ragnaros", sell_in: 5, quality: 80)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 5, quality: 80)
    end

    it "on sell date" do
      item = Item.new(name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 0, quality: 80)
    end

    it "after sell date" do
      item = Item.new(name: "Sulfuras, Hand of Ragnaros", sell_in: -10, quality: 80)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -10, quality: 80)
    end
  end

  context "Backstage Pass" do
    it "long before sell date" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 11, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 10, quality: 11)
    end

    it "long before sell date at max quality" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 11, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 10, quality: 50)
    end

    it "medium close to sell date upper bound" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 9, quality: 12)
    end

    it "medium close to sell date upper bound at max quality" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 9, quality: 50)
    end

    it "medium close to sell date lower bound" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 6, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 5, quality: 12)
    end

    it "medium close to sell date lower bound at max quality" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 6, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 5, quality: 50)
    end

    it "very close to sell date upper bound" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 13)
    end

    it "very close to sell date upper bound at max quality" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 50)
    end

    it "very close to sell date lower bound" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 0, quality: 13)
    end

    it "very close to sell date lower bound at max quality" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 1, quality: 50)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 0, quality: 50)
    end

    it "on sell date" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      item = Item.new(name: "Backstage passes to a TAFKAL80ETC concert", sell_in: -10, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 0)
    end
  end

  context "Conjured Mana" do
    it "before sell date" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: 5, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 8)
    end

    it "before sell date at zero quality" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: 5, quality: 0)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: 4, quality: 0)
    end

    it "on sell date" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: 0, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 6)
    end

    it "on sell date at zero quality" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: 0, quality: 0)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: -10, quality: 10)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 6)
    end

    it "after sell date at zero quality" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: -10, quality: 0)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 0)
    end

    it "after sell date near zero quality" do
      item = Item.new(name: "Conjured Mana Cake", sell_in: -10, quality: 3)
      gilded_rose = GildedRose.new([item])

      gilded_rose.update_items

      expect(item).to have_attributes(sell_in: -11, quality: 0)
    end
  end
end
