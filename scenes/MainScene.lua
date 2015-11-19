
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   local scene=cc.uiloader:load("MainScene.csb"):addTo(self)

   display.addSpriteFrames("20002_stand.plist", "20002_stand.png")
	self.zhao = display.newSprite("20002_stand_0000.png")
	self.zhao:setScale(1.2, 1.5)
	self.zhao:pos(200, 280)
	self:addChild(self.zhao)

	local frames = display.newFrames("20002_stand_00%02d.png", 1, 7)
	local animation = display.newAnimation(frames, 0.2)
	self.zhao:playAnimationForever(animation)


	local back = cc.ui.UIPushButton.new({normal="back.png",pressed="back.png"})
	back:onButtonClicked(function ( event )
		-- local scene1 = require("app.scenes.")
		-- display.replaceScene(new())
		print("关闭背包")
	end)
	back:pos(935, 615)
	self:add(back)

	--生命值
	self.bloodbg = display.newSprite("bloodbg.png")
	self.bloodbg:setScale(0.65,0.35)
	self.bloodbg:pos(755,582 )
	 self:addChild(self.bloodbg)

	local slider = cc.ui.UISlider.new(display.LEFT_TO_RIGHT,{
			bar = "blood.png", 
		},{
			min = 0,                    
			max = 100,                   
			
		})
	slider:onSliderValueChanged(function ( event )
		printf("%.2f", event.value)
	end)
	slider:setSliderSize(210, 10);
	slider:pos(650, 577)
	self:add(slider);
	self._slider = slider

	--攻击力
	local damage = cc.ui.UILabel.new({text="攻击",size=17,color=cc.c3b(246,246,246)})
	:pos(650,559 )
	:addTo(self)


	--防御
	local fangyu = cc.ui.UILabel.new({text="防御",size=17,color=cc.c3b(246,246,246)})
	:pos(650,535 )
	:addTo(self)

	--速度
	local speed = cc.ui.UILabel.new({text="速度",size=17,color=cc.c3b(246,246,246)})
	:pos(650,510 )
	:addTo(self)

	--exp
	self.expbg = display.newSprite("bloodbg.png")
	self.expbg:setScale(0.65,0.35)
	self.expbg:pos(755,488 )
	self:addChild(self.expbg)

	local slider1 = cc.ui.UISlider.new(display.LEFT_TO_RIGHT,{
			bar = "12.png", 
		},{
			min = 0,                    
			max = 100,                   
			
		})
	slider1:onSliderValueChanged(function ( event )
		printf("%.2f", event.value)
	end)
	slider1:setSliderSize(210, 13);
	slider1:pos(650, 482)
	self:add(slider1);
	self._slider = slider1



	self:wupinlan()
	--self.t={}
	--穿着装备栏
		--添加武器
		self.wuqi = display.newSprite("equip1.png")
		self.wuqi:pos(53, 528)
		self:add(self.wuqi)


		 --帽子
		self.maozi = display.newSprite("equip27.png")
		self.maozi :pos(452, 528)
		self:add(self.maozi)

		--盔甲
		self.kuijia = display.newSprite("equip7.png")
		self.kuijia :pos(53, 390)
		self:add(self.kuijia)

		--护臂
		self.hubi = display.newSprite("equip13.png")
		self.hubi:pos(452, 390)
		self:add(self.hubi)

		--腰带
		self.yaodai = display.newSprite("equip17.png")
		self.yaodai :pos(53, 252)
		self:add(self.yaodai)

		--鞋子
		self.xiezi = display.newSprite("equip32.png")
		self.xiezi :pos(452, 252)
		self:add(self.xiezi)

end

