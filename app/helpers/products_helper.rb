module ProductsHelper
  #搜索关键字高亮显示
  def render_highlight_content(product, query_string)
    excerpt_cont = excerpt(product.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end
end
