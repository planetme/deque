local Dequeue = {}
Dequeue.__index = Dequeue

local function copyTab(tab)
	local newTab = {}

	for i, v in tab do
		newTab[i] = v
	end

	return newTab
end

function Dequeue:PushLeft(element)
	self[self._left] = element
	self._left -= 1
	self._size += 1
end

function Dequeue:PushRight(element)
	self[self._right] = element
	self._right += 1
	self._size += 1
end

function Dequeue:PopLeft()
	if self._size <= 0 then
        return
    end

    self._left += 1
	local popped = self[self._left]
	self[self._left] = nil
	self._size -= 1

	return popped
end

function Dequeue:PopRight()
	if self._size <= 0 then return end
	self._right -= 1
	local popped = self[self._right]
	self[self._right] = nil
	self._size -= 1
	return popped
end

function Dequeue:ToArray()
	if self._size <= 0 then return {} end
	local arr = table.create(self._size, nil)
	table.move(self, self._left + 1, self._right - 1, 1, arr)
	return arr
end

function Dequeue:Rightmost()
	return self[self._left + 1]
end

function Dequeue:Leftmost()
	return self[self._right - 1]
end

function Dequeue:Size()
	return self._size
end

function Dequeue.new(arr)
	local self = setmetatable({}, Dequeue)

	self._arr = copyTab(arr or {})
	self._size = #self._arr

	self._left = 0
	self._right = self._size + 1

	return self
end

return Dequeue