function MainScene:wupinlan(  )--物品栏
	-- local bg = cc.LayerColor:create(cc.c4b(241,30,44,255),280,317)
	--  self:add(bg)
	--  bg:setPosition(582,100)

	 self.pageView=cc.ui.UIPageView.new({
	 	viewRect=cc.rect(581,100,280,317),
	 	column=4,row=4,
	 	padding={left = 10, right = 10, top = 20, bottom = 20},
	 	columnSpace=5,rowSpace=15
	 	})
	 self.pageView:setTouchSwallowEnabled(true)
	 j=10
	 self.pageView:onTouch(function ( event )
	 	if j>10 then
	 		self:removeChildByTag(j)
	 	end
	 	j=j+1
	 	local anode = display.newNode()
		anode:pos(480, 320)
		anode:setTag(j)
		anode:addTo(self,3)
		--装备属性面板
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode)	
		--穿上装备
		local zhuagnbei = cc.ui.UIPushButton.new({normal="zhuangshang.png",pressed="zhuangshang.png"})
		:pos(40,-40)
		:addTo(anode,4)
		:onButtonClicked(function ( event )

			
			anode:removeFromParent()
		end)
		--分解装备
		local fenjie = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode,4)
		:onButtonClicked(function ( event )
			

			anode:removeFromParent()
		end)
	 	--dump(event)
	 	print(event.pageIdx,event.itemIdx)

	 end)
	 self:add(self.pageView)

	 self.t={}
	 for i=2,48 do
	 	local item = self.pageView:newItem()
	 	self.png = cc.LayerColor:create(cc.c4b(160,160,160,255))
	 	self.png:setTouchSwallowEnabled(false)
	 	--local png2 = display.newSprite("yxbk.png")
	 	--png2:onButtonClicked(callback)
	 	 	
		
	 	self.png:setContentSize(64,64)
	 	item:addChild(self.png)
	 	self.pageView:addItem(item)
	 	self.t[#self.t+1]=self.png


	 	self.wupin=display.newSprite(string.format("equip%d.png",i))
	 	self.wupin:align(display.CENTER, self.png:getContentSize().width/2, self.png:getContentSize().height/2)
		self.wupin:addTo(self.png)

	 end
	 self.pageView:reload()
	
end
	
function MainScene:onEnter()
	--卸下武器
	self.wuqi:setTouchEnabled(true)
	self.wuqi:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		--dump(event)
		if event.name == "began" then
			print("开始")
			return true
		elseif event.name == "ended" then
			print("结束")

		local anode1 = display.newNode()
		anode1:pos(480, 320)
		anode1:addTo(self,3)
		
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode1)	
	
		--卸下装备
		local fenjie1 = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode1,4)
		:onButtonClicked(function ( event )
			self.wuqi:removeFromParent()
			anode1:removeFromParent()--移除节点

			self.wuqi=display.newSprite(string.format("equip1.png"))
			self.wuqi=align(display.CENTER, self.png:getContentSize().width/2, self.png:getContentSize().height/2)
			self.wuqi:addTo(self.png)

		end)
		end

	end)
	--卸下帽子
	self.maozi:setTouchEnabled(true)
	self.maozi:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		dump(event)
		if event.name == "began" then
			print("开始")
			return true
		elseif event.name == "ended" then
			print("结束")

		local anode2 = display.newNode()
		anode2:pos(480, 320)
		anode2:addTo(self,3)
		
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode2)	
	
		--卸下装备
		local fenjie2 = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode2,4)
		:onButtonClicked(function ( event )
			self.maozi:removeFromParent()
			anode2:removeFromParent()--移除节点


		end)
		end

	end)

	--卸下盔甲
	self.kuijia:setTouchEnabled(true)
	self.kuijia:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		dump(event)
		if event.name == "began" then
			print("开始")
			return true
		elseif event.name == "ended" then
			print("结束")
		local anode3 = display.newNode()
		anode3:pos(480, 320)
		anode3:addTo(self,3)
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode3)	
		--卸下装备
		local fenjie3 = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode3,4)
		:onButtonClicked(function ( event )	
			self.kuijia:removeFromParent()
			anode3:removeFromParent()--移除节点
		end)
		end
	end)

	--卸下护臂
	self.hubi:setTouchEnabled(true)
	self.hubi:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		dump(event)
		if event.name == "began" then
			print("开始")
			return true
		elseif event.name == "ended" then
			print("结束")
		local anode4 = display.newNode()
		anode4:pos(480, 320)
		anode4:addTo(self,3)
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode4)
		--卸下装备
		local fenjie4 = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode4,4)
		:onButtonClicked(function ( event )	
			self.hubi:removeFromParent()
			anode4:removeFromParent()--移除节点
	end)
	end
	end)

	--卸下腰带
	self.yaodai:setTouchEnabled(true)
	self.yaodai:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		dump(event)
		if event.name == "began" then
			print("开始")
			return true
		elseif event.name == "ended" then
			print("结束")
		local anode5 = display.newNode()
		anode5:pos(480, 320)
		anode5:addTo(self,3)
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode5)	
		--卸下装备
		local fenjie5 = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode5,4)
		:onButtonClicked(function ( event )
			self.yaodai:removeFromParent()
			anode5:removeFromParent()--移除节点

		end)
		end

	end)

	--卸下鞋子
	self.xiezi:setTouchEnabled(true)
	self.xiezi:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
		dump(event)
		if event.name == "began" then
			print("开始")
			return true
		elseif event.name == "ended" then
			print("结束")
		local anode6 = display.newNode()
		anode6:pos(480, 320)
		anode6:addTo(self,3)
		local shuxing=display.newSprite("map_04.png")
		:pos(0,0)
		:addTo(anode6)	
		--卸下装备
		local fenjie3 = cc.ui.UIPushButton.new({normal="xiexia.png",pressed="xiexia.png"})
		:pos(-40,-40)
		:addTo(anode6,4)
		:onButtonClicked(function ( event )
			self.xiezi:removeFromParent()
			anode6:removeFromParent()--移除节点
		end)
		end

	end)

end

function MainScene:onExit()
end

return MainScene
