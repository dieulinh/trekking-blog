def markdownparser(markdown)

  markdown = markdown.strip
  headers = markdown.scan(/^#+\s/)
  return markdown unless headers[0]

  content = markdown.split(/^#+\s/)[1].strip()
  count = headers[0].count('#')
  return markdown if count == 0 || count > 6
  ["<h#{count}>", content, "</h#{count}>"].join
end

markdown = '# Header'
# will become <h1>Header</h1>
puts markdownparser('# Header') == '<h1>Header</h1>'
puts markdownparser('## Header')=='<h2>Header</h2>'
puts markdownparser('###### Header') == '<h6>Header</h6>'
puts markdownparser('#NoSpace')=='#NoSpace'
puts markdownparser('#NoSpace')
puts markdownparser("####### Snow White and the Seven Hashtags") == "####### Snow White and the Seven Hashtags"
