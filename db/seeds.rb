categories = ["グルメ", "ショッピング", "遊ぶ・体験", "宿泊・温泉", "歴史", "自然・レジャー", "子どもと行きたい", "写真スポット", "その他"]
categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end
