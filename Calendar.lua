offset=0
local N={"January","February","March","April","May","June","July","August","September","October","November","December"}
local mon,yr,sd,dim,td=1,2026,0,30,0

function Calc()
  local n=os.date("*t")
  local m=n.month+offset
  local y=n.year+math.floor((m-1)/12)
  m=(m-1)%12+1
  mon,yr=m,y
  sd=os.date("*t",os.time{year=y,month=m,day=1}).wday-1
  dim=os.date("*t",os.time{year=y,month=m+1,day=0}).day
  td=(offset==0) and n.day or 0
end

function Initialize() offset=0 Calc() end

function Mark()
  if td>0 then
    local i=sd+td-1
    SKIN:Bang('!SetOption','MT','X',27+26*(i%7)-7)
    SKIN:Bang('!SetOption','MT','Y',82+24*math.floor(i/7)+9)
    SKIN:Bang('!SetOption','MT','Hidden','0')
  else
    SKIN:Bang('!SetOption','MT','Hidden','1')
  end
  SKIN:Bang('!UpdateMeter','MT')
end

function Update() Calc() Mark() return 1 end
function Title() if yr==tonumber(os.date("%Y")) then return N[mon] end return N[mon].." "..yr end
function Day(i) local d=i-sd if d>=1 and d<=dim then return d end return "" end
function Move(k) offset=offset+k Calc() Mark() SKIN:Bang('!UpdateMeter','*') SKIN:Bang('!Redraw') end
