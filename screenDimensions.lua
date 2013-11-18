



    --[[
        Corona SDK Device Screen Boundary Test
        R.Delia
        Stinky Kitties Studios
        www.stinkykitties.com
        12-11-2012
--]]

local screenDimensions = {}

--display.setStatusBar( display.HiddenStatusBar )

--print ("content scale y",display.contentScaleY)

local actual_width = display.pixelWidth * display.contentScaleX
local actual_height =display.pixelHeight* display.contentScaleY


--[[]
print("width",actual_width)
print("contentWidth", display.contentWidth)
print("height",actual_height)
print("contentHeight", display.contentHeight)
--]]

--ok, so 1/2 the excess will be on the top, and some will be on the bottom, lets calculate the top left

local left = 0 - ( actual_width - display.contentWidth) /2
local top = 0 - ( actual_height - display.contentHeight) /2

--print ("left, top:",left,top)


local right = display.contentWidth + (( actual_width - display.contentWidth) /2)
local bottom = display.contentHeight + ((actual_height - display.contentHeight) /2)
--print ("Bottom  Right:",BottomRightX,BottomRightY)

--DRAW Test

--[[]


local myRect = display.newRect(0, 0, 10, 10)
myRect:setReferencePoint(display.BottomRightReferencePoint)
myRect.x =right
myRect.y = bottom

local myRect2 = display.newRect(0, 0, 10, 10)
myRect2:setReferencePoint(display.TopLeftReferencePoint)
myRect2.x =left
myRect2.y = top

--print(myRect2.y,"y wtf")
--print(myRect2.x,"x wtf")
--]]


screenDimensions.top =top
screenDimensions.bottom =bottom
screenDimensions.left =left
screenDimensions.right =right

--[[] something odd happened here, and in landscape mode this is wrong...
screenDimensions.centerX = (screenDimensions.right - screenDimensions.left )/2
screenDimensions.centerY = (screenDimensions.bottom - screenDimensions.top) /2
--]]
screenDimensions.centerX = (screenDimensions.bottom - screenDimensions.top) /2
screenDimensions.centerY = (screenDimensions.right - screenDimensions.left )/2


print("Screen Dimension Dump:")
print("screenDimensions.top",screenDimensions.top)
print("screenDimensions.bottom",screenDimensions.bottom)
print("screenDimensions.left",screenDimensions.left )
print("screenDimensions.right",screenDimensions.right )
print("screenDimensions.centerX",screenDimensions.centerX)
print("screenDimensions.centerY",screenDimensions.centerY)



return screenDimensions
