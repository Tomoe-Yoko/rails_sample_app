module ApplicationHelper
  # ページごとの完全なタイトルを返す関数を作成
  def full_title(page_title = '') # 引数を取るけど、何もなければ空文字をデフォルトにする
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end

