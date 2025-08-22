local custom_text = ""

function Header(el)
  if el.level == 2 then  -- Changed to level 2 to match example
    local in_no_title = false
    if el.attr and el.attr.classes then
      for _, class in ipairs(el.attr.classes) do
        if class == "no-title" then
          in_no_title = true
          break
        end
      end
    end

    if not in_no_title and custom_text ~= "" then
      table.insert(el.content, 1, pandoc.RawInline('html', '<div class="custom-header" data-text="' .. custom_text .. '"></div>'))
    end
  end
  return el
end

function Div(el)
  if el.classes:includes("set-custom-header") then
    custom_text = pandoc.utils.stringify(el.content)
    return pandoc.Null()
  end
  return el
end
