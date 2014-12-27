#pretty time

#1
def to_pretty(b)
  a = (Time.now-b).to_i

  case a
    when 0 then 'just now'
    when 1 then 'a second ago'
    when 2..59 then a.to_s+' seconds ago'
    when 60..119 then 'a minute ago'
    when 120..3540 then (a/60).to_i.to_s+' minutes ago'
    when 3541..7100 then 'an hour ago'
    when 7101..82800 then ((a+99)/3600).to_i.to_s+' hours ago'
    when 82801..172000 then 'a day ago'
    when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+' days ago'
    when 518400..1036800 then 'a week ago'
    else ((a+180000)/(60*60*24*7)).to_i.to_s+' weeks ago'
  end
end


#2
def to_pretty(date)
  return 'just now' if (diff = Time.now.to_i - date.to_i) == 0
  format = [ 
    [7*24*60*60,'a','week'],
    [24*60*60,'a','day'],
    [60*60,'an','hour'],
    [60,'a','minute'],
    [1,'a','second']
  ].find { |f| diff >= f[0] }
  if diff/format[0] == 1
    format[1..2].join(' ')+' ago'
  else
    (diff/format[0]).to_s+' '+format[2]+'s ago'
  end
end


#3
def to_pretty(date)
  sec  = Time.now.to_i - date.to_i
  min  = sec  / 60
  hour = min  / 60
  day  = hour / 24
  week = day  /  7

  return week > 1 ? "#{week} weeks ago"  : 'a week ago'   if week > 0
  return day  > 1 ? "#{day} days ago"    : 'a day ago'    if day  > 0
  return hour > 1 ? "#{hour} hours ago"  : 'an hour ago'  if hour > 0
  return min  > 1 ? "#{min} minutes ago" : 'a minute ago' if min  > 0
  return sec  > 1 ? "#{sec} seconds ago" : 'a second ago' if sec  > 0

  return 'just now'
end


#4
TIME_VALUES = {'second' => 1, 'minute' => 60, 'hour' => 60*60, 
               'day' => 60*60*24, 'week' => 60*60*24*7}

def to_pretty(date)
  diff = (Time.now - date).to_i
  return 'just now' if diff < 1
  str, val = TIME_VALUES.select {|k,v| v <= diff}.max_by {|x| x[1]}
  (diff /= val) == 1 ? (str == 'hour' ? 'an' : 'a') + " #{str} ago" : "#{diff} #{str}s ago"
end


#mine
def to_pretty(date)
  a = Time.now.to_i - date.to_i
  if a == 0
    "just now"
  elsif a < 60
    a == 1 ? "a second ago" : a.to_s + " seconds ago"
  elsif a > 60 && a < 3600
    a < 120 ? "a minute ago" : (a / 60).to_f.floor.to_s + " minutes ago"
  elsif a > 3600 && a < 3600 * 24
    a < 7200 ? "an hour ago" : (a / 3600).to_f.floor.to_s + " hours ago"
  elsif a > 3600 * 24 && a < 3600 * 24*7
    a < 3600*48 ? "a day ago" : (a / 3600/ 24).to_f.floor.to_s + " days ago"
  else
    a < 3600*24*7*2 ? "a week ago" : (a / 3600/ 24 / 7 ).to_f.floor.to_s + " weeks ago"
  end
end