local function round(x, p)
  local power = 10 ^ (p or 0)
  return (x * power + 0.5 - (x * power + 0.5) % 1) / power
end

local function hex_to_rgba(hex)
  hex = hex:gsub('#', '')
  return {
    r = tonumber('0x' .. hex:sub(1, 2)),
    g = tonumber('0x' .. hex:sub(3, 4)),
    b = tonumber('0x' .. hex:sub(5, 6)),
    a = #hex == 8 and tonumber('0x' .. hex:sub(7, 8)) / 255 or nil,
  }
end

local function rgba_to_hex(obj)
  local r = obj.r or obj[1]
  local g = obj.g or obj[2]
  local b = obj.b or obj[3]
  local a = obj.a or 1
  local h = (obj.hashtag or obj[4]) and '#' or ''
  return h
    .. string.format('%02x%02x%02x', math.floor(r), math.floor(g), math.floor(b))
    --this part only shows the alpha channel if it's not 1
    .. (a ~= 1 and string.format('%02x', math.floor(a * 255)) or '')
end

local function rgb_to_hsl(obj)
  local r = obj.r or obj[1]
  local g = obj.g or obj[2]
  local b = obj.b or obj[3]

  local R, G, B = r / 255, g / 255, b / 255
  local max, min = math.max(R, G, B), math.min(R, G, B)
  local l, s, h

  l = (max + min) / 2

  if max == min then
    s = 0
    h = obj.h or obj[4] or 0
    return { h = 0, s = 0, l = l }
  end

  if l <= 0.5 then
    s = (max - min) / (max + min)
  else
    s = (max - min) / (2 - max - min)
  end

  if max == R then
    h = (G - B) / (max - min) * 60
  elseif max == G then
    h = (2.0 + (B - R) / (max - min)) * 60
  else
    h = (4.0 + (R - G) / (max - min)) * 60
  end

  if h ~= 360 then h = h % 360 end

  return { h = h, s = s, l = l }
end

local function hsl_to_rgb(obj)
  local h = obj.h or obj[1]
  local s = obj.s or obj[2]
  local l = obj.l or obj[3]

  local temp1, temp2, temp_r, temp_g, temp_b, temp_h

  if l <= 0.5 then
    temp1 = l * (s + 1)
  else
    temp1 = l + s - l * s
  end

  temp2 = l * 2 - temp1

  temp_h = h / 360

  temp_r = temp_h + 1 / 3
  temp_g = temp_h
  temp_b = temp_h - 1 / 3

  if temp_r ~= 1 then temp_r = temp_r % 1 end
  if temp_g ~= 1 then temp_g = temp_g % 1 end
  if temp_b ~= 1 then temp_b = temp_b % 1 end

  local rgb = {}

  for _, v in pairs({ { temp_r, 'r' }, { temp_g, 'g' }, { temp_b, 'b' } }) do
    if v[1] * 6 < 1 then
      rgb[v[2]] = temp2 + (temp1 - temp2) * v[1] * 6
    elseif v[1] * 2 < 1 then
      rgb[v[2]] = temp1
    elseif v[1] * 3 < 2 then
      rgb[v[2]] = temp2 + (temp1 - temp2) * (2 / 3 - v[1]) * 6
    else
      rgb[v[2]] = temp2
    end
  end

  return { r = round(rgb.r * 255), g = round(rgb.g * 255), b = round(rgb.b * 255) }
end

local M = {}

function M.changeHSL(color, hDelta, sDelta, lDelta)
  local rgb = hex_to_rgba(color)
  local hsl = rgb_to_hsl(rgb)

  local h = (hsl.h + hDelta) % 360.0
  local s = (hsl.s + sDelta) % 1.0
  local l = (hsl.l + lDelta) % 1.0

  return '#' .. rgba_to_hex(hsl_to_rgb({ h, s, l }))
end

return M
